# clipboard-screenshot.ps1 — Guarda capturas del clipboard automaticamente
# EJECUTAR CON: powershell -STA -WindowStyle Hidden -File esta-ruta.ps1

Add-Type -AssemblyName System.Windows.Forms
Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Text;
public class WinAPI {
    [DllImport("user32.dll")]
    public static extern IntPtr GetForegroundWindow();
    [DllImport("user32.dll")]
    public static extern int GetWindowText(IntPtr hWnd, StringBuilder text, int count);
}
"@

$outputDir = "$env:USERPROFILE\OneDrive\Documentos\Screenshots"
if (-not (Test-Path $outputDir)) { New-Item -ItemType Directory -Path $outputDir -Force | Out-Null }

$log = "$env:USERPROFILE\.config\opencode\scripts\clipboard-screenshot.log"

function Get-ActiveWindowTitle {
    $hwnd = [WinAPI]::GetForegroundWindow()
    $sb = New-Object System.Text.StringBuilder 256
    [WinAPI]::GetWindowText($hwnd, $sb, 256)
    return $sb.ToString().Trim()
}

function Get-AppName($title) {
    # Extrae nombre de app del titulo de ventana
    $known = @{
        "Chrome" = "Chrome"; "Edge" = "Edge"; "Firefox" = "Firefox"
        "VSCode" = "VSCode"; "Code" = "VSCode"
        "PowerShell" = "PowerShell"; "Terminal" = "Terminal"
        "Outlook" = "Outlook"
        "Word" = "Word"; "Excel" = "Excel"; "PowerPoint" = "PowerPoint"
        "Acrobat" = "Acrobat"
        "Discord" = "Discord"
        "Notion" = "Notion"
        "Spotify" = "Spotify"
        "Slack" = "Slack"
    }
    foreach ($k in $known.Keys) { if ($title -match $k) { return $known[$k] } }

    # Limpia caracteres no validos para nombre archivo
    $clean = $title -replace '[^\w\s-]', '' -replace '\s+', ' '
    if ($clean.Length -gt 30) { $clean = $clean.Substring(0, 30) }
    if (-not $clean) { $clean = "Unknown" }
    return $clean.Trim()
}

$lastHash = $null
$count = 0
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
"$date INICIADO: Clipboard watcher activo" | Out-File -FilePath $log -Encoding UTF8 -Append

while ($true) {
    try {
        $img = [System.Windows.Forms.Clipboard]::GetImage()
        if ($img) {
            $ms = New-Object System.IO.MemoryStream
            $img.Save($ms, [System.Drawing.Imaging.ImageFormat]::Png)
            $hash = [System.BitConverter]::ToString((New-Object System.Security.Cryptography.MD5CryptoServiceProvider).ComputeHash($ms))

            if ($hash -ne $lastHash) {
                $lastHash = $hash
                $app = Get-AppName (Get-ActiveWindowTitle)
                $timestamp = Get-Date -Format "yyyy-MM-dd_HHmmss"
                $filename = "Screenshot_$timestamp" + "_$app.png"
                $path = "$outputDir\$filename"

                $img.Save($path, [System.Drawing.Imaging.ImageFormat]::Png)

                $count++
                $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
                "$date GUARDADO: $filename (desde: $app)" | Out-File -FilePath $log -Encoding UTF8 -Append
            }

            $ms.Dispose()
            $img.Dispose()
        }
    } catch {
        # Error silencioso — puede pasar si clipboard esta bloqueado por otra app
    }
    Start-Sleep -Seconds 2
}
