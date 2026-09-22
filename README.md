# bob-design-uat

Bob uses this repo for **visual UAT** of product UI. The skill examines screenshots and mocks against the original brief: spelling, invented chrome, layout deltas, and brief nits.

Do not stamp human UAT here. Bob chairs UAT.

## Skill

`.grok/skills/design-uat/SKILL.md`

## Docs

- `docs/functional-spec.md` — locked gates and acceptance
- `docs/feature-request-design-uat-skill-2026-09-22.md` — parked FR (#1)
- `docs/feature-request-golden-fixture-pack-2026-09-22.md` — parked FR (#3, absorbs #5)
- `docs/feature-request-hallucination-inventory-2026-09-22.md` — G3 inventory FR (#7)
- `docs/feature-request-playwright-visual-uat-2026-09-22.md` — Playwright capture FR (#57)
- `docs/build-and-test-plan.md` — how workers prove the skill
- `fixtures/` — golden + clean-control pack (`expected-nits.yaml`)

## Self-check

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\Validate-DesignUatSkill.ps1
powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\Install-DesignUatSkill.ps1
```

## Closed FRs (DONE — conversations locked)

No open issues or PRs. Closed issues were locked 2026-09-22 (reason: resolved) so FAIL/FR boards are not reopened after merge.

| Issue | Merge | Topic |
| --- | --- | --- |
| #1 | PR #9 / #11 | skill body |
| #2 | PR #37 | three visual gates |
| #3 | PR #56 `8d78f19` | golden fixtures (+ absorbed #5) |
| #6 | PR #19 `46fac43` | spelling-in-image |
| #7 | PR #26 `02292a1` | hallucination inventory |
| #8 | PR #45 | pixel-perfect deltas |
| #29 | PR #53 `c496bad` | PDF / Illustrator / graphics companions |
| #49 | PR #61 `2d23921` | harvest skills |
| #57 | PR #66 `3c630f8` | Playwright visual capture |
