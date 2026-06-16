?---
tags:
  - opencode
  - script
  - health
  - obsidian
---
# Health Check del Vault

Script: `scripts/health-check.ps1`

Detecta:
- Wikilinks rotos (links a notas que no existen)
- Archivos hu?rfanos (notas sin links entrantes)
- Frontmatter faltante

Uso:
```powershell
powershell -ExecutionPolicy Bypass -File "scripts/health-check.ps1"
```

**Relacionado:** activity/2026-06-06-activity#04:42
**Relacionado:** [[2026-06]]
**Tags:** `#script` `#health` `#obsidian`
