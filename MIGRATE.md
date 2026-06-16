# Migración a macOS — Desarrollo

> Generado: 2026-06-15

## 1. Paquete único (Homebrew)

```bash
# === Development ===
brew install git node python@3.12 openjdk@22 dotnet

brew install --cask visual-studio-code
brew install --cask docker
brew install --cask postman
brew install --cask azure-data-studio

# === Package managers globales ===
npm i -g pnpm vercel
```

## 2. OpenCode

Descargar desde [opencode.dev](https://opencode.dev) o:

```bash
brew install opencode
```

Luego copiar la config desde el backup `migracion-mac.zip`:
- `.config/opencode/opencode.jsonc`
- `.config/opencode/AGENTS.md`
- `.config/opencode/scripts/`
- `.config/opencode/mcp-servers/`

En macOS la ruta es `~/.config/opencode/`.

## 3. Skills

Desde el backup `migracion-mac.zip`:
- `.agents/skills/` → `~/.agents/skills/`

## 4. Clonar monorepo

```bash
git clone --recurse-submodules https://github.com/AlexJRQ32/Respaldo-Windows.git
cd Respaldo-Windows
```

## 5. Proyectos Lumina (PostgreSQL en Mac)

Los proyectos Lumina usan Supabase (cloud), no necesitan DB local. Si necesitas SQL Server para OpenPaw Devs:

```bash
docker run -e "ACCEPT_EULA=Y" \
  -e "MSSQL_SA_PASSWORD=TuPassSegura123!" \
  -p 1433:1433 \
  -d mcr.microsoft.com/mssql/server:2025-latest
```

## 6. Azure Data Studio (reemplazo de SSMS)

```bash
brew install --cask azure-data-studio
```

## 7. .NET Development

```bash
# Verificar instalación
dotnet --version
dotnet --list-sdks

# Para proyectos ASP.NET Core (OpenPaw Devs)
dotnet new webapi -n MiProyecto
```

## 8. Node.js + pnpm

```bash
node --version
pnpm --version

# Para proyectos Lumina
cd projects/lumina-cookbook
pnpm install
pnpm dev
```

## Resumen de diferencias

| Windows | macOS | Alternativa |
|---------|-------|-------------|
| Visual Studio 2026 | VS Code + .NET CLI | No hay VS para Mac |
| SSMS | Azure Data Studio | Mismo propósito |
| SQL Server local | Docker + SQL container | Misma BD |
| PowerShell + Task Scheduler | bash/zsh + launchd/cron | Rehacer scripts |
| Power BI Desktop | Power BI Web (powerbi.com) | Sin app nativa |
