# SETUP — Instalación manual paso a paso

## Prerequisitos
- Node.js 18+ (con npx)
- Git
- OpenCode instalado
- Obsidian (para vault)

## 1. Clonar y copiar config
git clone https://github.com/AlexJRQ32/opencode-starter.git
cd opencode-starter
copy opencode.template.jsonc %USERPROFILE%\.config\opencode\opencode.jsonc
copy AGENTS.md %USERPROFILE%\.config\opencode\AGENTS.md

## 2. Instalar skills
xcopy /E /Y skills "%USERPROFILE%\.agents\skills\"

## 3. Configurar Obsidian vault
xcopy /E /Y vault "%USERPROFILE%\Documents\Obsidian Vault\"

## 4. Instalar plugins
npx opencode-marketplace install oh-my-opencode --scope user
npx opencode-marketplace install opencode-vibeguard --scope user
npx opencode-marketplace install opencode-websearch-cited --scope user
npx opencode-marketplace install opencode-pty --scope user
npx opencode-marketplace install opencode-wakatime --scope user
npx opencode-marketplace install opencode-worktree --scope user
npx opencode-marketplace install opencode-background-agents --scope user
npx opencode-marketplace install opencode-supermemory --scope user
npx opencode-marketplace install opencode-goal-plugin --scope user
npx opencode-marketplace install opencode-conductor --scope user
npx opencode-marketplace install opencode-quota --scope user
npx opencode-marketplace install opencode-snip --scope user
npx opencode-marketplace install opencode-claude-memory --scope user
npx opencode-marketplace install opencode-working-memory --scope user
npx opencode-marketplace install opencode-swarm --scope user
npx opencode-marketplace install opencode-orchestrator --scope user
npx opencode-marketplace install opencode-hive --scope user
npx opencode-marketplace install opencode-lazy --scope user
npx opencode-marketplace install opencode-codeindex --scope user
npx opencode-marketplace install opencode-models-discovery --scope user
npx opencode-marketplace install opencode-copilot-plugin --scope user
npx opencode-marketplace install @openspoon/subtask2 --scope user
npx opencode-marketplace install @plannotator/opencode --scope user
npx opencode-marketplace install @hueyexe/opencode-ensemble --scope user
npx opencode-marketplace install @capybearista/opencode-agents-loader --scope user
npx opencode-marketplace install opencode-dux --scope user
npx opencode-marketplace install opencode-agent-trace-plugin --scope user
npx opencode-marketplace install opencode-mem --scope user

## 5. Verificar plugins
npx opencode-marketplace list

## 6. Configurar scripts
xcopy /E /Y scripts "%USERPROFILE%\.config\opencode\scripts\"

## 7. Verificar instalacion
opencode --version
echo "TODO LISTO - Abre opencode y pega ONBOARDING.md como prompt"