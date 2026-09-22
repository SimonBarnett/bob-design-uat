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

**Fail-closed (#6):** any G1 typo in chrome, labels, body copy, or product names (vs the brief or glossary) is a **blocker**, not a cosmetic nit. The check **FAIL**s. Do not downgrade a misspelling to PASS-nits.

## G2 — Layout-delta / pixel-perfect

Compare regions, spacing, alignment, sizes, and colors to the brief or supplied mock. Report deltas in px or hex when visible. "Looks close" is not a pass when brief demands pixel-perfect. Include contrast, clipping, overflow, and broken grids here.

**Deltas (#8):** every G2 row must include at least one of `delta_px` or `delta_hex` in the report and fixture `expected-nits.yaml`. A G2 without a measurement is incomplete.

## G3 — Hallucination / invented chrome

Fail on controls, brands, nav items, data, imagery, or copy the brief did not authorize. Tag `NOT_IN_BRIEF` when the invention is obvious.

**Inventory (#7):** list every visible chrome, copy, image, and flow item; mark each `in_brief` (yes) or `NOT_IN_BRIEF`. Missing inventory is incomplete even if no hallucination is found.

## Per-image walk

On each artifact, in order:

1. **Read every visible word** (G1). Transcribe CTAs, headings, badges, errors, legal lines, and labels. Compare to the brief and glossary. Any typo vs the brief or glossary is a G1 **blocker** (not only product names).
2. **Overlay brief regions** (G2). For each named region in the brief, mark found / missing / wrong size. Measure deltas (px) and color (hex) for every G2 row. Clipped text and contrast fails live here.
3. **Inventory chrome/copy/images/flows** (G3). List each visible item; mark `in_brief` or `NOT_IN_BRIEF`. Subtract brief objects — anything unauthorized is invented chrome.
4. **Missing artifact** — if the brief requires a state/breakpoint and no image was supplied, add a G2 or `brief` row. Do not invent pixels to fill the gap.

## Severity rubric

| Severity | Use when |
|----------|----------|
| blocker | Wrong or missing primary CTA; **any G1 typo** (chrome, labels, body copy, product/brand names vs brief or glossary); invented primary nav; required screen/state absent; copy that contradicts the brief. |
| major | Contrast fail; overflow/clip; 8px+ misalignment vs mock; extra secondary chrome; wrong hex when brief names a token. |
| nit | 1–2px drift; decorative extras that do not change the task. (Misspellings vs brief/glossary are G1 blockers, not nits.) |

A single blocker forces verdict **FAIL**. Majors without blockers are still **FAIL** if they break the task; otherwise **PASS-nits candidate**. Zero defects is **candidate PASS-UAT, Bob stamp required** — not a UAT stamp.

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
| delta_px | G2 only — px delta when measured |
| delta_hex | G2 only — hex delta when measured |

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
