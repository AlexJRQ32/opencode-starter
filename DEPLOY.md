# DEPLOY - Implementacion en Windows, Linux y macOS

> Copia TODO este bloque y pegalo en OpenCode en la maquina nueva.
> El agente detectara el OS y hara todo automaticamente.

---

Quiero configurar opencode desde cero en esta maquina.

Acabo de clonar el repo: `git clone https://github.com/AlexJRQ32/opencode-starter.git`

## 1. DETECTAR OS

Detecta automaticamente si es macOS, Linux o Windows. Usa rutas correctas para cada OS:

| Recurso | Windows | macOS | Linux |
|---------|---------|-------|-------|
| Config dir | `%USERPROFILE%\.config\opencode\` | `~/.config/opencode/` | `~/.config/opencode/` |
| Skills dir | `%USERPROFILE%\.agents\skills\` | `~/.agents/skills/` | `~/.agents/skills/` |
| Vault path | `%USERPROFILE%\Documents\Obsidian Vault\` | `~/Documents/Obsidian Vault/` | `~/Documents/Obsidian Vault/` |
| Scripts dir | `%USERPROFILE%\.config\opencode\scripts\` | `~/.config/opencode/scripts/` | `~/.config/opencode/scripts/` |

## 2. COPIAR CONFIGURACION

- Copiar `opencode.template.jsonc` como `opencode.jsonc` segun el OS
- Copiar `AGENTS.md` a la ubicacion correcta
- Crear `scripts/` si no existe
- NO sobrescribir config existente

## 3. ADAPTAR RUTAS EN opencode.jsonc

Reemplazar TODAS las rutas de Windows con las del OS actual:
- Obsidian vault path
- Filesystem MCP paths (documentos, config, agents, output)
- Playwright browsers path
- Scripts path

## 4. CONFIGURAR OBSIDIAN VAULT

- Copiar `vault/opencode/` al vault de Obsidian
- Si ya existe `_context_.md`, NO sobreescribir
- Crear el archivo del mes actual si no existe (`YYYY-MM.md`)

## 5. INSTALAR PLUGINS

Ejecutar para CADA uno: `npx opencode plugin <nombre> -g`

```
oh-my-openagent, opencode-vibeguard, opencode-websearch-cited, opencode-pty,
opencode-wakatime, opencode-worktree, opencode-background-agents,
opencode-supermemory, opencode-goal-plugin, opencode-conductor, opencode-quota,
opencode-snip, opencode-claude-memory, opencode-working-memory, opencode-swarm,
opencode-orchestrator, opencode-hive, opencode-lazy, opencode-codeindex,
opencode-models-discovery, opencode-copilot-plugin, @openspoon/subtask2,
@plannotator/opencode, @hueyexe/opencode-ensemble, @capybearista/opencode-agents-loader,
opencode-dux, opencode-agent-trace-plugin, opencode-mem
```

## 6. INSTALAR SKILLS

- Copiar `skills/` del repo a `~/.agents/skills/`
- NO sobrescribir skills existentes

## 7. CONFIGURAR MCP SERVERS

Verificar que en `opencode.jsonc` estan configurados:
- Obsidian (mcpvault), Playwright, Stitch, Azure DevOps
- Supabase, GitHub, Sequential Thinking
- Filesystem (paths del OS actual), Context7, Vercel

## 8. PEDIR TOKENS (UNO POR UNO con question())

1. GitHub PAT
2. Azure DevOps PAT
3. Supabase access token
4. Vercel token
5. Google API key (Stitch)
6. OpenRouter API key (variable de entorno `OPENROUTER_API_KEY`)
7. Trello API Key + Token

Para cada uno explicar donde obtenerlo.

## 9. CONFIGURAR SCRIPTS

- Copiar `scripts/` a `~/.config/opencode/scripts/`
- Programar tareas:

| Script | Frecuencia |
|--------|-----------|
| gen-context-snapshot.ps1 | Cada 5 min |
| gen-report-daily.mjs | 23:59 |
| buscar-cursos-gratis.ps1 | Diario |
| git-auto-commit.ps1 | Cada hora |
| cleanup-screenshots.ps1 | Dominical |
| moodle-to-trello.ps1 | Cada 30 min |
| organize-downloads.ps1 | Diario |

- **Windows**: Task Scheduler + VBS launchers
- **macOS/Linux**: crontab

## 10. VERIFICAR

- `opencode --version`
- `opencode.jsonc` existe con tokens
- `AGENTS.md` en su lugar
- Plugins instalados
- Skills en `~/.agents/skills/`
- Vault de Obsidian con estructura correcta

## 11. RESUMEN FINAL

Mostrar:
- Lo que se configuro correctamente
- Lo que falta por hacer manualmente
- Proximos pasos sugeridos

IMPORTANTE:
- Usa question() para cada token, UNO a la vez
- Rutas correctas segun OS detectado
- No sobreescribir config existente
- `opencode-forgecode` esta deliberadamente excluido (causa error "server not found")
