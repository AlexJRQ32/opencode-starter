# health-check.ps1 — Vault Health Check for Obsidian opencode vault
# Checks: broken wikilinks, orphan files, missing frontmatter

param(
    [string]$Vault = "C:\Users\roble\Documents\Obsidian Vault\opencode",
    [switch]$Fix
)

$issues = 0
$notes = @{}
$allFiles = @()

# Collect all notes
Get-ChildItem -LiteralPath $Vault -Recurse -Filter "*.md" | Where { !$_.PSIsContainer } | ForEach-Object {
    $rel = $_.FullName.Substring($Vault.Length + 1) -replace '\\', '/'
    $relNoExt = $rel -replace '\.md$', ''
    $notes[$relNoExt] = $_.FullName
    $allFiles += @{ Path = $_.FullName; Rel = $rel; RelNoExt = $relNoExt }
}

# Check 1: Broken wikilinks
Write-Host "=== Broken Wikilinks ===" -ForegroundColor Cyan
foreach ($f in $allFiles) {
    $c = Get-Content $f.Path -Raw -Encoding UTF8
    $links = [regex]::Matches($c, '\[\[([^\]\|#\\]+)')
    foreach ($link in $links) {
        $target = $link.Groups[1].Value.Trim()
        if ($target.StartsWith("http")) { continue }
        if (-not $notes.ContainsKey($target)) {
            Write-Host "  BROKEN: $($f.Rel) -> [[$target]]" -ForegroundColor Red
            $issues++
        }
    }
}
if ($issues -eq 0) { Write-Host "  (none)" -ForegroundColor Green }

# Check 2: Orphan files (no incoming links from other files)
Write-Host "=== Orphan Files (no incoming links) ===" -ForegroundColor Cyan
$orphans = @()
foreach ($f in $allFiles) {
    if ($f.Rel -eq '_index_.md') { continue }
    $hasIncoming = $false
    foreach ($other in $allFiles) {
        if ($other.Path -eq $f.Path) { continue }
        $c = Get-Content $other.Path -Raw -Encoding UTF8
        if ($c -match [regex]::Escape("[[$($f.RelNoExt)")) { $hasIncoming = $true; break }
    }
    if (-not $hasIncoming) { $orphans += $f.Rel }
}
if ($orphans.Count -eq 0) { Write-Host "  (none)" -ForegroundColor Green }
else { foreach ($o in $orphans) { Write-Host "  ORPHAN: $o" -ForegroundColor Yellow; $issues++ } }

# Check 3: Missing frontmatter
Write-Host "=== Missing Frontmatter ===" -ForegroundColor Cyan
$noFm = @()
foreach ($f in $allFiles) {
    $c = Get-Content $f.Path -Raw -Encoding UTF8
    if (-not ($c -match '^---\s*\n')) { $noFm += $f.Rel }
}
if ($noFm.Count -eq 0) { Write-Host "  (none)" -ForegroundColor Green }
else { foreach ($n in $noFm) { Write-Host "  NO FM: $n" -ForegroundColor Yellow; $issues++ } }

# Summary
Write-Host "`n=== Summary ===" -ForegroundColor Cyan
if ($issues -eq 0) { Write-Host "  All clear!" -ForegroundColor Green }
else { Write-Host "  $issues issue(s) found" -ForegroundColor Yellow }
