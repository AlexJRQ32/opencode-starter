# Fix error \"ilegible\" en .docx generado por opencode

## Context
- Timestamp: 04:28

- **Causa ra?z:** `mc:Ignorable` referenciaba namespaces `w14 w15` sin declararlos
- **Fix:** agregar `xmlns:w14` y `xmlns:w15` a settings.xml y webSettings.xml
- **ZIP builder manual ? librer?a `archiver`** (ZIP est?ndar compliant)
- **Bullet character:** literal `?` ? XML entity `&#x2022;`

- Tags: `#sesion` `#docx` `#word` `#fix`
- Relacionado: [[2026-06]]