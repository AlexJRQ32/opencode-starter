# OpenPaw Devs — Configuración Completa en Azure DevOps

## Resumen
Se completó la configuración inicial del proyecto **OpenPaw Devs** en Azure DevOps para el curso Desarrollo de Aplicaciones (Universidad Hispanoamericana).

## Actividades

1. **Revisión de estado**: Se verificaron los PBIs (IDs 3-30) existentes en Azure DevOps Boards (7 Epics + 21 PBIs organizados por release MVP/v2.0/v3.0 en 6 Sprints).
2. **Inicialización del repositorio**: 
   - Clonado el repositorio vacío de Azure DevOps
   - Creada solución .NET con 3 proyectos: WebAPI, Core, Data
   - Creado frontend React + Vite con estructura base
   - Agregados `.gitignore` (.NET + Node) y `README.md`
3. **Verificación de builds**: `dotnet build` (0 errores) y `npm run build` (530ms) exitosos
4. **Commit y push**: Commit `f00e3e1` con 16 archivos a rama `main` en Azure DevOps
5. **Guía generada**: Documento .docx de configuración local guardado en OneDrive

## Detalles Técnicos
- **Backend**: .NET 10, ASP.NET Core Web API minimal, OpenPawDevs.slnx
- **Frontend**: React 19, Vite 8, proxy configurado para `/api` → `https://localhost:5001`
- **Referencias**: WebAPI → Core + Data, Data → Core
- **Repositorio**: `dev.azure.com/DesarrolloAplicacionesScrumTeam/OpenPaw%20Devs`

- Tags: `#openpaw` `#azure-devops` `#dotnet` `#react` `#universidad`
- Relacionado: [[2026-06]]
