# FR: pixel-perfect deltas vs brief or mock

Date: 2026-09-22
Issue: https://github.com/SimonBarnett/bob-design-uat/issues/8
Repo: https://github.com/SimonBarnett/bob-design-uat

## Ask

Compare screenshot to brief/mock. Report alignment, spacing, type size, and color deltas in px / hex. Unexplained delta is a nit.

## Gap vs tree (after P0 / #1)

| Area | Now | Residual |
|------|-----|----------|
| G2 px/hex rule | In `.grok/skills/design-uat/SKILL.md` | Tolerance not locked (U3) |
| Proof | No fixture | #3 T-G02 |

Do not rewrite G2. Remaining: fixture with measured deltas; tolerance only if Simon locks U3.

## Locked

- Pixel-perfect means deltas are listed, not "looks close".
- No UAT stamp. No secrets.

## Unknown

- Mock source; G2 tolerance if Simon later allows one (U3).
