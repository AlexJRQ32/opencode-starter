# Script: busqueda automatica de cursos gratis

Script PowerShell que scrapea udemyfreebies.com en busca de cursos Udemy gratis y guarda resultados.

**Funcionamiento:**
- Usa `System.Net.WebClient` para descargar HTML
- Regex para extraer titulo, categoria, rating, inscritos, link
- Cache JSON para detectar cursos nuevos vs conocidos
- Output en `ultimos-cursos.txt`

**Archivos:**
- `~/.config/opencode/scripts/buscar-cursos-gratis.ps1`: Script principal
- `~/.config/opencode/scripts/.cache-cursos.json`: Cache de cursos conocidos
- `~/.config/opencode/scripts/ultimos-cursos.txt`: Output para leer en cada interaccion
- `~/.config/opencode/scripts/setup-task-cursos.ps1`: Setup de Task Scheduler

**Task Scheduler:** `OpenCode-BuscarCursosGratis` (diario 08:00). Ejecutar setup como admin.

**Regla AGENTS.md:** Al iniciar cada interaccion, leer `ultimos-cursos.txt` y mostrar al usuario.

- Relacionado: [[2026-06]]
