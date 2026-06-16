$taskName = "OpenCode-BuscarCursosGratis"
$scriptPath = "$env:USERPROFILE\.config\opencode\scripts\buscar-cursos-gratis.ps1"

# Check if task already exists
$existing = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
if ($existing) {
    Write-Host "La tarea '$taskName' ya existe. Se actualizara."
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
}

$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`""
$trigger = New-ScheduledTaskTrigger -Daily -At 08:00
$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries
$principal = New-ScheduledTaskPrincipal -UserId "$env:USERDOMAIN\$env:USERNAME" -LogonType S4U -RunLevel Limited

Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $settings -Principal $principal -Force

Write-Host ""
Write-Host "Tarea '$taskName' creada exitosamente."
Write-Host "Se ejecutara todos los dias a las 08:00."
Write-Host "El script guarda resultados en: $env:USERPROFILE\.config\opencode\scripts\ultimos-cursos.txt"
