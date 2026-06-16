# Sesi?n: Instalaci?n masiva de plugins npm + skill packs

## Resumen
Instalaci?n de **30 plugins npm** y **5 skill packs** en la configuraci?n de opencode. Auditor?a de seguridad completada sin hallazgos maliciosos.

## Progreso

### ? Realizado
1. **30 plugins npm** verificados en registry e instalados via `bun add --trust --ignore-scripts`
2. `opencode.jsonc` actualizado con array `"plugin"` de 30 paquetes npm
3. **5 skill packs** instalados v?a marketplace CLI:
   - `addyosmani/agent-skills` ? 22 commands, 11 agents, 17 skills
   - `ermand/agents-skills` ? 1 command, 1 agent, 62 skills
   - `farmage/opencode-skills` ? 12 commands, 11 agents, 4 skills
   - `shahboura/agents-opencode` ? 1 command, 0 agents, 75 skills
   - `osmontero/opencode-skills` ? sobrescrito por farmage (mismo nombre)
4. **Auditor?a de seguridad** completada en los 30 plugins:
   - Escaneo de URLs externas ? 0 hallazgos sospechosos
   - Escaneo de `process.env` ? 0 plugins leyendo variables de entorno
   - Escaneo de patrones maliciosos (eval, child_process, exfiltraci?n) ? 0 hallazgos
5. **Postinstall scripts analizados** manualmente (espec?ficos, no maliciosos):
   - `oh-my-opencode`: verifica versi?n de opencode + invalida cach?
   - `opencode-orchestrator`: auto-registra plugin en opencode.jsonc (con backup y rollback)
   - `opencode-worktree`: descarga binario desde GitHub releases
   - `@plannotator/opencode`: copia archivos .md commands

### ?? Medidas de seguridad
- Todos los plugins instalados con `--ignore-scripts` (los postinstall no se ejecutaron)
- Ning?n plugin contiene c?digo malicioso verificado
- Plugins GitHub-only omitidos por no existir (type-inject, dynamic-context-pruning, shell-strategy, workspace, md-table-formatter, morph-*)

### ?? Estado actual
- **32** paquetes npm totales en `package.json` (30 nuevos + @opencode-ai/plugin preexistente + opencode-marketplace)
- **158 skills** auto-descubiertas desde `~/.agents/skills/`
- **0** skills en `"skills": {}` del config (se auto-descubren)

## Comandos clave usados
```bash
# Verificar plugins en npm
npm view <package-name> version

# Instalar plugins npm
bun add --trust --ignore-scripts <package1> <package2> ...

# Instalar skill packs
npx opencode-marketplace install <org>/<repo> --scope user
```

## Pr?ximos pasos potenciales
- Verificar que plugins carguen correctamente al iniciar opencode
- Configurar skills espec?ficas en `"skills": {}` si se desea
- Explorar funcionalidad de plugins individuales

- Relacionado: [[2026-06]]
