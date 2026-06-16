# UI UX Pro Max Skill + Python setup

- Tags: `#setup` `#skill` `#ui-ux` `#python`

Instal? el skill **UI UX Pro Max** de `@nextlevelbuilder/ui-ux-pro-max` v?a CLI.

## Qu? se hizo

1. **Instalar skill**: `npm install -g uipro-cli` ? `uipro init --ai opencode`
   - Instalado en `~/.opencode/skills/`, movido a `~/.agents/skills/ui-ux-pro-max/`
   - Contiene: 67 estilos, 96 paletas, 57 pares tipogr?ficos, 99 UX guidelines, 25 charts
   - Script `search.py` con b?squeda por dominio y `--design-system` para sistema completo
   - 13 stacks: html-tailwind, react, nextjs, vue, svelte, swiftui, react-native, flutter, shadcn, jetpack-compose

2. **Instalar Python 3.12** (era necesario para el search script)
   - `winget install Python.Python.3.12`
    - Ruta: `~/AppData/Local/Programs/Python/Python312/`
   - Ya estaba en User PATH pero los App Execution Aliases de Windows Store interfer?an

3. **Probar search.py** ? funciona y devuelve sistemas de dise?o completos

## C?mo usar

```powershell
# Sistema de dise?o completo
python3 "$env:USERPROFILE\.agents\skills\ui-ux-pro-max\scripts\search.py" "<query>" --design-system [-p "Project Name"]

# B?squeda por dominio
& ...search.py "<keyword>" --domain <domain> [-n <max_results>]

# Stack espec?fico
& ...search.py "<keyword>" --stack <stack>
```

## Tips image gen para big-pickle

- **SVG**: viewBox="0 0 3840 2160" para 4K nativo. Escalar rutas y textos proporcionalmente.
- **CSS/HTML art**: usar unidades relativas (vw/vh) para escalar a 4K.
- **Higgsfield MCP**: disponible para im?genes fotorrealistas si hiciera falta.

## Archivos generados
- `Im?genes/impact-mapping-openpaw-4k.svg` ? Impact Mapping OpenPaw 4K
- `Im?genes/user-story-mapping-openpaw-4k.svg` ? User Story Mapping OpenPaw 4K

- Relacionado: [[2026-06]]
