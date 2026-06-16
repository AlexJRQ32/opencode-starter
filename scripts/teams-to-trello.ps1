# teams-to-trello.ps1 — Trae tareas de Microsoft Teams (Planner + To Do) a Trello
$trelloKey = "413db047f1ce5328aab29528471455f5"
$trelloToken = "ATTA83b5b38b88169b9d95a69f53761fd3186db949f0e00342b63b648819e5667d5b42A9CC9E"
$trelloListId = "69d860f5b37a700c1cd85b1b"
$log = "$env:USERPROFILE\.config\opencode\scripts\moodle-trello.log"
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

function NormalizeName($n) {
    $n = $n.Trim().ToLower()
    $n = $n -replace '\s+', ' '
    return $n
}

try {
    # 1. Connect to Microsoft Graph (Device Code)
    Write-Output "Conectando a Microsoft Graph..."
    Connect-MgGraph -Scopes "Tasks.Read", "Tasks.ReadWrite", "Group.Read.All" -UseDeviceCode -NoWelcome
    Write-Output "Conectado."

    # 2. Get existing Trello cards (active + archived) for dedup
    $existingCards = Invoke-RestMethod -Uri "https://api.trello.com/1/lists/$trelloListId/cards?key=$trelloKey&token=$trelloToken&filter=all" -TimeoutSec 10
    $existingNames = @{}
    $existingCards | ForEach-Object { $n = NormalizeName($_.name); $existingNames[$n] = $true }

    $created = 0
    $skipped = 0
    $today = [datetime]::Now.Date

    # 3. Fetch tasks from Microsoft To Do
    try {
        $todoLists = Get-MgUserTodoList -UserId "me" -All
        foreach ($list in $todoLists) {
            $tasks = Get-MgUserTodoListTask -UserId "me" -TodoTaskListId $list.Id -All
            foreach ($task in $tasks) {
                $name = $task.Title
                if (-not $name) { continue }

                $taskDate = $null
                if ($task.DueDateTime) {
                    try { $taskDate = [datetime]::Parse($task.DueDateTime.DateTime).Date } catch {}
                }
                if ($taskDate -and $taskDate -lt $today) {
                    "$date [Teams/ToDo] PASADA: $name ($($taskDate.ToString('yyyy-MM-dd')))" | Out-File -FilePath $log -Encoding UTF8 -Append
                    $skipped++; continue
                }
                $norm = NormalizeName($name)
                if ($existingNames.ContainsKey($norm)) {
                    "$date [Teams/ToDo] DUPLICADA: $name" | Out-File -FilePath $log -Encoding UTF8 -Append
                    $skipped++; continue
                }

                $desc = "Origen: Microsoft To Do ($($list.DisplayName))"
                $due = $null
                if ($task.DueDateTime) {
                    try { $due = [datetime]::Parse($task.DueDateTime.DateTime).ToString("yyyy-MM-ddTHH:mm:ss.fffZ") } catch {}
                }

                $payload = @{ idList = $trelloListId; name = $name; key = $trelloKey; token = $trelloToken; desc = $desc }
                if ($due) { $payload.due = $due }
                Invoke-RestMethod -Uri "https://api.trello.com/1/cards" -Method Post -Body $payload | Out-Null
                $created++
                "$date [Teams/ToDo] CREADA: $name" | Out-File -FilePath $log -Encoding UTF8 -Append
                $existingNames[$norm] = $true
            }
        }
    } catch {
        "$date [Teams/ToDo] AVISO: $_" | Out-File -FilePath $log -Encoding UTF8 -Append
    }

    # 4. Fetch tasks from Planner
    try {
        $plans = Get-MgUserPlannerPlan -UserId "me" -All
        foreach ($plan in $plans) {
            $tasks = Get-MgPlannerPlanTask -PlannerPlanId $plan.Id -All
            foreach ($task in $tasks) {
                $name = $task.Title
                if (-not $name) { continue }

                $taskDate = $null
                if ($task.DueDateTime) {
                    try { $taskDate = [datetime]::Parse($task.DueDateTime.DateTime).Date } catch {}
                }
                if ($taskDate -and $taskDate -lt $today) {
                    "$date [Teams/Planner] PASADA: $name ($($taskDate.ToString('yyyy-MM-dd')))" | Out-File -FilePath $log -Encoding UTF8 -Append
                    $skipped++; continue
                }
                $norm = NormalizeName($name)
                if ($existingNames.ContainsKey($norm)) {
                    "$date [Teams/Planner] DUPLICADA: $name" | Out-File -FilePath $log -Encoding UTF8 -Append
                    $skipped++; continue
                }

                $bucket = $null
                try { $bucket = Get-MgPlannerBucket -PlannerBucketId $task.BucketId } catch {}
                $desc = "Origen: Microsoft Planner ($($plan.Title))"
                if ($bucket) { $desc += "`nBucket: $($bucket.Name)" }

                $due = $null
                if ($task.DueDateTime) {
                    try { $due = [datetime]::Parse($task.DueDateTime.DateTime).ToString("yyyy-MM-ddTHH:mm:ss.fffZ") } catch {}
                }

                $payload = @{ idList = $trelloListId; name = $name; key = $trelloKey; token = $trelloToken; desc = $desc }
                if ($due) { $payload.due = $due }
                Invoke-RestMethod -Uri "https://api.trello.com/1/cards" -Method Post -Body $payload | Out-Null
                $created++
                "$date [Teams/Planner] CREADA: $name" | Out-File -FilePath $log -Encoding UTF8 -Append
                $existingNames[$norm] = $true
            }
        }
    } catch {
        "$date [Teams/Planner] AVISO: $_" | Out-File -FilePath $log -Encoding UTF8 -Append
    }

    Disconnect-MgGraph | Out-Null
    "$date [Teams] RESUMEN: $created creadas, $skipped omitidas" | Out-File -FilePath $log -Encoding UTF8 -Append
    Write-Output "Teams OK: $created tarjetas creadas, $skipped omitidas"

} catch {
    $err = "$date [Teams] ERROR: $_"
    $err | Out-File -FilePath $log -Encoding UTF8 -Append
    Write-Output $err
}