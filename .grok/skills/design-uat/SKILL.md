---
name: design-uat
description: >
  Bob visual UAT of product UI. Examine screenshots and mocks against the
  original brief for spelling mistakes, hallucinations, UI fuck-ups,
  pixel-perfect layout, and brief nits. Use when Bob says UAT, visual UAT,
  screenshot review, mock vs brief, spelling-in-image, G1 G2 G3 gates,
  pixel-perfect, or /design-uat. Workers do not stamp ready for human UAT
  (Bob only).
---

# Design UAT

Read the original brief first. Then inspect every supplied image. Report defects with gate tags **G1**, **G2**, **G3**. Do not praise.

**MRB for this skill repo:** `SimonBarnett/bob-design-uat` issue #1. Product PRs use that product's FR + `bob-hostile-mrb`.

## Inputs

- **Brief:** issue, `docs/*.md`, FR markdown, or operator paste. Brief wins.
- **Artifacts:** PNG/JPG/WebP, Figma exports, PDF pages as images. Do not invent pixels.
- **Optional:** reference mock for pixel-perfect **G2**.

## Procedure

1. Inventory artifacts and map each to brief sections (screens, states, breakpoints).
2. Run **G1 → G2 → G3** on each image (plus brief-fidelity rows where a state is missing).
3. Emit nit list using `docs/templates/design-uat-report.md`. Empty nits means no defect found — not a UAT stamp.

## G1 — Spelling-in-image (OCR / vision)

Visible words must match the brief and ordinary spelling. Fail on typos, wrong product names, missing letters, lorem left in place, inconsistent casing when brief is explicit.

## G2 — Layout-delta / pixel-perfect

Compare regions, spacing, alignment, sizes, and colors to the brief or supplied mock. Report deltas in px or hex when visible. "Looks close" is not a pass when brief demands pixel-perfect. Include contrast, clipping, overflow, and broken grids here.

## G3 — Hallucination / invented chrome

Fail on controls, brands, nav items, data, imagery, or copy the brief did not authorize. Tag `NOT_IN_BRIEF` when the invention is obvious.

## Brief nits

Review the brief for contradictions, missing acceptance, or copy no UI can satisfy. Tag gate `brief` in the report.

## Nit row format

| Field | Value |
|-------|--------|
| gate | G1 \| G2 \| G3 \| brief |
| where | artifact + region or brief heading |
| expected | from brief or mock |
| actual | what you see |
| severity | blocker \| major \| nit |

## Verdict (workers)

Allowed only:

- **FAIL** — blockers present.
- **PASS-nits candidate** — nits only; product PR may go to hostile MRB.
- **candidate PASS-UAT, Bob stamp required** — all gates green; **Bob** still applies the human UAT stamp.

Bob alone may declare **ready for human UAT**. Workers must not post that phrase as their own stamp or final **PASS-UAT**.

## Do not

- Push `main` or merge your own PR.
- Second-create this repo or re-take owner-locked FRs.
- Commit secrets or `password=` / API key assignments.
- Treat Halloy as a fleet nick (Simon client).

## Repo self-check

When changing this skill repo, run `tools/Validate-DesignUatSkill.ps1` (BT0).
