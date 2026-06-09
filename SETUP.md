# Setup Prompt — Implementación completa

Copia y pega esto en OpenCode o Claude Code para arrancar desde cero.

```markdown
Eres un asistente de configuración de opencode/Claude Code. Vas a implementar
el setup completo desde este template siguiendo estos pasos:

## Fase 1: Estructura del vault de Obsidian

1. Crear la carpeta `opencode/` dentro del vault de Obsidian
2. Dentro de `opencode/`, crear estas carpetas:
   - `sessions/` — sesiones de trabajo
   - `decisions/` — decisiones técnicas
   - `learnings/` — aprendizajes
   - `preferences/` — preferencias del usuario
   - `activity/` — feed diario
   - `context/` — proyectos activos
   - `workflows/` — pipelines de trabajo
   - `scripts/` — scripts auxiliares
3. Crear `opencode/_index_.md` con:
   ```markdown
   # OpenCode Hub

   > Soma central — desde aquí se ramifican los meses.

   | Mes | Estado |
   |-----|--------|
   | [[YYYY-MM]] | Activo |

   - Relacionado: [[YYYY-MM]]
   ```
4. Crear `opencode/YYYY-MM.md` con el formato del índice mensual
   (tablas para Sesiones, Decisiones, Aprendizajes, Preferencias, Proyectos
   más lista de Actividad)

## Fase 2: Configuración de opencode

1. Copiar `opencode.template.jsonc` como `opencode.jsonc`
2. Reemplazar cada marcador `YOUR_...` con los valores reales:
   - **Obsidian vault path**: ruta completa a tu vault
   - **TRELLO_KEY**: de https://trello.com/app-key
   - **TRELLO_TOKEN**: token de Trello (generar con enlace en app-key)
   - **AZURE_DEVOPS_EXT_PAT**: PAT de Azure DevOps
   - **SUPABASE_PAT**: de https://supabase.com/dashboard/account/tokens
   - **GITHUB_TOKEN**: fine-grained PAT con permisos Contents+Administration
   - **VERCEL_TOKEN**: de https://vercel.com/account/tokens
   - **GOOGLE_API_KEY**: para Stitch (opcional para UI generation)
   - **OPENROUTER_API_KEY**: variable de entorno para modelos
3. Copiar `AGENTS.md` a `~/.config/opencode/AGENTS.md`
4. Ajustar la ruta del vault en AGENTS.md

## Fase 3: Verificación

1. Ejecutar el script de verificación de AGENTS.md
2. Confirmar que opencode inicia sin errores
3. Probar cada MCP server con un comando básico

## Fase 4: Primer uso

1. Pedir al asistente que cree la primera nota de sesión
2. Confirmar que aparece en el índice mensual
3. Confirmar que tiene `- Relacionado: [[YYYY-MM]]`
```

## Uso

Inicia una nueva conversación en OpenCode/Claude Code y pega el bloque completo.
El asistente ejecutará todo en orden.
