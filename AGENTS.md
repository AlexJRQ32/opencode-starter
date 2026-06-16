# Memoria Persistente con Obsidian

Vault: `C:\Users\roble\Documents\Obsidian Vault` (MCP root: `C:\Users\roble` → prefijar `Documents/Obsidian Vault/`)

## ════════════════════════════════════════
## DATOS DEL SISTEMA
## ════════════════════════════════════════

| Variable | Valor |
|----------|-------|
| **Usuario Windows** | `roble` |
| **Vault Obsidian** | `C:\Users\roble\Documents\Obsidian Vault` |
| **Config OpenCode** | `C:\Users\roble\.config\opencode` |
| **Skills locales** | `C:\Users\roble\.agents\skills\` |
| **Output archivos** | `C:\Users\roble\OneDrive\Documentos\Archivos OpenCode\` |
| **Python** | `C:\Users\roble\AppData\Local\Programs\Python\Python312\python.exe` |
| **MCP vault root** | `C:\Users\roble` (prefijar `Documents/Obsidian Vault/`) |
| **Playwright browsers** | `C:\Users\roble\.cache\ms-playwright` |
| **Azure DevOps org** | `DesarrolloAplicacionesScrumTeam` |
| **GitHub user** | `AlexJRQ32` |

### Carpetas permitidas (Filesystem MCP)
1. `C:\Users\roble\Documents`
2. `C:\Users\roble\.config\opencode`
3. `C:\Users\roble\.agents`
4. `C:\Users\roble\OneDrive\Documentos\Archivos OpenCode`

### Output: clasificación por tipo
| Extensión | Subcarpeta |
|-----------|-----------|
| `.docx` `.doc` `.pdf` `.xlsx` `.xls` `.pptx` `.txt` | `Documentos/` |
| `.png` `.jpg` `.jpeg` `.gif` `.bmp` `.svg` `.webp` | `Imágenes/` |
| `.md` | `Markdown/` |

## ════════════════════════════════════════
## API KEYS Y TOKENS
## ════════════════════════════════════════

| Servicio | Dónde está | Cómo renovar |
|----------|-----------|-------------|
| **GitHub PAT** | `opencode.jsonc` → `mcp.github.environment.GITHUB_TOKEN` | GitHub → Settings → Developer → PAT |
| **Azure DevOps PAT** | `opencode.jsonc` → `mcp.azure-devops.environment.AZURE_DEVOPS_EXT_PAT` | `https://dev.azure.com/{org}/_usersSettings/tokens` |
| **Supabase PAT** | `opencode.jsonc` → `mcp.supabase.command` | Supabase Dashboard → Account → Tokens |
| **Vercel Token** | `opencode.jsonc` → `mcp.vercel.headers.Authorization` | Vercel Dashboard → Settings → Tokens |
| **Google API Key** | `opencode.jsonc` → `mcp.stitch.headers.X-Goog-Api-Key` | Google Cloud → APIs → Credentials |
| **OpenRouter** | Variable de entorno `$env:OPENROUTER_API_KEY` | `https://openrouter.ai/keys` |
| **Trello Key+Token** | Scripts en `~/.config/opencode/scripts/` | `https://trello.com/app-key` |

### 🔴 REGLA: Antes de pedir tokens, buscar en:
1. `~/.config/opencode/opencode.jsonc`
2. `~/.config/opencode/mcp-servers/`
3. Vault de Obsidian
4. Variables de entorno

## ════════════════════════════════════════
## REGLAS OBLIGATORIAS
## ════════════════════════════════════════

### 🔴 Al iniciar cada interacción
1. `obsidian_read_note(path="Documents/Obsidian Vault/opencode/_context_.md")`
2. Solo si el tema es conocido: `mcpvault_search(query="<tema>")`
3. LEER cursos gratis: `Read("$env:USERPROFILE\.config\opencode\scripts\ultimos-cursos.txt")`

### 🔴 Guardado automático (async)
| Carpeta | Cuándo |
|---------|--------|
| `sessions/` | Siempre |
| `decisions/` | Si hay decisión técnica |
| `learnings/` | Si hay algo nuevo |
| `preferences/` | Si se detecta preferencia |
| `activity/` | Siempre (solo título+tags) |

### 🔴 CIERRE OBLIGATORIO por nota
1. Incluir `- Relacionado: [[YYYY-MM]]` desde el inicio
2. Actualizar índice mensual
3. Activity: `### HH:MM - Título`
4. Wikilinks con `/`, sin `\\`, sin trailing slash
5. Extensión `.md` obligatoria

## ════════════════════════════════════════
## SKILLS (19 locales + 46 vía plugins)
## ════════════════════════════════════════

Locales en `~/.agents/skills/`: obsidian-vault, model-router, token-efficiency, fuentes-confiables, cursos-gratis, ui-ux-pro-max, frontend-design, design-taste-frontend, emil-design-eng, impeccable, web-design-guidelines, vercel-react-best-practices, vercel-composition-patterns, vercel-cli-with-tokens, apa7-docx, presentation-designer, image-maker, image-viewer, visual-creator

UI/UX Pro Max: `& "C:\Users\roble\AppData\Local\Programs\Python\Python312\python.exe" "$env:USERPROFILE\.agents\skills\ui-ux-pro-max\scripts\search.py" "<query>" --design-system`

## ════════════════════════════════════════
## PLUGINS (29)
## ════════════════════════════════════════

oh-my-opencode, opencode-vibeguard, opencode-websearch-cited, opencode-pty, opencode-wakatime, opencode-worktree, opencode-background-agents, opencode-supermemory, opencode-goal-plugin, opencode-conductor, opencode-quota, opencode-snip, opencode-claude-memory, opencode-working-memory, opencode-swarm, opencode-orchestrator, opencode-hive, opencode-lazy, opencode-codeindex, opencode-models-discovery, opencode-copilot-plugin, @openspoon/subtask2, @plannotator/opencode, @hueyexe/opencode-ensemble, @capybearista/opencode-agents-loader, opencode-dux, opencode-agent-trace-plugin, opencode-mem

## ════════════════════════════════════════
## SCRIPTS Y TASK SCHEDULER
## ════════════════════════════════════════

| Script | Schedule | Función |
|--------|----------|---------|
| gen-context-snapshot.ps1 | Cada 5 min | Regenera _context_.md |
| gen-report-daily.mjs | 23:59 | Reporte .docx diario |
| buscar-cursos-gratis.ps1 | Diario | Scrapea cursos gratis |
| git-auto-commit.ps1 | Cada hora | Auto-commit repos |
| git-auto-commit-universidad.ps1 | Cada hora | Auto-commit uni |
| cleanup-screenshots.ps1 | Dominical | Limpia screenshots |
| moodle-to-trello.ps1 | Cada 30 min | Moodle → Trello |
| organize-downloads.ps1 | Diario | Organiza Downloads |
| teams-to-trello.ps1 | Cada 30 min | Teams → Trello |
| validate-free-models.ps1 | Manual | Valida modelos gratis |

## ════════════════════════════════════════
## PROYECTOS
## ════════════════════════════════════════

**OpenPaw Devs** — .NET 10 + React 19 + SQL Server → Azure DevOps
**Lumina apps** — React + Vite + pnpm + Tailwind 4 + Supabase + Vercel