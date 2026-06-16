function Get-FreeUdemyCourses {
    $url = "https://www.udemyfreebies.com/"
    $cacheFile = "$env:USERPROFILE\.config\opencode\scripts\.cache-cursos.json"
    $outputFile = "$env:USERPROFILE\.config\opencode\scripts\ultimos-cursos.txt"

    try {
        $wc = New-Object System.Net.WebClient
        $wc.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64)")
        $wc.Encoding = [System.Text.Encoding]::UTF8
        $html = $wc.DownloadString($url)
    } catch {
        Set-Content -Path $outputFile -Value "[ERROR] No se pudo conectar: $_" -Encoding UTF8
        return
    }

    $courses = @()
    $blocks = [regex]::Matches($html, '<div class="theme-block">(.*?)</div>\s*</div>\s*</div>', [System.Text.RegularExpressions.RegexOptions]::Singleline)

    foreach ($b in $blocks) {
        $block = $b.Groups[1].Value

        $dateM = [regex]::Match($block, '<small[^>]*>(.*?)</small>')
        $date = if ($dateM.Success) { $dateM.Groups[1].Value.Trim() } else { "" }

        $titleM = [regex]::Match($block, '<h4><a[^>]*>(.*?)</a></h4>')
        $title = if ($titleM.Success) { $titleM.Groups[1].Value.Trim() } else { "" }

        $urlM = [regex]::Match($block, '<a href="(.*?)" class="theme-img')
        $courseUrl = if ($urlM.Success) { $urlM.Groups[1].Value.Trim() } else { "" }
        if (-not $courseUrl) {
            $urlM = [regex]::Match($block, '<h4><a href="(.*?)">')
            $courseUrl = if ($urlM.Success) { $urlM.Groups[1].Value.Trim() } else { "" }
        }

        $catM = [regex]::Match($block, '<div class="coupon-specility"><p>(.*?)</p></div>')
        $category = if ($catM.Success) { $catM.Groups[1].Value.Trim() } else { "" }

        $rateM = [regex]::Match($block, 'Rate:\s*([\d.]+)\s*/\s*(\d+)')
        $rating = if ($rateM.Success) { $rateM.Groups[1].Value } else { "N/A" }
        $reviews = if ($rateM.Success) { $rateM.Groups[2].Value } else { "0" }

        $enrollM = [regex]::Match($block, 'Enroll:\s*(\d+)')
        $enroll = if ($enrollM.Success) { $enrollM.Groups[1].Value } else { "0" }

        if ($title -and $title -ne "") {
            $courses += @{
                date = $date
                title = $title
                url = $courseUrl
                category = $category
                rating = $rating
                reviews = $reviews
                enroll = $enroll
            }
        }
    }

    if ($courses.Count -eq 0) {
        Set-Content -Path $outputFile -Value "[INFO] No se encontraron cursos en la pagina." -Encoding UTF8
        return
    }

    $known = @()
    if (Test-Path $cacheFile) {
        try {
            $known = Get-Content $cacheFile -Encoding UTF8 | ConvertFrom-Json
        } catch { $known = @() }
    }

    $knownTitles = @($known | ForEach-Object { $_.title })
    $newCourses = @($courses | Where-Object { $_.title -notin $knownTitles })

    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.AppendLine("=== CURSOS GRATIS UDEMY ===")
    [void]$sb.AppendLine("Fecha: $(Get-Date -Format 'yyyy-MM-dd HH:mm')")
    [void]$sb.AppendLine("Total cursos en pagina: $($courses.Count)")

    if ($newCourses.Count -gt 0) {
        [void]$sb.AppendLine("")
        [void]$sb.AppendLine("<<< NUEVOS CURSOS ($($newCourses.Count)) >>>")
        [void]$sb.AppendLine("")
        $i = 1
        foreach ($c in $newCourses) {
            [void]$sb.AppendLine("$i. $($c.title)")
            [void]$sb.AppendLine("   Categoria: $($c.category) | Rating: $($c.rating) | Inscritos: $($c.enroll)")
            if ($c.url -match "^https?://") {
                [void]$sb.AppendLine("   Link: $($c.url)")
            } else {
                [void]$sb.AppendLine("   Link: https://www.udemyfreebies.com$($c.url)")
            }
            [void]$sb.AppendLine("")
            $i++
        }
    } else {
        [void]$sb.AppendLine("")
        [void]$sb.AppendLine("No hay cursos nuevos desde la ultima revision.")
        [void]$sb.AppendLine("")
        [void]$sb.AppendLine("Ultimos disponibles:")
        $i = 1
        foreach ($c in $courses | Select-Object -First 5) {
            [void]$sb.AppendLine("$i. $($c.title)")
            $i++
        }
    }

    [void]$sb.AppendLine("---")
    [void]$sb.AppendLine("Fuente: udemyfreebies.com")

    Set-Content -Path $outputFile -Value $sb.ToString() -Encoding UTF8
    $courses | ConvertTo-Json -Compress | Set-Content $cacheFile -Encoding UTF8
}

Get-FreeUdemyCourses
