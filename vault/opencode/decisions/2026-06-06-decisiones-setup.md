---
date: 2026-06-06
tags: [opencode, decision]
---

# Decisiones - 06 de junio de 2026

## Decisi?n: MCP server con @bitbonsai/mcpvault
- **Contexto:** Necesitamos conectar Obsidian como memoria persistente para opencode
- **Opci?n:** Elegimos `@bitbonsai/mcpvault` (filesystem-based, no requiere Obsidian abierto)
- **Tags:** `#mcp` `#obsidian`

## Decisi?n: Configuraci?n global en ~/.config/opencode/
- **Contexto:** El usuario prefiere setup global, no por proyecto
- **Opci?n:** AGENTS.md y opencode.jsonc en `~/.config/opencode/`
- **Tags:** `#organizacion`

## Decisi?n: Estrategia append - un archivo por d?a
- **Contexto:** M?ltiples archivos sueltos crean ruido
- **Opci?n:** Consolidar en un solo archivo `YYYY-MM-DD-descripcion.md` con entradas append
- **Tags:** `#organizacion`

## Decisi?n: Nombres descriptivos por carpeta
- **Contexto:** `2026-06-06.md` se repet?a en todas las carpetas
- **Opci?n:** Sufijos descriptivos por carpeta
- **Tags:** `#organizacion` `#obsidian`

## Decisi?n: actividad.md solo t?tulo + tags
- **Contexto:** Entradas con descripciones largas, dif?cil escanear
- **Opci?n:** Solo `### HH:MM - T?tulo` + `- Tags:`
- **Tags:** `#organizacion` `#actividad`

## Decisi?n: Cross-linking obligatorio entre notas
- **Contexto:** Notas aisladas, sin conexi?n entre s?
- **Opci?n:** Toda nota con `[[wikilinks]]` + tags consistentes
- **Tags:** `#organizacion` `#obsidian`

## Decisi?n: Model Router con 3 agentes especializados
- **Contexto:** Un solo modelo no es ?ptimo para todas las tareas
- **Opci?n:** 3 subagentes + skill `model-router` con dispatch autom?tico
- **Tags:** `#skill` `#model-router`

## Decisi?n: Usar OpenRouter como proveedor de modelos
- **Contexto:** Acceder a m?ltiples modelos gratis via una sola API key
- **Opci?n:** OpenRouter como provider en opencode.jsonc
- **Modelos:** deepseek-chat (coder), llama-3.3-70b (creative), minimax-m3-free (planner)
- **Tags:** `#decision` `#openrouter` `#configuracion`

## Decisi?n: Usar archiver para ZIP compliant en .docx
- **Contexto:** ZIP builder manual produc?a "contenido no legible" en Word
- **Opci?n:** Reemplazar por `archiver` (librer?a npm probada)
- **Tags:** `#docx` `#zip` `#archiver`

## Decisi?n: Declarar todos los namespaces en mc:Ignorable
- **Contexto:** Word valida que namespaces en `mc:Ignorable` est?n declarados
- **Opci?n:** Siempre agregar xmlns correspondiente
- **Tags:** `#docx` `#xml` `#namespace`

- Relacionado: [[2026-06]]
