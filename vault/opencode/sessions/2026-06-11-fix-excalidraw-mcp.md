# Fix: Excalidraw MCP Server

## Problema
El MCP de `@cmd8/excalidraw-mcp` (v1.2.0) no arrancaba por errores de importaci?n ESM:
- Faltaban extensiones `.js` en imports relativos (requerido por `"type": "module"`)
- Path alias `@/` no resueltos en el build publicado (`@/diagram/`, `@/tools/`, `@/utils/`)

## Soluci?n
1. Instalado globalmente con `npm install -g @cmd8/excalidraw-mcp`
2. Corregidos todos los imports en `dist/`:
   - A?adidas extensiones `.js` faltantes a imports relativos
   - Convertidos alias `@/diagram/`, `@/tools/`, `@/utils/` a rutas relativas reales
3. Actualizado `opencode.jsonc` para usar la instalaci?n global directa con node

## Config actualizada
```json
"excalidraw": {
  "type": "local",
  "command": ["node", "~/AppData/Roaming/npm/node_modules/@cmd8/excalidraw-mcp/dist/index.js", "--diagram", "~/diagram.excalidraw"],
  "enabled": true
}
```

## Archivo de diagrama
`~/diagram.excalidraw` ? creado con estructura Excalidraw vac?a.

## Nota
El paquete en npm tiene el bug de f?brica (TypeScript compilado a ESM sin resolver path aliases ni a?adir `.js`). La correcci?n es local hasta que el mantenedor publique un fix.

- Tags: `#mcp` `#excalidraw` `#fix` `#esm` `#node`
- Relacionado: [[2026-06]]
