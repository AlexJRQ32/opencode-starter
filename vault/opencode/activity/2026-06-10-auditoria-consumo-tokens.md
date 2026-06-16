### 18:01 - Auditor?a de consumo de tokens y desactivaci?n de ValidateFreeModels
- Tags: `#configuracion` `#token` `#optimizacion`

Se analiz? todo lo que consume tokens/consultas en el setup:
- 8 MCPs habilitados (3 remotos: Stitch, Context7, Vercel)
- 7 subagentes via OpenRouter/OpenCode
- 9 tareas programadas

**Desactivado:** OpenCode-ValidateFreeModels ? consum?a tokens de OpenRouter validando modelos gratis peri?dicamente.

**Qu? m?s gasta tokens del free usage (OpenRouter/OpenCode):**

1. **Cada interacci?n conmigo** ? soy el principal consumidor, cada mensaje quema tokens
2. **Subagentes** ? `qwen3-coder`, `kimi-ui`, `nemotron-reasoning`, `llama`, `openrouter-free` ? cada vez que se lanza un subagente, cuenta aparte en tu cuota de OpenRouter
3. **OpenCode Nemotron** ? usa el free tier de OpenCode (cuota separada de OpenRouter)

**Lo que NO gasta tokens gratis:**
- Tareas programadas locales (Context Snapshot, GitAutoCommit, GenerateDailyReport, OrganizeDownloads, Cleanup Screenshots)
- MoodleToTrello ? solo HTTP + Trello API
- MCPs locales (Obsidian, Playwright)
- MCPs remotos (Stitch, Context7, Vercel) ? usan sus propias APIs con keys separadas

- Relacionado: [[2026-06]]
