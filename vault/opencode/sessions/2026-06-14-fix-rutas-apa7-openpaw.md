# Fix rutas extrañas en guía APA7 de OpenPaw Devs

## Problema
La guía APA7 `OpenPaw_Devs_Guia_Configuracion_Local_APA7.docx` tenía rutas de archivos con formato extraño:
- **Connection string SQL Server**: `Server=(localdb)\\MSSQLLocalDB` con doble backslash (`\\`) en vez de uno simple (`\`)

## Diagnóstico
El error estaba en el script Python generador (`generar_guia_openpaw_apa7.py`). En la connection string se usó `\\\\` (4 backslashes) en lugar de `\\` (2 backslashes), lo que en Python produce `\\` literal en el output.

## Corrección
- Cambiado `\\\\MSSQLLocalDB` → `\\MSSQLLocalDB` en el script
- El `%20` en la URL de `git clone` se dejó igual — es el encoding normal de espacios en URLs de Azure DevOps

## Archivo generado
- **Corregido**: `~/OneDrive/Documentos/Archivos OpenCode/Documentos/OpenPaw_Devs_Guia_Configuracion_Local_APA7_v2.docx` (41 KB)
- **Original bloqueado**: El `.docx` original quedó bloqueado (posiblemente abierto en Word)

- Relacionado: [[2026-06]]
