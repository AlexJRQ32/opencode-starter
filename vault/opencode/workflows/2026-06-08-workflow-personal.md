# Workflow Personal ? Alex Roblero

## Perfil
- Estudiante Ingenier?a Inform?tica, Universidad Hispanoamericana
- Instructor TCU: Scratch para Ni?os (Fundaci?n Bandera Blanca)
- Stack primario: .NET (ASP.NET Core 8, EF Core, SQL Server) + React/Vite/TypeScript
- DevOps: Azure DevOps + Vercel

## Proyectos activos
| Proyecto | Estado | Stack | Herramientas |
|----------|--------|-------|-------------|
| TCU Scratch para Ni?os | En curso | Scratch 3.0, gu?as .docx | Fundaci?n Bandera Blanca |
| TCU L?gica Programaci?n | Propuesto | PSeInt, Raptor | CECI Micitt |
| Carn? Veterinario Compartido | Planificado | ASP.NET Core + React + Azure | Trello, Notion, Azure DevOps |
| stack-roadmap | Desplegado | ? + Vercel | Vercel |

## Pipeline de trabajo t?pico

### 1. Nueva idea / requerimiento
```
Input ? Buscar contexto en vault (Obsidian)
      ? Revisar sesiones previas
      ? Cargar preferencias
      ? Definir alcance
```

### 2. Planificaci?n
```
Para proyectos de curso:
  ? Stack definido por profesor (fijo)
  ? Scrum: 4 Sprints x 2 semanas
  ? Equipo: 5 personas
  ? Tablero en Trello (1 board por Sprint)
  ? Backlog en Notion DB

Para TCU:
  ? Propuesta .docx ? Revisi?n UH ? Aprobaci?n
  ? Material did?ctico por semana
  ? R?bricas de evaluaci?n
  ? Cronograma 10 semanas
```

### 3. Ejecuci?n t?cnica
```
Frontend: React/Vite/TS ? TailwindCSS ? Axios ? React Router
Backend:  ASP.NET Core API ? EF Core ? SQL Server ? JWT
Deploy:   Azure App Service (backend) + Vercel/Azure Static Web Apps (frontend)
Calidad:  ESLint + Prettier + xUnit + Vitest
```

### 4. Documentaci?n
```
Notas t?cnicas ? Obsidian (sessions/ + decisions/ + learnings/)
Documentos entregables ? OneDrive/Documentos/Archivos OpenCode
Wiki del proyecto ? Azure DevOps Wiki / Notion
```

### 5. Seguimiento
```
Daily:  Trello cards (In Progress)
Weekly: Sprint Review + Retro ? Notion
TCU:    Reporte semanal de horas
```

## Reglas de entrega
- Archivos .docx/.pdf ? `OneDrive/Documentos/Archivos OpenCode`
- API keys ? buscar en `~/.config/opencode/` primero
- Commits solo cuando se pida expl?citamente
- TypeScript + ESLint + Prettier obligatorio en frontend
- Pruebas: xUnit (backend) + Vitest (frontend)

## Atajos mentales (para el agente)
- "curso" ? Scrum, 4 Sprints, 5 personas, Trello + Notion
- "tcu" ? propuesta .docx para UH, 10 semanas, r?bricas, Fundaci?n Bandera Blanca o CECI
- "app" ? ASP.NET Core + React + Vite + Azure DevOps
- "documento" ? .docx via Node.js + archiver ? output folder
- "organizar" ? Obsidian vault con estructura de carpetas

## Tags de organizaci?n
`#proyecto-activo` `#tcu` `#curso` `#app` `#docs` `#recurso` `#preferencia`

---

- Relacionado: [[2026-06]]
