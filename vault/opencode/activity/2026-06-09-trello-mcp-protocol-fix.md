### 22:30 - Fix Trello MCP protocol version
- Tags: `#opencode` `#mcp` `#trello` `#fix`

Error `Server's protocol version is not supported: 0.1.0`. Fix: cambiar `protocolVersion` de `'0.1.0'` ? `'0.1.1'` en `trello-mcp-server.mjs:28`.

### 22:50 - Fix real: protocolVersion 0.1.1 ? 2025-06-18
- Tags: `#opencode` `#mcp` `#trello` `#fix`

`0.1.1` no es versi?n v?lida del protocolo MCP. Las v?lidas son: `2025-06-18`, `2025-03-26`, `2024-11-05`, `2024-10-07`. Se cambi? a `2025-06-18` en `trello-mcp-server.mjs:28`.
