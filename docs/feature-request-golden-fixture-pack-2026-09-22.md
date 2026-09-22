# FR: golden + adversarial fixture pack

Date: 2026-09-22
Issue: https://github.com/SimonBarnett/bob-design-uat/issues/3
Repo: https://github.com/SimonBarnett/bob-design-uat

Absorbs closed #5 (dup): clean control + `expected-nits.yaml` per case.

## Ask

Repeatable fixture pack so design-uat scoring is calibrated before real product UAT.

## Gap vs tree (after P0 / #1)

| Area | Now | After this FR |
|------|-----|----------------|
| `fixtures/golden/<case>/` | Missing | `brief.md`, screenshot, `expected-nits.yaml` |
| Adversarial stills | Missing | 4–6 known-bad PNGs (from #5) |
| Clean control | Missing | One image → zero nits (plan T-A00) |

P0 skill/validator/template (#1) does **not** ship this pack.

## Locked

- Tree: `fixtures/golden/<case>/` with brief + image + expected nits.
- Cases: T-G01 misspelling → G1; T-G02 layout → G2 px/hex; T-G03 hallucination → G3 `NOT_IN_BRIEF`.
- Bad pack: misspelled CTA, wrong hex, extra chrome, 1px miss, hallucinated logo text.
- One clean control: zero nits.
- Workers do not stamp ready-for-human-UAT. No secrets in git.

## Unknown

- OCR engine / language packs (U1).
- Exact screenshot source (Figma export vs PNG still).
- G2 tolerance if Simon later waives pixel-perfect (U3).

## Acceptance

| ID | Acceptance |
|----|------------|
| F3-A1 | T-G01/T-G02/T-G03 exist with expected nit class |
| F3-A2 | 4–6 bad fixtures fail the expected class |
| F3-A3 | Clean control returns zero nits |
