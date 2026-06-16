# Soluci?n: ANSI codes al pegar en terminal PowerShell

## Problema
Al copiar texto de OpenCode (o cualquier CLI con colores) y pegarlo en PowerShell/Windows Terminal, los c?digos ANSI se copian al portapapeles y al pegar se interpretan como comandos de formato, desordenando la pantalla.

## Soluci?n aplicada
Creaci?n de `~/Documents/WindowsPowerShell/profile.ps1` con:

1. **`Clear-ANSI`** ? funci?n que limpia c?digos ANSI del portapapeles
2. **`Ctrl+Shift+V`** ? hotkey PSReadLine que pega limpiando ANSI autom?ticamente

### Regex usado
```powershell
$ansiPattern = '\x1B\[[0-9;]*[a-zA-Z]|\x1B\].*?(?:\x1B\\|\x07)'
```
Cubre:
- CSI: `\e[31m`, `\e[0m`, `\e[1;32m`, etc.
- OSC: `\e]0;title\a`, `\e]8;;url\e\\`, etc.

## Notas t?cnicas
- PowerShell 5.1 no soporta bien UTF-8 sin BOM para caracteres Unicode en strings
- PSReadLine `Set-PSReadlineKeyHandler` + `[Microsoft.PowerShell.PSConsoleReadLine]::Insert()` es la forma correcta de insertar texto limpio
- `Get-Clipboard -Raw -TextFormatType UnicodeText` obtiene texto sin formato enriquecido

- Tags: `#powershell` `#terminal` `#ansi` `#clipboard` `#fix`
- Relacionado: [[2026-06]]


## Tambi?n se habl? de

- **OpenCode Desktop**: no es editor de c?digo, es la misma interfaz CLI en ventana propia. No requiere proyecto para conversar.
- **Modelos de razonamiento** recomendados para Desktop: DeepSeek V4 Flash (razonamiento/c?digo), Ring 2.6 1T (1T params), Nemotron 3 Ultra (1M contexto)
- **Persistencia Obsidian en Desktop**: S? funciona porque Desktop usa los mismos archivos (`~/.config/opencode/opencode.jsonc` con MCP mcpvault + `AGENTS.md` con reglas de guardado). El modelo debe soportar herramientas MCP.
- **Perfil PowerShell** ya carga autom?ticamente al abrir cualquier PowerShell.

- Tags: `#opencode-desktop` `#modelos` `#obsidian` `#persistencia`
