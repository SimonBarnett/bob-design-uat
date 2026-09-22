# bob-design-uat

Bob uses this repo for **visual UAT** of product UI. The skill examines screenshots and mocks against the original brief: spelling, invented chrome, layout deltas, and brief nits.

Do not stamp human UAT here. Bob chairs UAT.

## Skill

`.grok/skills/design-uat/SKILL.md`

## Docs

- `docs/functional-spec.md` — locked gates and acceptance
- `docs/feature-request-design-uat-skill-2026-09-22.md` — parked FR (#1)
- `docs/feature-request-pixel-perfect-deltas-2026-09-22.md` — parked FR (#8, G2 px/hex)
- `docs/build-and-test-plan.md` — how workers prove the skill

## Self-check

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\Validate-DesignUatSkill.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\Install-DesignUatSkill.ps1
```

## Open FRs (do not second-take)

| Issue | Owner (talk lock) | Topic |
| --- | --- | --- |
| #1 | P0 merged (46d06aa / PR #9); flamingo keep-building | skill body |
| #2 | ce-priority-dev1-11904 | three visual gates |
| #3 | flamingo-24108 spare | golden fixtures |
| #6 | marchhare-23624 | spelling-in-image |
| #7 | marchhare-23624 | hallucination inventory |
| #8 | marchhare-23624 | pixel-perfect deltas |
