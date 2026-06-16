# Session: Supabase MCP + recomendaciones

## Summary
1. Se detect? que Trello MCP fallaba por usar `"env"` en vez de `"environment"` ? se corrigi?
2. Se agreg? Supabase MCP como remoto con OAuth
3. Se corrigi? mismo bug en Azure DevOps
4. Se investigaron y recomendaron otros MCPs: GitHub, Context7, Brave Search, Sentry, Vercel, Firecrawl

## Tags
- `#opencode` `#mcp` `#supabase` `#azure-devops` `#trello`

3. Se agregaron GitHub, Context7, Sentry y Vercel como MCPs remotos con OAuth
4. Brave Search se omiti? (requiere API key de paga)

## Update (nueva conversaci?n)
4. PAT anterior expir? ? 401 en Management API
5. Se gener? nuevo PAT: `sbp_***_redacted_***` (generar nuevo en https://supabase.com/dashboard/account/tokens)
6. Se actualiz? en `opencode.jsonc` l?nea 42
7. Organizaci?n detectada: `Personal-Projects` (slug: `gncxvaaqghsuolkwfmwm`)
8. Proyecto existente: `Prueba-Supabase` (ref: `tdbgqpfwcopoxdmtaflz`, `us-east-2`, `ACTIVE_HEALTHY`)

**Pr?ximo paso:** Probar tools del MCP Supabase listando tablas del proyecto.

## Update (verificaci?n final)
9. Se audit? todo el vault: 2 notas sin `Relacionado:` + 1 activity no listada + 6 wikilinks rotos con trailing `/` ? todo reparado
10. Se blind? `AGENTS.md` con checklist obligatorio por nota + verificaci?n autom?tica al cierre de cada interacci?n.

- Relacionado: [[2026-06]]
