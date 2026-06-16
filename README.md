# opencode-starter

> ⚠️ **REPO PRIVADO** — Contiene API keys reales y configuración personal completa.

Fork template de configuración para [opencode](https://opencode.ai) — setup completo con MCP servers, subagentes, plugins, skills, scripts y memoria persistente vía Obsidian Zettelkasten.

---

## Índice

- [Inicio rápido](#inicio-rápido)
- [Stack completo](#stack-completo)
- [MCP Servers](#mcp-servers)
- [API Keys](#api-keys)
- [Subagentes](#subagentes)
- [Plugins](#plugins)
- [Skills](#skills)
- [Scripts & Task Scheduler](#scripts--task-scheduler)
- [Obsidian Vault](#obsidian-vault)
- [Carpetas del sistema](#carpetas-del-sistema)
- [Proyectos](#proyectos)
- [Estructura del repo](#estructura-del-repo)

---

## Inicio rápido

```bash
# Clonar
git clone https://github.com/AlexJRQ32/opencode-starter.git
cd opencode-starter

# Copiar config al lugar correcto
copy opencode.template.jsonc %USERPROFILE%\.config\opencode\opencode.jsonc
copy AGENTS.md %USERPROFILE%\.config\opencode\AGENTS.md

# Instalar skills
xcopy /E skills %USERPROFILE%\.agents\skills\

# Abrir opencode
opencode
```

---

## Stack completo

### Sistema
| Componente | Detalle |
|-----------|---------|
| **OS** | Windows 10/11 |
| **Usuario** | `roble` |
| **Shell** | PowerShell 5.1 |
| **Python** | 3.12 (C:\Users\roble\AppData\Local\Programs\Python\Python312) |
| **Node.js** | vía npx/bunx |
| **Package manager** | pnpm (preferido), npm, bun |

### OpenCode
| Componente | Versión/Valor |
|-----------|--------------|
| **Config file** | `%USERPROFILE%\.config\opencode\opencode.jsonc` |
| **Modelo default** | `opencode/qwen3.6-plus-free` |
| **UI config** | `%USERPROFILE%\.config\opencode\tui.json` |
| **AGENTS.md** | `%USERPROFILE%\.config\opencode\AGENTS.md` |
| **Plugins DB** | `%USERPROFILE%\.config\opencode\plugins\installed.json` |
| **Ensemble DB** | `%USERPROFILE%\.config\opencode\ensemble.db` |

---

## MCP Servers

| # | Server | Tipo | Comando/URL | Auth |
|---|--------|------|-------------|------|
| 1 | **Obsidian** | local | `npx -y @bitbonsai/mcpvault@latest C:/Users/roble/Documents/Obsidian Vault` | — |
| 2 | **Playwright** | local | `node ...\mcp-servers\playwright\index.js` | — |
| 3 | **Stitch** | remote | `https://stitch.googleapis.com/mcp` | Google API Key |
| 4 | **Azure DevOps** | local | `npx -y @azure-devops/mcp DesarrolloAplicacionesScrumTeam` | PAT |
| 5 | **Supabase** | local | `npx -y @supabase/mcp-server-supabase@latest --access-token <PAT>` | PAT |
| 6 | **GitHub** | local | `npx -y @modelcontextprotocol/server-github` | PAT |
| 7 | **Sequential Thinking** | local | `npx -y @modelcontextprotocol/server-sequential-thinking` | — |
| 8 | **Filesystem** | local | `npx -y @modelcontextprotocol/server-filesystem <paths>` | — (paths seguros) |
| 9 | **Context7** | remote | `https://mcp.context7.com/mcp` | — |
| 10 | **Vercel** | remote | `https://mcp.vercel.com` | Bearer Token |

### Filesystem - Rutas permitidas
```
C:\Users\roble\Documents
C:\Users\roble\.config\opencode
C:\Users\roble\.agents
C:\Users\roble\OneDrive\Documentos\Archivos OpenCode
```

---

## API Keys

> **Todas están en `opencode.jsonc`**. No preguntar al usuario si ya existen.

| Servicio | Token (truncado) | Ubicación en opencode.jsonc |
|----------|-----------------|---------------------------|
| **GitHub** | `github_pat_11BLIG...` | `mcp.github.environment.GITHUB_TOKEN` |
| **Azure DevOps** | `G1GiNiQs7l5p...` | `mcp.azure-devops.environment.AZURE_DEVOPS_EXT_PAT` |
| **Supabase** | `sbp_ff2a057bd3...` | `mcp.supabase.command` (access-token) |
| **Vercel** | `vcp_6Q4GdnYk...` | `mcp.vercel.headers.Authorization` |
| **Google Stitch** | `AQ.Ab8RN6LU...` | `mcp.stitch.headers.X-Goog-Api-Key` |
| **OpenRouter** | Variable de entorno | `$env:OPENROUTER_API_KEY` |
| **Trello** | En scripts | `~/.config/opencode/scripts/moodle-to-trello.ps1` |

---

## Subagentes

| Agente | Modelo | Contexto | Ideal para |
|--------|--------|----------|-----------|
| `deepseek` | DeepSeek V4 Flash | — | Código, análisis, debugging |
| `qwen-coder` | Qwen 3.6+ | 262K | Features, refactors, código |
| `opencode-nemotron` | Nemotron 3 Ultra | 1M | Tareas grandes, contexto masivo |
| `grok-code` | Grok Code Fast 1 | — | Código rápido, explicaciones |
| `glm` | GLM 5 | — | Análisis, creatividad |
| `ring` | Ring 2.6 1T | — | Razonamiento complejo |
| `gpt-nano` | GPT 5 Nano | — | Tareas ligeras y rápidas |
| `minimax` | MiniMax M2.5 | — | Propósito general |

---

## Plugins (29)

| Plugin | Función |
|--------|---------|
| `oh-my-opencode` | Framework base de plugins |
| `opencode-vibeguard` | Seguridad y protección |
| `opencode-websearch-cited` | Búsqueda web con citas |
| `opencode-pty` | Terminal interactiva |
| `opencode-wakatime` | Time tracking |
| `opencode-worktree` | Git worktrees |
| `opencode-background-agents` | Agentes en segundo plano |
| `opencode-supermemory` | Memoria persistente |
| `opencode-goal-plugin` | Gestión de objetivos |
| `opencode-conductor` | Orquestación de agentes |
| `opencode-quota` | Control de cuotas de tokens |
| `opencode-snip` | Snippets reutilizables |
| `opencode-claude-memory` | Memoria estilo Claude |
| `opencode-working-memory` | Memoria de trabajo |
| `opencode-swarm` | Equipos multi-agente |
| `opencode-orchestrator` | Orquestador (Hive) |
| `opencode-hive` | Hive planificación+ejecución |
| `opencode-lazy` | Ejecución lazy diferida |
| `opencode-codeindex` | Indexación de código |
| `opencode-models-discovery` | Descubrimiento de modelos |
| `opencode-copilot-plugin` | Copilot-style asistencia |
| `@openspoon/subtask2` | Subtareas |
| `@plannotator/opencode` | Planificación |
| `@hueyexe/opencode-ensemble` | Ensemble de agentes |
| `@capybearista/opencode-agents-loader` | Carga de agentes |
| `opencode-dux` | UX mejorada |
| `opencode-agent-trace-plugin` | Traza de agentes |
| `opencode-mem` | Memoria conversacional |

---

## Skills

### Skills locales (19)
Instalados en `~/.agents/skills/`:

| Categoría | Skills |
|-----------|--------|
| **UI/UX** | `frontend-design`, `design-taste-frontend`, `impeccable`, `web-design-guidelines`, `ui-ux-pro-max`, `emil-design-eng` |
| **React/Next.js** | `vercel-react-best-practices`, `vercel-composition-patterns` |
| **Vercel** | `vercel-cli-with-tokens` |
| **Documentos** | `apa7-docx`, `presentation-designer` |
| **Imágenes** | `image-maker`, `image-viewer`, `visual-creator` |
| **Optimización** | `token-efficiency`, `model-router` |
| **Obsidian** | `obsidian-vault` |
| **Investigación** | `fuentes-confiables`, `cursos-gratis` |

### Skills vía plugins (46 adicionales)
Desde paquetes: `agent-skills`, `agents-skills`, `opencode-skills`, `agents-opencode`

Incluyen: brainstorming, code-review, debugging, TDD, análisis de código, testing, CI/CD, Docker, Kubernetes, cloud, etc.

---

## Scripts & Task Scheduler

### Programados
| Script | Frecuencia | Descripción |
|--------|-----------|-------------|
| `gen-context-snapshot.ps1` | Cada 5 min | Regenera `_context_.md` con resumen del vault |
| `gen-report-daily.mjs` | 23:59 | Genera reporte diario .docx |
| `buscar-cursos-gratis.ps1` | Diario | Scrapea udemyfreebies.com |
| `git-auto-commit.ps1` | Cada hora | Auto-commit a repos vigilados |
| `git-auto-commit-universidad.ps1` | Cada hora | Auto-commit repo uni |
| `cleanup-screenshots.ps1` | Dominical | Borra screenshots > 30 días |
| `moodle-to-trello.ps1` | Cada 30 min | Tareas de Moodle → Trello |
| `organize-downloads.ps1` | Diario | Organiza carpeta Downloads |
| `teams-to-trello.ps1` | Cada 30 min | Tareas Teams → Trello |

### VBS Launchers (ejecución oculta)
| VBS | Lanza |
|-----|-------|
| `clipboard-watcher.vbs` | clipboard-screenshot.ps1 |
| `dailyreport-runner.vbs` | gen-report-daily.ps1 |
| `git-runner.vbs` | git-auto-commit.ps1 |
| `moodle-runner.vbs` | moodle-to-trello.ps1 |
| `organize-runner.vbs` | organize-downloads.ps1 |
| `report-runner.vbs` | gen-report-daily.ps1 |
| `uni-runner.vbs` | git-auto-commit-universidad.ps1 |
| `validate-runner.vbs` | validate-free-models.ps1 |

---

## Obsidian Vault

### Estructura
```
Documents/Obsidian Vault/
└── opencode/
    ├── _index_.md          ← Hub central
    ├── YYYY-MM.md          ← Índices mensuales
    ├── sessions/           ← Sesiones de trabajo (30+ notas)
    ├── decisions/          ← Decisiones técnicas
    ├── learnings/          ← Aprendizajes
    ├── preferences/        ← Preferencias del usuario
    ├── activity/           ← Feed diario
    ├── context/            ← Proyectos activos
    ├── workflows/          ← Pipelines de trabajo
    ├── scripts/            ← Scripts auxiliares
    └── _context_.md        ← Snapshot auto-generado (cada 5 min)
```

### Stats actuales
- **Total notas**: 87+
- **Sesiones documentadas**: 30+
- **Cobertura**: Junio 2026 completo

---

## Carpetas del sistema

| Propósito | Ruta |
|-----------|------|
| Config OpenCode | `%USERPROFILE%\.config\opencode\` |
| Skills | `%USERPROFILE%\.agents\skills\` |
| MCP servers custom | `%USERPROFILE%\.config\opencode\mcp-servers\` |
| Scripts | `%USERPROFILE%\.config\opencode\scripts\` |
| Plugins DB | `%USERPROFILE%\.config\opencode\plugins\` |
| Output archivos | `%USERPROFILE%\OneDrive\Documentos\Archivos OpenCode\` |
| Playwright browsers | `%USERPROFILE%\.cache\ms-playwright\` |
| Obsidian Vault | `%USERPROFILE%\Documents\Obsidian Vault\` |

---

## Proyectos

### OpenPaw Devs
- **Qué**: Carnet de mascotas compartible tipo EDUS (universidad)
- **Stack**: .NET 10 (C#) + React 19 + SQL Server
- **DevOps**: Azure DevOps (DesarrolloAplicacionesScrumTeam)
- **Estructura**: WebAPI / Core / Data layers
- **Proxy**: Frontend Vite → `/api` → `https://localhost:5001`

### Lumina Apps
- **Qué**: Serie de apps con diseño Glassmorphism futurista
- **Stack**: React + Vite + pnpm + Tailwind 4 + Supabase + Vercel
- **Design System**: Fondo `#020617`, Acento `#8B5CF6` (violeta), `#06B6D4` (cian)

---

## Estructura del repo

```
opencode-starter/
├── README.md                  ← Este archivo (documentación completa)
├── AGENTS.md                  ← Instrucciones para el agente
├── opencode.template.jsonc    ← Config completa (con API keys reales)
├── .gitignore                 ← Ignora secrets locales
├── vault/                     ← Vault Obsidian (estructura + notas)
│   └── opencode/
│       ├── _index_.md
│       ├── YYYY-MM.md
│       ├── sessions/
│       ├── decisions/
│       ├── learnings/
│       ├── preferences/
│       ├── activity/
│       ├── context/
│       └── workflows/
├── skills/                    ← 19 skills instalables
│   ├── apa7-docx/
│   ├── cursos-gratis/
│   ├── frontend-design/
│   ├── impeccable/
│   └── ...
└── scripts/                   ← Scripts de automatización
    ├── gen-context-snapshot.ps1
    ├── gen-report-daily.mjs
    ├── cleanup-screenshots.ps1
    └── ...
```