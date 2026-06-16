# MCP Protocol Version

El cliente opencode (basado en Effect) soporta estas versiones de protocolo MCP:
- `2025-06-18` (latest)
- `2025-03-26`
- `2024-11-05`
- `2024-10-07`

Versiones num?ricas como `0.1.0` o `0.1.1` **no son v?lidas** y causan el error `Server's protocol version is not supported`.

Los MCP servers custom deben responders con una versi?n date-based en el `initialize`.

- Relacionado: [[2026-06]]
