# moodle-to-trello.ps1 — Sincroniza tareas de Moodle (iCal) a Trello
$icalUrl = "https://moodle.uh.ac.cr/calendar/export_execute.php?userid=73568&authtoken=2a0e2a62b399b656c9ac0256f64eb1a87ce735e0&preset_what=all&preset_time=recentupcoming"
$trelloKey = "413db047f1ce5328aab29528471455f5"
$trelloToken = "ATTA83b5b38b88169b9d95a69f53761fd3186db949f0e00342b63b648819e5667d5b42A9CC9E"
$trelloListId = "69d860f5b37a700c1cd85b1b"
$log = "$env:USERPROFILE\.config\opencode\scripts\moodle-trello.log"
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

function NormalizeName($n) {
    $n = $n.Trim().ToLower()
    # Remove common prefixes that Moodle might add/remove
    $n = $n -replace '^vencimiento\s+de\s+', ''
    # Collapse whitespace
    $n = $n -replace '\s+', ' '
    return $n
}

try {
    # 1. Fetch iCal as bytes -> UTF-8 string
    $wc = New-Object System.Net.WebClient
    $bytes = $wc.DownloadData($icalUrl)
    $icalText = [System.Text.Encoding]::UTF8.GetString($bytes)

    # 2. Unfold RFC 5545 continuation lines (starts with space/tab)
    $lines = $icalText -split "`r`n|`n"
    $unfolded = @()
    $i = 0
    while ($i -lt $lines.Count) {
        $line = $lines[$i].TrimEnd([char]13)
        while ($i + 1 -lt $lines.Count -and $lines[$i+1][0] -in @(' ', [char]9)) {
            $i++
            $line += $lines[$i].Trim()
        }
        $unfolded += $line
        $i++
    }

    # 3. Parse VEVENT blocks
    $events = @()
    $current = @{}
    foreach ($line in $unfolded) {
        $trimmed = $line.Trim()
        if ($trimmed -eq "BEGIN:VEVENT") { $current = @{}; continue }
        if ($trimmed -eq "END:VEVENT") {
            if ($current.SUMMARY) { $events += $current }
            $current = @{}; continue
        }
        if ($trimmed -match "^(SUMMARY|DESCRIPTION|DTSTART|DTEND|UID|CATEGORIES)(?:;[^:]*)?:(.+)$") {
            $current[$matches[1]] = $matches[2].Trim()
        }
    }

    if ($events.Count -eq 0) { "$date SKIP: no se encontraron eventos en iCal" | Out-File -FilePath $log -Encoding UTF8 -Append; exit }

    # 4. Get existing Trello cards (active + archived) to avoid duplicates
    $existingCards = Invoke-RestMethod -Uri "https://api.trello.com/1/lists/$trelloListId/cards?key=$trelloKey&token=$trelloToken&filter=all" -TimeoutSec 10
    $existingUids = @{}
    $existingNames = @{}
    $existingCards | ForEach-Object {
        $normalized = NormalizeName($_.name)
        $existingNames[$normalized] = $_.id
        if ($_.desc -match "UID:\s*(\S+)") { $existingUids[$matches[1]] = $true }
    }

    # 5. Create cards for new events
    function New-TrelloCard($name, $desc, $due) {
        $payload = @{ idList = $trelloListId; name = $name; key = $trelloKey; token = $trelloToken }
        if ($desc) { $payload.desc = $desc }
        if ($due)  { $payload.due = $due }
        $json = $payload | ConvertTo-Json
        $jsonBytes = [System.Text.Encoding]::UTF8.GetBytes($json)
        $req = [System.Net.WebRequest]::Create("https://api.trello.com/1/cards")
        $req.Method = "POST"
        $req.ContentType = "application/json; charset=utf-8"
        $req.ContentLength = $jsonBytes.Length
        $reqStream = $req.GetRequestStream()
        $reqStream.Write($jsonBytes, 0, $jsonBytes.Length)
        $reqStream.Close()
        $resp = $req.GetResponse()
        $reader = New-Object System.IO.StreamReader($resp.GetResponseStream(), [System.Text.Encoding]::UTF8)
        $reader.ReadToEnd() | Out-Null
        $reader.Close()
        $resp.Close()
    }

    $today = [datetime]::Now.Date
    $created = 0
    $skippedPast = 0
    foreach ($ev in $events) {
        $name = $ev.SUMMARY

        # Parse event date
        $eventDate = $null
        if ($ev.DTSTART) {
            try { $eventDate = [datetime]::ParseExact($ev.DTSTART, "yyyyMMddTHHmmssZ", $null).Date } catch {
                try { $eventDate = [datetime]::ParseExact($ev.DTSTART, "yyyyMMdd", $null).Date } catch {}
            }
        }

        # Skip past events
        if ($eventDate -and $eventDate -lt $today) {
            "$date PASADA: $name ($($eventDate.ToString('yyyy-MM-dd')))" | Out-File -FilePath $log -Encoding UTF8 -Append
            $skippedPast++
            continue
        }

        $normalized = NormalizeName($name)

        # Skip if UID already exists
        if ($existingUids.ContainsKey($ev.UID)) {
            "$date DUPLICADA (UID): $name" | Out-File -FilePath $log -Encoding UTF8 -Append
            continue
        }

        # Skip if normalized name already exists
        if ($existingNames.ContainsKey($normalized)) {
            "$date DUPLICADA (nombre): $name" | Out-File -FilePath $log -Encoding UTF8 -Append
            continue
        }

        # Also check partial match: existing name contains normalized or vice versa
        $partialMatch = $false
        foreach ($en in $existingNames.Keys) {
            if ($en -eq $normalized) { continue }
            if ($normalized.Length -gt 5 -and $en.Length -gt 5) {
                if ($en.Contains($normalized) -or $normalized.Contains($en)) {
                    $partialMatch = $true
                    "$date DUPLICADA (parcial: '$en' ≈ '$normalized'): $name" | Out-File -FilePath $log -Encoding UTF8 -Append
                    break
                }
            }
        }
        if ($partialMatch) { continue }

        $desc = "Origen: Moodle`nUID: $($ev.UID)"
        if ($ev.DESCRIPTION) {
            $cleanDesc = $ev.DESCRIPTION -replace '\\n', "`n" -replace '\\', ''
            if ($cleanDesc.Length -gt 3800) { $cleanDesc = $cleanDesc.Substring(0, 3800) + "..." }
            $desc += "`n`n$cleanDesc"
        }
        $due = $null
        if ($ev.DTSTART) {
            try { $due = [datetime]::ParseExact($ev.DTSTART, "yyyyMMddTHHmmssZ", $null).ToString("yyyy-MM-ddTHH:mm:ss.fffZ") } catch {
                try { $due = [datetime]::ParseExact($ev.DTSTART, "yyyyMMdd", $null).ToString("yyyy-MM-ddTHH:mm:ss.fffZ") } catch {}
            }
        }
        New-TrelloCard -name $name -desc $desc -due $due
        $created++
        "$date CREADA: $name" | Out-File -FilePath $log -Encoding UTF8 -Append
    }

    "$date RESUMEN: $created tarjetas creadas de $($events.Count) eventos ($skippedPast pasadas omitidas)" | Out-File -FilePath $log -Encoding UTF8 -Append
    Write-Output "OK: $created tarjetas creadas"

} catch {
    $err = "$date ERROR: $_"
    $err | Out-File -FilePath $log -Encoding UTF8 -Append
    Write-Output $err
}
