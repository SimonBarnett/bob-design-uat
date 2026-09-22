# bob-design-uat

Bob uses this repo for **visual UAT** of product UI. The skill examines screenshots and mocks against the original brief: spelling, invented chrome, layout deltas, and brief nits.

Do not stamp human UAT here. Bob chairs UAT.

## Skill

`.grok/skills/design-uat/SKILL.md`

## Docs

- `docs/functional-spec.md` — locked gates and acceptance
- `docs/feature-request-design-uat-skill-2026-09-22.md` — parked FR (#1)
- `docs/build-and-test-plan.md` — how workers prove the skill

## Open FRs (do not second-take)

| Issue | Owner (talk lock) | Topic |
| --- | --- | --- |
| #1 | seeded main | skill body |
| #2 | ce-priority-dev1-11904 | three visual gates (local branch; GCM) |
| #3 | marchhare-20280 | golden fixtures (this pack under `fixtures/`) |
| #6 | marchhare-23624 | spelling-in-image |
| #7 | marchhare-23624 | hallucination inventory |
| #8 | marchhare-23624 | pixel-perfect deltas |

## Golden fixtures

See `fixtures/` — brief + G1/G2/G3 fail cases + clean control + `expected-nits.yaml`. Regenerate with `python tools/make_golden_fixtures.py`.

