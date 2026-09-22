# Feature request: golden fixture pack

**Issue:** https://github.com/SimonBarnett/bob-design-uat/issues/3  
**Absorbs:** https://github.com/SimonBarnett/bob-design-uat/issues/5 (closed dup)  
**Parked:** 2026-09-22 from #agentic_irc (Simon: anyone FRs; keep building the skill)

## MUST

- `fixtures/<case>/{brief.md,screenshot.png,expected-nits.yaml}`
- Golden fail cases: G1 spelling, G2 layout px/hex, G3 invented chrome (`NOT_IN_BRIEF`)
- One clean control (`T-A00-clean`) with `nits: []`
- Extra known-bad stills: wrong hex, 1px pad, invented logo
- Skill runs the pack and emits a nit list only — no UAT stamp
- Severity on each expected row: `blocker` | `major` | `nit`

## MUST NOT

- Stamp ready for human UAT
- Push `main` or merge own PR
- Second-take #2 / #6 / #7 / #8

## Acceptance

| ID | Check |
|----|--------|
| A-F1 | Seven cases present (T-G01..03, T-A00..03) |
| A-F2 | Clean control has empty nits |
| A-F3 | `tools/Validate-DesignUatFixtures.ps1` + BT0 exit 0 |
| A-F4 | SKILL.md documents fixture run vs `expected-nits.yaml` |
