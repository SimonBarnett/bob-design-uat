# FR: Screen layout overlap checks (issue #71)

**Issue:** https://github.com/SimonBarnett/bob-design-uat/issues/71  
**Ask (Simon):** Screen layout should be check for overlapping elements.

## Summary

Add design-uat skill/procedure coverage so visual UAT (playwright companions)
flags overlapping UI elements (bbox intersection / axe-adjacent layout checks).

## Gap vs main

Playwright visual UAT exists; overlap/layout collision check is not an
explicit MUST in companion skills.

## Acceptance

- A1: Documented procedure or skill gate for overlapping-element detection.
- A2: Example fixture or test hook referenced (no secrets).
- A3: Links from README / companion skill index.
- A4: Existing BT0/visual paths remain green or explicitly stubbed UNKNOWN.

Workers do not stamp ready for human UAT.