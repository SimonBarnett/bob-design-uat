# FR: three visual gates (OCR spelling, layout-delta, invented chrome)

Date: 2026-09-22
Issue: https://github.com/SimonBarnett/bob-design-uat/issues/2
Repo: https://github.com/SimonBarnett/bob-design-uat

#4 was closed as a duplicate of this issue.

## Ask

Three gates vs the original brief: OCR spelling, layout-delta (pixel-perfect), invented chrome = hallucination. Nit list only. No UAT stamp.

## Gap vs tree (after P0 / #1)

| Area | Now | Residual |
|------|-----|----------|
| Skill G1–G3 | Landed on e393982 (`SKILL.md`) | None at procedure level |
| Proof the gates fail real pixels | Missing | #3 fixture pack |
| Gate depth | Skill text only | #6 G1, #7 G3, #8 G2 |

This FR's skill-text MUST is satisfied by #1 P0. Do not re-implement G1–G3. Remaining work lives on #3 / #6 / #7 / #8.

## Locked

- Gates are G1 / G2 / G3 as in `docs/functional-spec.md` L4.
- Bob chairs UAT. No secrets.

## Unknown

- OCR engine (U1), Figma API (U2), G2 tolerance (U3), glossary format (U4).
