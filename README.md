# opencode-starter

Fork template de configuración para [opencode](https://opencode.ai) — setup con MCP servers, subagentes y memoria persistente vía Obsidian.

## Inicio rápido

```bash
# 1. Clonar
git clone https://github.com/YOUR_USER/opencode-starter.git ~/.config/opencode

# 2. Editar opencode.jsonc — agregar tus tokens/API keys donde dice YOUR_...
# Busca los marcadores "YOUR_" en el archivo

# 3. Iniciar opencode
opencode
```

## MCP Servers incluidos

| Server | Auth requerida |
|--------|---------------|
| Obsidian (mcpvault) | — |
| Playwright | — |
| Stitch (Google) | API key |
| Trello | Key + Token |
| Azure DevOps | PAT |
| Supabase | PAT |
| GitHub | PAT |
| Context7 | — |
| Vercel | Token |

## Subagentes disponibles

| Agente | Modelo | Uso |
|--------|--------|-----|
| qwen3-coder | Qwen 3 Coder | Código, features, fixes |
| nemotron-reasoning | Nemotron 3 Nano | Debugging complejo |
| llama | Llama 3.3 70B | Creatividad, texto |
| openrouter-free | Router automático | Elección dinámica |
| opencode-nemotron | Nemotron 3 Ultra | Tareas grandes |
| kimi-ui | Kimi K2.6 | UI/UX, frontend |

## Obsidian + Memoria Persistente

Este setup incluye un sistema Zettelkasten híbrido para memoria persistente entre sesiones:

```
_index_.md          ← Hub central
YYYY-MM.md          ← Índices mensuales
carpetas/           ← Notas atómicas
  sessions/         → sesiones de trabajo
  decisions/        → decisiones técnicas
  learnings/        → aprendizajes
  preferences/      → preferencias del usuario
  activity/         → feed diario
```

Requisitos:
- Obsidian vault en `~/_YOUR_VAULT_PATH_`
- Plugin MCP Vault (`@bitbonsai/mcpvault`) instalado
- Editar `AGENTS.md` con la ruta de tu vault
