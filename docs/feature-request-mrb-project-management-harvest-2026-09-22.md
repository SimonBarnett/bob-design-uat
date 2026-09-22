# FR: harvest MRB / project-management playbooks

**Issue:** https://github.com/SimonBarnett/bob-design-uat/issues/49  
**Parked:** 2026-09-22 by MRB of #3 (SHA 88b562c3) — issue had no intake doc.  
**Repo:** SimonBarnett/bob-design-uat  
**Source:** issue #49 body as filed: "Havert best practive prohect management for engineering mrbs"

## Ask (as filed)

Harvest best-practice project management for engineering MRBs.

## Gap vs tree

| Area | Now | Residual |
|------|-----|----------|
| Intake | Issue #49 body only; no `/docs` markdown; no `feature-request` label | This file |
| Product surface on this repo | None. design-uat is visual UAT (G1–G3), not fleet MRB ritual | UNKNOWN whether Simon wants a product skill here |
| Existing playbook | `SimonBarnett/agentic_build` skills `bob-hostile-mrb`, `bob-job-loop`, `harvest-agent-skills` | Do not duplicate those skills into this repo unless a later lock says so |

## Locked

- No UAT stamp. Bob chairs human UAT.
- No `password=` / `XAI_API_KEY=` assignments in git.
- Do not second-take #2 / #3 / #6 / #7 / #8.

## MUST NOT

- Implement this harvest inside a golden-fixture (#3) FIX.
- Push `main` or merge own PR.

## Acceptance (UNKNOWN until Simon locks)

| ID | Check |
|----|--------|
| A-H1 | Simon confirms home repo (`bob-design-uat` vs `agentic_build`) |
| A-H2 | If home is `agentic_build`, close #49 as duplicate of existing MRB/harvest skills after a comment link |
| A-H3 | If home is this repo, name the skill path and BT0 needles in a follow-on edit of this file |

## Unknown

- Whether this is a product FR or a fleet-ops harvest already owned by `harvest-agent-skills`.
- What "project management for engineering MRBs" adds beyond `bob-hostile-mrb` / `bob-job-loop`.
