# gen-report-daily.ps1 — Scheduled task entry point
$script = "$env:USERPROFILE\.config\opencode\scripts\gen-report-daily.mjs"
$log = "$env:USERPROFILE\.config\opencode\scripts\gen-report.log"
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
try {
$result = & "node" $script 2>&1
"$date $result" | Out-File -FilePath $log -Encoding UTF8 -Append
} catch {
    "$date ERROR: $_" | Out-File -FilePath $log -Encoding UTF8 -Append
}
