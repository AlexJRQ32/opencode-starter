# OpenPaw Diagrams 4K

**Date:** 2026-06-09
**Goal:** Recrear 3 diagramas OpenPaw en 4K nativo (3840?2160) id?nticos a los originales HTML de la sesi?n anterior.

## Process

1. Le?dos los 3 HTML originales del temp (`impact-map-v6-openpaw.html`, `impact-map-tight-openpaw.html`, `user-story-map-openpaw.html`)
2. Extra?dos los SVGs embedidos y sus estilos exactos
3. Escalados los viewBox a 3840?2160 (factor ~3x)
4. Ajustados tama?os de fuente proporcionalmente
5. Renderizados como HTML independientes sin wrapper innecesario
6. Convertidos a PNG con Playwright (screenshot full page)
7. Limpiados los HTML temporales del temp

## Files Created

| File | Type | Location |
|------|------|----------|
| `impact-mapping-openpaw-4k.svg` | SVG vectorial | `Archivos OpenCode\Im?genes\` |
| `impact-mapping-openpaw-4k.png` | PNG 3840?2160 | `Archivos OpenCode\Im?genes\` |
| `impact-mapping-openpaw-flow-4k.svg` | SVG vectorial | `Archivos OpenCode\Im?genes\` |
| `impact-mapping-openpaw-flow-4k.png` | PNG 3840?2160 | `Archivos OpenCode\Im?genes\` |
| `user-story-mapping-openpaw-4k.svg` | SVG vectorial | `Archivos OpenCode\Im?genes\` |
| `user-story-mapping-openpaw-4k.png` | PNG 3840?2160 | `Archivos OpenCode\Im?genes\` |

## Design Details

### impact-mapping-openpaw (v6)
- **Goal card:** Slate (#475569) leftmost
- **4 Actor cards:** Indigo (#4f46e5), Sky (#0284c7), Teal (#0d9488), Purple (#7c3aed)
- **4 Impact cards:** Violet (#8b5cf6) center-right
- **Deliverable cards:** Slate (#475569) rightmost
- Bezier curve connections between levels
- White background, compact cards with colored top bars
- Legend at bottom

### impact-mapping-openpaw-flow (tight)
- Same structure but 3 actors only (smaller)
- Same color scheme

### user-story-map-levels
- Light gray background (#f1f5f9)
- 7 activity columns (yellow backbone #f59e0b)
- 3 release rows: MVP / v2.0 / v3.0
- Task cards with colored top bars
- Sticky-note style with shadows
- Legend included

- Relacionado: [[2026-06]]
