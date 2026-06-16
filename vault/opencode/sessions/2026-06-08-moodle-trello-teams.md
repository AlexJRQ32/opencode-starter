# Moodle ? Trello fix + Teams integraci?n

## Context
- Part of: [Sesi?n 08](2026-06-08-sesion.md), secci?n Moodle?Trello

### Moodle ? Trello (fix)
- **Script**: `~/.config/opencode/scripts/moodle-to-trello.ps1`
- **Problema**: Duplicados porque Moodle cambia UIDs entre exportaciones iCal
- **Fix**: 
  - Dedup por UID + nombre normalizado (sin prefijo \"Vencimiento de \", lowercase)
  - Coincidencia parcial por si Moodle cambia ligeramente el t?tulo
  - Filtro por fecha: solo tareas hoy o futuras
  - Tambi?n revisa tarjetas archivadas en Trello (`filter=all`)
- **Tarea programada**: Reemplazada de VBS a PowerShell directo, 4x d?a (00, 06, 12, 18)

### Teams integraci?n (pendiente)
- **Script**: `~/.config/opencode/scripts/teams-to-trello.ps1`
- **Problema**: Universidad bloquea consentimiento de apps en Graph API
- **Alternativa**: Power Automate + conector Planner + Trello (o email-to-board)
- Se cre? un prompt de Copilot para armarlo

### Azure DevOps MCP
- Configurado en opencode.jsonc para org `DesarrolloAplicacionesScrumTeam`
- Pendiente: reiniciar opencode para activar tools

- Tags: `#moodle` `#trello` `#teams` `#powershell` `#graph-api`
- Relacionado: [[2026-06]]