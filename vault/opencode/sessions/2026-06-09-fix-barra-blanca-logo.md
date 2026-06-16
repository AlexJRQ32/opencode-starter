# Fix: Barra blanca en logo NexBI

Se detect? que la barra m?s larga (derecha) del logo procesado de NexBIAnalytics aparec?a en blanco, cuando su color original es azul oscuro. Se corrigi?.

## Problema
- El logo fue procesado para slides con fondo oscuro (#0d1117/#141428) y texto blanco
- La barra derecha del gr?fico de bastones (la m?s larga, ~64px ? ~140px) qued? blanca por error
- En la imagen de referencia (WhatsApp), esa barra es azul oscuro (~#102230)

## Soluci?n
1. Se extrajo el logo embebido de la diapositiva PDF con PyMuPDF
2. Se identificaron los p?xeles blancos en la zona de la barra (x=280-380, y=60-240) mediante comparaci?n con la referencia
3. Se recolorearon 10204 p?xeles blancos al color original RGB(16,34,48) / #102230
4. Se re-insert? la imagen corregida en el PDF v?a `doc.update_stream(xref, raw_rgb)`

## Archivos
- PDF corregido: `NexBIAnalytics - Slides Reto PRODHAB - fixed.pdf`
- Imagen extra?da corregida: `logo_fixed.png`

## Notas
- Las barras azules (#388ed7) y verdes (#4dbd82) no se modificaron
- El texto "NexBI Analytics" en blanco no se modific?
- La barra corregida es sutil sobre el fondo oscuro por ser colores cercanos

- Relacionado: [[2026-06]]
