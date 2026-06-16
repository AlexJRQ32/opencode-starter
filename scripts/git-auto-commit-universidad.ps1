# git-auto-commit-universidad.ps1 — Weekly auto-commit for university backup
$repo = "$env:USERPROFILE\OneDrive\Documentos\Universidad Hispanoamerica - Archivos"
$log = "$env:USERPROFILE\.config\opencode\scripts\git-auto-uni.log"
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
try {
    Set-Location -LiteralPath $repo
    $status = & "git" status --porcelain 2>&1
    if ($status) {
        $count = ($status | Measure-Object).Length
        & "git" add -A 2>&1 | Out-Null
        & "git" commit -m "Respaldo Semanal - $(Get-Date -Format 'yyyy-MM-dd')" 2>&1 | Out-Null
        & "git" push 2>&1 | Out-Null
        "$date OK: $count cambios commiteados y pusheados" | Out-File -FilePath $log -Encoding UTF8 -Append
    } else {
        "$date SKIP: sin cambios" | Out-File -FilePath $log -Encoding UTF8 -Append
    }
} catch {
    "$date ERROR: $_" | Out-File -FilePath $log -Encoding UTF8 -Append
}
