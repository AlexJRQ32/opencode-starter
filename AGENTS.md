# Memoria Persistente con Obsidian

Vault: `~/Documents/Obsidian Vault` (ajustar ruta local)

## REGLAS OBLIGATORIAS

### 🔴 Al iniciar cada interacción
1. `mcpvault_search(query="<tema>")` — buscar contexto
2. `mcpvault_read_note(path="opencode/preferences/YYYY-MM-DD-preferencias.md")` — cargar preferencias
3. `mcpvault_list_files(path="opencode/context")` — ver proyectos activos
4. `mcpvault_list_files(path="opencode/activity")` — ver feed del día

### 🔴 Guardado automático tras CADA acción (async, sin esperar)
| Carpeta | Cuándo |
|---------|--------|
| `sessions/` | **Siempre** |
| `decisions/` | Si hay decisión técnica |
| `learnings/` | Si hay algo nuevo aprendido |
| `preferences/` | Si se detecta preferencia |
| `activity/` | **Siempre** — solo título + tags, orden descendente |

### 🔴 CIERRE OBLIGATORIO — Checklist por nota creada
Cada vez que escribas UNA NOTA en cualquier carpeta, ejecuta TODO esto en la MISMA tanda de tool calls (no después, no mañana):

1. **La nota nace con `- Relacionado: [[YYYY-MM]]` ya incluido** — jamás se agrega después
2. **Actualiza el índice mensual** (`opencode/YYYY-MM.md`) — agrega fila en la tabla correcta (Sesiones/Decisiones/Aprendizajes/Preferencias/Proyectos según la carpeta)
3. **Activity aparte**: si es activity, además del paso 2, usa formato `### HH:MM - Título` + `- Tags:` y orden descendente
4. **Cero trailing slashes** en wikilinks: `[[carpeta/nota]]` ✓ — `[[carpeta/nota/]]` ✗
5. **Cero wikilinks con `\\`**: usar siempre `/`

Si no puedes ejecutar todos los pasos, NO CREES LA NOTA. Una nota sin conexión no se crea.

### 🔴 VERIFICACIÓN AL FINAL DE CADA INTERACCIÓN
Antes de terminar tu respuesta, ejecuta:

```powershell
$base = "$env:USERPROFILE\Documents\Obsidian Vault\opencode"
$index = Get-Content "$base\YYYY-MM.md" -Raw
$errores = @()
Get-ChildItem -Recurse -Filter "*.md" -Path $base | Where-Object { $_.FullName -notlike "*activity*" } | ForEach-Object {
  $rel = $_.FullName.Substring($base.Length+1).Replace("\","/").Replace(".md","")
  $content = Get-Content $_.FullName -Raw
  # Skip index file itself (it links to _index_ not to itself)
  if ($rel -eq "YYYY-MM") { return }
  # Detect any format: "- Relacionado:" or "**Relacionado:**"
  if ($content -notmatch "Relacionado.*\[\[$([regex]::Escape((Get-Date -Format "yyyy-MM")))\]\]") {
    $errores += "FALLA: $rel sin Relacionado"
  }
  if ($rel -ne "_index" -and $index -notmatch [regex]::Escape($rel)) {
    $errores += "FALLA: $rel no referenciada en índice"
  }
}
if ($errores.Count -gt 0) { throw ($errores -join "`n") } else { "✅ Todo conectado" }
```

Si hay errores, CORRÍGELOS antes de responder al usuario.

Formato actividad:
```markdown
### HH:MM - Título breve
- Tags: `#tag1` `#tag2`
```

### 🔴 Buscar API keys en config existente antes de preguntar
Antes de pedir API keys o tokens al usuario, buscar en:
- `~/.config/opencode/` (scripts, opencode.jsonc, etc.)
- `~/.config/opencode/mcp-servers/`
- El vault de Obsidian

Si ya existen, usarlos sin preguntar.

### 🔴 Carpeta de salida para archivos generados
Usar carpeta específica para outputs binarios (definir localmente).

### 🧠 Zettelkasten híbrido — Estructura neuronal
**Base:** Zettelkasten modificado — enlaces jerárquicos al mes en vez de red libre.

```
_index_.md          ← SOMA (hub central)
YYYY-MM.md          ← DENDRITAS (índices mensuales)
carpetas/           ← SINAPSIS (activity, sessions, decisions...)
  YYYY-MM-DD-*.md   ← notas atómicas
```

**Principios ZK aplicados:**
- **Atomicidad:** 1 nota = 1 concepto/tema
- **Identificador:** `YYYY-MM-DD-descripcion.md`
- **Clasificación:** Por carpeta temática (sessions, decisions, learnings...)
- **Conexión:** Solo al mes índice (`- Relacionado: [[YYYY-MM]]`)
- **Modificación ZK:** Sin enlaces libres entre notas — todo converge al mes

En grafo de Obsidian se ve como neurona: hub central → meses → notas.

### 🔗 Conexión estricta (solo al mes)
Toda nota lleva `- Relacionado: [[YYYY-MM]]` al final. Sin interconexiones entre notas a menos que el usuario lo pida explícitamente. En activity/ no se usa.

### ⚠️ Wikilinks: usar `/` no `\`
En Obsidian los wikilinks usan `/` como separador de rutas, incluso en Windows. Incorrecto: `[[carpeta\\nota]]`. Correcto: `[[carpeta/nota]]`. No usar `\` ni `\\`.

### 📄 Un archivo por día por carpeta
`YYYY-MM-DD-descripcion.md`. Leer → append si existe, crear si no.

## Herramientas MCP
- `mcpvault_search(query)` / `mcpvault_read_note(path)` / `mcpvault_write_note(path, content)`
- `mcpvault_list_files(path)` / `mcpvault_list_all_tags()` / `mcpvault_get_vault_stats()`
