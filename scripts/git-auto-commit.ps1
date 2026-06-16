# git-auto-commit.ps1 — Auto-commit vault changes
$vault = "$env:USERPROFILE\Documents\Obsidian Vault"
$log = "$env:USERPROFILE\.config\opencode\scripts\git-auto.log"
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
try {
    Set-Location -LiteralPath $vault
    $status = & "git" status --porcelain 2>&1
    if ($status) {
        & "git" add -A 2>&1 | Out-Null
        & "git" commit -m "Auto-commit $((Get-Date -Format 'yyyy-MM-dd HH:mm'))" 2>&1 | Out-Null
        & "git" push 2>&1 | Out-Null
        "$date OK: committed and pushed $($status.Count) changes" | Out-File -FilePath $log -Encoding UTF8 -Append
    } else {
        "$date SKIP: no changes" | Out-File -FilePath $log -Encoding UTF8 -Append
    }
} catch {
    "$date ERROR: $_" | Out-File -FilePath $log -Encoding UTF8 -Append
}
