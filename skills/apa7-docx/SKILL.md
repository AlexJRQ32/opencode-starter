---
name: apa7-docx
description: Genera documentos .docx en formato APA 7ª edición con python-docx. Úsala cuando el usuario pida "docx", "Word", "APA", "documento académico", "paper", "ensayo", "informe", "tesis", "artículo", "formato APA", "trabajo escrito", o cualquier texto académico que requiera formateo APA.
---

# APA 7ª Edición — Skill para python-docx

Skill obligatoria para **todo** `.docx` generado. Aplica APA 7 al pie de la letra.

## Reglas APA 7 obligatorias

| Elemento | Regla |
|----------|-------|
| **Fuente** | Times New Roman 12pt exclusivamente — sin alternativas |
| **Interlineado** | 1.5 en **todo** el documento — incluida portada, títulos y referencias |
| **Espaciado entre párrafos** | 0pt antes, 0pt después |
| **Sangría** | 1.27 cm (0.5") en primera línea de cada párrafo. Sin sangría en: títulos nivel 1-3, resumen, portada |
| **Márgenes** | 2.54 cm (1") todos los lados |
| **Alineación** | Izquierda (no justificada) |
| **Numeración de página** | Esquina superior derecha. La portada cuenta como página 1 |
| **Índice (TOC)** | Siempre agregar página de índice después de portada, con hipervínculos a títulos nivel 1-3 |

### Excepciones de sangría
- **Resumen**: primera línea sin sangría
- **Referencias**: sangría francesa de 1.27 cm (hanging indent)
- **Citas en bloque (>40 palabras)**: 2.54 cm de margen izquierdo adicional, sin comillas
- **Títulos**: sin sangría
- **Notas al pie**: sin sangría primera línea

## Niveles de título

| Nivel | Formato |
|-------|---------|
| 1 | Centrado, Negrita, Mayúscula Inicial |
| 2 | Izquierda, Negrita, Mayúscula Inicial |
| 3 | Izquierda, Negrita Cursiva, Mayúscula Inicial |
| 4 | Con sangría, Negrita, Mayúscula Inicial, **con punto.** Cuerpo sigue en la misma línea |
| 5 | Con sangría, Negrita Cursiva, Mayúscula Inicial, **con punto.** Cuerpo sigue en la misma línea |

## Portada (Student Paper)
1. Número de página (1) en esquina superior derecha
2. **Título del trabajo** (centrado, negrita, en la mitad superior)
3. Autores (centrado, sin negrita)
4. Afiliación institucional (centrado, sin negrita)
5. Curso (centrado, sin negrita)
6. Instructor (centrado, sin negrita)
7. Fecha (centrado, sin negrita)

## Resumen (Abstract)
- En página aparte (página 2)
- Etiqueta **"Resumen"** centrado, negrita
- Bloque de texto sin sangría
- 150-250 palabras
- Keywords: cursiva, seguido de lista de 3-5 palabras

## Citas

### Citación en narrativa
```
Según García (2020),...
```

### Citación entre paréntesis
```
... (García, 2020).
```

### Cita en bloque (>40 palabras)
- Sangría izquierda adicional 1.27 cm
- Sin comillas
- Punto antes de la cita (no después)

## Referencias
- En página aparte
- **"Referencias"** centrado, negrita
- Sangría francesa 1.27 cm (hanging indent)
- Orden alfabético
- Interlineado doble

## Script de ayuda

```python
from apa7 import APA7Doc
```

El script `apa7.py` expone la clase `APA7Doc` que maneja automáticamente:
- Configuración global (márgenes 2.54cm, Times New Roman 12pt, interlineado 1.5)
- Portada (student paper con página 1 en header)
- Índice con TOC (hipervínculos a títulos nivel 1-3)
- Resumen con palabras clave
- Niveles de título 1-5 con formato APA correcto
- Párrafos con sangría de 1.27 cm (0.5") — APA 7 standard
- Citas en bloque con margen izquierdo extra
- Referencias con sangría francesa
- Números de página automáticos en header

### Uso estándar
```python
from apa7 import APA7Doc

doc = APA7Doc()
doc.add_title_page("Título", "Autor", "Institución", curso="Curso", date="Fecha")
doc.add_toc_page()                          # ← Índice con hipervínculos
doc.add_abstract("Texto...", ["kw1", "kw2"])
doc.add_heading_level1("Introducción")
doc.add_paragraph("Texto con sangría...")
doc.save("output.docx")
```

### Citas y referencias (nuevos helpers)
```python
# Citación en narrativa (devuelve string, usar dentro de add_run)
run = p.add_run(f"Según {doc.in_text_citation('García', 2020)}, ...")

# Citación entre paréntesis (devuelve string)
run = p.add_run(doc.parenthetical_citation("García", 2020))

# Cita textual con página (agrega párrafo entero con cita + referencia)
doc.add_quote("Texto citado", "García", 2020, 45)

# Referencias formateadas automáticamente (APA 7) — agregan párrafos con sangría francesa
doc.add_journal_reference("García, J., & López, M.", 2020, "Título del artículo",
                          "Revista de Psicología", "15", "123-145", doi="10.1234/abc")
doc.add_book_reference("Pérez, A.", 2019, "Título del libro", "Editorial", edition=2)
doc.add_website_reference("Martínez, L.", 2023, "Título del artículo web",
                          "Google Scholar", "https://scholar.google.com/...")
doc.add_chapter_reference("Autor, A.", 2020, "Título capítulo", "Editor, E.",
                          "Título libro", "45-67", "Editorial")
```

## Output path

Guardar en: `C:\Users\roble\OneDrive\Documentos\Archivos OpenCode\Documentos\`
