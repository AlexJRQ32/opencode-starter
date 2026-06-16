# cleanup-screenshots.ps1 — Elimina screenshots antiguos
$dir = "$env:USERPROFILE\OneDrive\Documentos\Screenshots"
$days = 3
$log = "$env:USERPROFILE\.config\opencode\scripts\cleanup-screenshots.log"

if (-not (Test-Path $dir)) { exit }

$cutoff = (Get-Date).AddDays(-$days)
$deleted = 0

Get-ChildItem $dir -Filter "*.png" | Where-Object { $_.LastWriteTime -lt $cutoff } | ForEach-Object {
    Remove-Item $_.FullName -Force
    $deleted++
}

$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
"$date LIMPIEZA: $deleted archivos eliminados (>$days días)" | Out-File -FilePath $log -Encoding UTF8 -Append
