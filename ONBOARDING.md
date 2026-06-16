# ONBOARDING - Configurar maquina nueva desde cero

> **Copia TODO este bloque** y pegalo en OpenCode en la maquina nueva.
> El agente detectara el OS y hara todo automaticamente.

---

[block]
Quiero configurar opencode desde cero en esta maquina.

Acabo de clonar el repo opencode-starter (https://github.com/AlexJRQ32/opencode-starter).
Haz TODO esto:

## 1. DETECTAR OS
Detecta si es macOS, Linux o Windows. Usa rutas correctas para cada OS.

## 2. COPIAR CONFIGURACION
- Copiar AGENTS.md a la ubicacion correcta segun OS
- Copiar opencode.template.jsonc como opencode.jsonc
- Crear ~/.config/opencode/scripts/ si no existe
- NO sobrescribir config existente

## 3. CONFIGURAR RUTAS DEL SISTEMA
En opencode.jsonc, reemplazar TODAS las rutas de Windows con las del OS actual:
- Obsidian vault path
- Filesystem MCP paths permitidos
- Playwright browsers path
- Scripts path

RUTAS WINDOWS ORIGINALES (referencia):
- C:\Users\roble\Documents
- C:\Users\roble\.config\opencode
- C:\Users\roble\.agents
- C:\Users\roble\OneDrive\Documentos\Archivos OpenCode

## 4. CREAR VAULT DE OBSIDIAN
- Copiar vault/opencode/ al vault de Obsidian
- Si ya existe _context_.md, NO sobreescribir
- Crear el archivo del mes actual si no existe

## 5. INSTALAR PLUGINS (29)
Ejecutar para CADA uno: npx opencode-marketplace install <plugin> --scope user

oh-my-opencode, opencode-vibeguard, opencode-websearch-cited, opencode-pty,
opencode-wakatime, opencode-worktree, opencode-background-agents,
opencode-supermemory, opencode-goal-plugin, opencode-conductor, opencode-quota,
opencode-snip, opencode-claude-memory, opencode-working-memory, opencode-swarm,
opencode-orchestrator, opencode-hive, opencode-lazy, opencode-codeindex,
opencode-models-discovery, opencode-copilot-plugin, @openspoon/subtask2,
@plannotator/opencode, @hueyexe/opencode-ensemble, @capybearista/opencode-agents-loader,
opencode-dux, opencode-agent-trace-plugin, opencode-mem

## 6. INSTALAR SKILLS (19)
- Copiar skills/ del repo a ~/.agents/skills/ (segun OS)
- NO sobrescribir skills existentes

## 7. CONFIGURAR MCP SERVERS
Asegurar que estan TODOS configurados en opencode.jsonc:
- Obsidian (mcpvault), Playwright, Stitch, Azure DevOps
- Supabase, GitHub, Sequential Thinking
- Filesystem (con paths seguros), Context7, Vercel

## 8. PEDIR TOKENS FALTANTES
Preguntar UNO POR UNO (con question()) por cada token que falte:
1. GitHub PAT
2. Azure DevOps PAT
3. Supabase access token
4. Vercel token
5. Google API key (Stitch)
6. OpenRouter API key (variable de entorno)
7. Trello API Key + Token

Para cada uno, explicar donde obtenerlo.

## 9. CONFIGURAR SCRIPTS
- Copiar scripts/ a ~/.config/opencode/scripts/
- Configurar Task Scheduler (Windows) o crontab (macOS/Linux):
  - gen-context-snapshot: cada 5 minutos
  - gen-report-daily: 23:59
  - buscar-cursos-gratis: diario
  - git-auto-commit: cada hora
  - cleanup-screenshots: dominical
  - moodle-to-trello: cada 30 min
  - organize-downloads: diario

## 10. VERIFICAR
- opencode --version
- opencode.jsonc existe con tokens
- AGENTS.md en su lugar
- Plugins instalados (npx opencode-marketplace list)
- Skills en ~/.agents/skills/
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
[block]
