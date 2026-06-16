### 18:25 - Actualizaci?n apa7.py + subagentes Zen + fix Trello MCP
- Tags: `#configuracion` `#apa7` `#modelos` `#trello`

**apa7.py actualizado:**
- Times New Roman 12pt exclusivo
- Interlineado 1.5 (vs 2.0 est?ndar APA)
- Sangr?a primera l?nea 1" (2.54 cm)
- Nuevo: `add_toc_page()` con campo TOC e hiperv?nculos
- SKILL.md actualizado con nuevas reglas

**OpenCode.jsonc:**
- Eliminado Trello MCP (archivo faltaba en Temp/)
- Agregados 7 subagentes gratis del plan Zen:

| Agente | Modelo ID |
|--------|-----------|
| deepseek | opencode/deepseek-v4-flash-free |
| qwen-coder | opencode/qwen3.6-plus-free |
| grok-code | opencode/grok-code-fast-1-free |
| glm | opencode/glm-5-free |
| ring | opencode/ring-2.6-1t-free |
| gpt-nano | opencode/gpt-5-nano |
| minimax | opencode/minimax-m2.5-free |

