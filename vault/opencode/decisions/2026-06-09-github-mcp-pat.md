# GitHub MCP: Remote OAuth ? Local PAT

El MCP remoto de GitHub via `api.githubcopilot.com/mcp` fall? con:
`Incompatible auth server: does not support dynamic client registration`

## Soluci?n
- Cambiado a MCP local con `@modelcontextprotocol/server-github`
- Usando Fine-grained PAT como `GITHUB_TOKEN` en environment
- Config en `opencode.jsonc`

- Relacionado: [[2026-06]]
