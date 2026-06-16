# Startup Context Optimizado

## Contexto
- Timestamp: 19:03

- Creado `scripts/gen-context-snapshot.ps1`
- Se regenera cada 5 min v?a tarea programada "OpenCode Context Snapshot"
- AGENTS.md actualizado: 4 llamadas MCP ? 1 lectura de `_context_.md`

## Mejoras
- Antes: 4 llamadas secuenciales (search + read + 2 list_files)
- Ahora: 1 llamada a `_context_.md` (paralelizable con search si hay tema conocido)
- `_context_.md` contiene: preferencias, proyectos, actividad de hoy, ?ltimas sesiones, tags

- Tags: `#optimizacion` `#contexto` `#startup` `#automation`
- Relacionado: [[2026-06]]
