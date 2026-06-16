# gen-context-snapshot.ps1 - Genera _context_.md con el estado actual del vault
# IMPORTANTE: Usar -Encoding UTF8 en TODOS los Get-Content para evitar corrupción de caracteres
$vault = "$env:USERPROFILE\Documents\Obsidian Vault"
$opencode = "$vault\opencode"
$output = "$opencode\_context_.md"

# 1. Preferencia más reciente (usar UTF8 explícitamente)
$latestPref = Get-ChildItem "$opencode\preferences\*.md" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
$prefContent = if ($latestPref) { Get-Content -Encoding UTF8 $latestPref.FullName -Raw } else { "Sin preferencias`n" }

# 2. Proyectos activos
$contextFiles = Get-ChildItem "$opencode\context\*.md" | Sort-Object LastWriteTime -Descending
$contextList = if ($contextFiles) { $contextFiles | ForEach-Object { "- [[context/$($_.BaseName)]]`n" } } else { "- Sin proyectos`n" }

# 3. Activity de hoy
$today = Get-Date -Format "yyyy-MM-dd"
$activityFile = Get-ChildItem "$opencode\activity\*.md" | Where-Object { $_.BaseName -match "^$today" } | Sort-Object LastWriteTime -Descending | Select-Object -First 1
$activityContent = if ($activityFile) { Get-Content -Encoding UTF8 $activityFile.FullName -Raw } else { "Sin actividad hoy`n" }

# 4. Últimas 5 sesiones
$sessions = Get-ChildItem "$opencode\sessions\*.md" | Sort-Object LastWriteTime -Descending | Select-Object -First 5
$sessionList = $sessions | ForEach-Object { "- [[sessions/$($_.BaseName)]]`n" }

# 5. Tags inline - excluye headings (##) y colores hex (#XXXXXX)
$tagPattern = '(?<=[\s(]|^)(#(?:opencode|mcp|obsidian|automation|fix|skill|sesion|refactor|docx|trello|openrouter|config|reporte|preferencia|organizacion|token|vault|script|task|github|vercel|sentry|context7|supabase|azure|moodle|ia|diagrama|imagen|logo|notebooklm|slide|pdf|presentacion|tarea|workflow|decision|aprendizaje|index|neurona|zettelkasten|atomicidad|consolidacion|grafo|release|plugin|playwright|npm|pnpm|nextjs|react|vite|python|powershell|css|html|js|ts|sql|api|cli|configuracion|inicio|consulta|scheduled|screenshot))'
$tagsOutput = Get-ChildItem "$opencode" -Recurse -Filter "*.md" | ForEach-Object {
    $c = Get-Content -Encoding UTF8 $_.FullName -Raw
    if ($c -match $tagPattern) { [regex]::Matches($c, $tagPattern).Value }
} | Group-Object | Sort-Object Count -Descending | Select-Object -First 15 | ForEach-Object { "- $($_.Name) ($($_.Count))`n" }

# 6. Stats
$noteCount = (Get-ChildItem "$opencode" -Recurse -Filter "*.md").Count

$content = @"
# Contexto Actual
> Generado: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') | Total notas: $noteCount

## Preferencias activas
$prefContent

## Proyectos activos
$contextList

## Actividad de hoy
$activityContent

## Ultimas sesiones
$sessionList

## Tags mas frecuentes
$tagsOutput
"@

[System.IO.File]::WriteAllText($output, $content, [System.Text.UTF8Encoding]::new($false))
Write-Output "Contexto actualizado: $output"