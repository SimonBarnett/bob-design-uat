# FR: spelling-in-image must fail the check

Date: 2026-09-22
Issue: https://github.com/SimonBarnett/bob-design-uat/issues/6
Repo: https://github.com/SimonBarnett/bob-design-uat

## Ask

Vision/OCR on submitted screenshots flags misspellings in chrome, labels, and body copy vs the original brief glossary / product names. Any typo fails this check.

## Gap vs tree (after P0 / #1)

| Area | Now | Residual |
|------|-----|----------|
| G1 procedure | In `.grok/skills/design-uat/SKILL.md` | Glossary not named (U4) |
| OCR engine | Agent vision only (U1) | Engine / language packs not locked |
| Proof | No fixture | #3 T-G01 |

Do not rewrite G1. Remaining: glossary format + fixture proof (+ OCR engine if Simon locks U1).

## Locked

- Typos vs brief / product names fail G1.
- No UAT stamp. No secrets.

## Unknown

- OCR engine, language pack, how briefs supply the glossary (U1, U4).
