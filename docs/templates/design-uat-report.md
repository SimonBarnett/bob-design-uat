# Design UAT report

**Job / PR:**  
**Brief:** (link or path)  
**Artifacts reviewed:** (file names + dimensions if known)  
**Reviewer agent:**  
**SHA or build id:**  

## Inventory

| # | Artifact | Brief section | Notes |
|---|----------|---------------|-------|
| 1 | | | |

## Nit list (G1 | G2 | G3 | brief)

| gate | where | expected | actual | severity |
|------|-------|----------|--------|----------|
| | | | | |

### G1 — Spelling-in-image

(Summary or extra rows if needed.)

### G2 — Layout-delta / pixel-perfect

(Summary or extra rows if needed.)

### G3 — Hallucination / invented chrome

(Summary or extra rows if needed.)

## Brief fidelity

| Requirement | Status | Evidence |
|-------------|--------|----------|
| | pass / fail / nit | |

## Verdict (evidence only)

Choose one:

- **FAIL** — blockers listed above; not ready for MRB PASS-nits on product PR.
- **PASS-nits candidate** — no blockers; cosmetic nits only; product PR may proceed to hostile MRB.
- **candidate PASS-UAT, Bob stamp required** — all gates green; **Bob** must still stamp ready for human UAT.

**Blockers:**  
**Nits:**  
**Evidence commands run:** (e.g. BT0 validator, manual BT1)
