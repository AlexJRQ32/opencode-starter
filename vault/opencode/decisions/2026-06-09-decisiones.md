# Decisiones - 09 de junio de 2026

## Decisi?n: Fix ghost PowerShell window (Moodle?Trello)
- **Problema:** La tarea programada `MoodleToTrello` mostraba una ventana fantasma de PowerShell
- **Causa ra?z:** Task Scheduler con `LogonType: Interactive` + `powershell.exe` directo causa flash
- **Soluci?n:** VBS launcher con `WScript.Shell.Run` + `WindowStyle = 0` (hidden total)
- **Archivo:** `~/.config/opencode/scripts/moodle-to-trello-launcher.vbs`
- **Relacionado:** [[2026-06]]

## Decisi?n: Higgsfield MCP descartado
- **Problema:** OAuth no funcionaba con opencode, intentos agotados
- **Decisi?n:** Eliminado del opencode.jsonc
- **Lecci?n:** Higgsfield solo acepta OAuth v?a browser; su server remoto no es compatible con el flujo OAuth de opencode
- **Relacionado:** [[2026-06]]

## Decisi?n: Estructura neuronal del vault (Zettelkasten h?brido)
- **Contexto:** Vault desorganizado, notas sin conexi?n central
- **Opci?n:** Zettelkasten modificado ? `_index_.md` (soma) ? `YYYY-MM.md` (dendritas) ? notas individuales (sinapsis). Conexiones solo al mes, nunca entre notas.
- **Principios ZK aplicados:** Atomicidad (1 nota = 1 concepto), identificador (`YYYY-MM-DD-descripcion.md`), clasificaci?n por carpeta (sessions/decisions/learnings/etc.), enlaces jer?rquicos al ?ndice mensual
- **Modificaci?n ZK:** En vez de red de enlaces libres, todo converge al mes ?ndice. El grafo de Obsidian muestra forma de neurona.
- **Implementaci?n:** Hub central, ?ndices mensuales, 9 notas hu?rfanas movidas, backlinks a?adidos
- **Relacionado:** [[2026-06]]
