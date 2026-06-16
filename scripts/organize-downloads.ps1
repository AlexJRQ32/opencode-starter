# organize-downloads.ps1 — Clasifica archivos en Downloads por tipo
$downloads = "$env:USERPROFILE\Downloads"
$log = "$env:USERPROFILE\.config\opencode\scripts\organize-downloads.log"
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# Reglas: carpeta destino → @(extensiones)
$rules = @{
    "Documentos"  = @(".pdf", ".docx", ".doc", ".txt", ".xlsx", ".xls", ".pptx", ".ppt", ".csv", ".md")
    "Imagenes"    = @(".jpg", ".jpeg", ".png", ".gif", ".bmp", ".svg", ".webp", ".ico")
    "Videos"      = @(".mp4", ".avi", ".mkv", ".mov", ".wmv", ".flv")
    "Musica"      = @(".mp3", ".wav", ".flac", ".aac", ".ogg")
    "Programas"   = @(".exe", ".msi", ".bat", ".ps1", ".sh", ".dmg", ".AppImage")
    "Comprimidos" = @(".zip", ".rar", ".7z", ".tar", ".gz", ".iso")
    "Codigo"      = @(".js", ".ts", ".tsx", ".jsx", ".py", ".html", ".css", ".json", ".xml", ".yaml", ".yml", ".sql", ".c", ".cpp", ".h", ".java", ".cs", ".rb", ".go", ".rs")
    "Torrents"    = @(".torrent")
    "Otros"       = @()
}

try {
    $moved = 0
    foreach ($file in Get-ChildItem -LiteralPath $downloads -File) {
        $ext = $file.Extension.ToLower()
        $destFolder = $null

        foreach ($folder in $rules.Keys) {
            if ($ext -in $rules[$folder]) { $destFolder = $folder; break }
        }
        if (-not $destFolder) { $destFolder = "Otros" }

        $destPath = "$downloads\$destFolder"
        if (-not (Test-Path -LiteralPath $destPath)) { New-Item -ItemType Directory -Path $destPath -Force | Out-Null }

        $destFile = "$destPath\$($file.Name)"
        $counter = 1
        while (Test-Path -LiteralPath $destFile) {
            $base = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
            $destFile = "$destPath\$base($counter)$ext"
            $counter++
        }

        Move-Item -LiteralPath $file.FullName -Destination $destFile -Force
        $moved++
    }

    if ($moved -gt 0) { "$date OK: $moved archivos organizados" | Out-File -FilePath $log -Encoding UTF8 -Append }
} catch {
    "$date ERROR: $_" | Out-File -FilePath $log -Encoding UTF8 -Append
}
