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

## Per-image walk

On each artifact, in order:

1. **Read every visible word** (G1). Transcribe CTAs, headings, badges, errors, legal lines. Compare to brief glossary. One misspelled product name is a blocker.
2. **Overlay brief regions** (G2). For each named region in the brief, mark found / missing / wrong size. Measure obvious deltas (px) and color (hex) when a mock exists. Clipped text and contrast fails live here.
3. **Subtract brief objects** (G3). Anything left on the image that the brief did not authorize is invented chrome. Tag `NOT_IN_BRIEF`.
4. **Missing artifact** — if the brief requires a state/breakpoint and no image was supplied, add a G2 or `brief` row. Do not invent pixels to fill the gap.

## Severity rubric

| Severity | Use when |
|----------|----------|
| blocker | Wrong or missing primary CTA; misspelled product/brand name; invented primary nav; required screen/state absent; copy that contradicts the brief. |
| major | Contrast fail; overflow/clip; 8px+ misalignment vs mock; extra secondary chrome; wrong hex when brief names a token. |
| nit | 1–2px drift; minor casing when brief is not explicit; decorative extras that do not change the task. |

A single blocker forces verdict **FAIL**. Majors without blockers are still **FAIL** if they break the task; otherwise **PASS-nits candidate**. Zero defects is **candidate PASS-UAT, Bob stamp required** — not a UAT stamp.

## Brief glossary (U4 locked)

Extract a glossary before G1. Prefer `docs/glossary.md` or a `## Glossary` table in the brief. Else build one from LOCKED names in the spec.

| Field | Meaning |
|-------|---------|
| token | kebab-case id (`primary_cta`, `brand`) |
| phrase | exact visible string |
| region | brief region the phrase belongs to |
| optional | true if missing is a nit, not a blocker |

G1 compares transcribed image text to `phrase`. Unknown extra words that are not glossary tokens go to G3 (`NOT_IN_BRIEF`) unless they are ordinary chrome the brief waived.

## Gate scorecard

Fill the report scorecard before the verdict. Each gate is **fail** (blocker or task-breaking major), **nits** (nit-only), or **clear**.

| Gate | fail | nits | clear |
|------|------|------|-------|
| G1 | any blocker spelling | casing/minor only | no G1 rows |
| G2 | missing required region, contrast, 8px+ | 1–2px | no G2 rows |
| G3 | invented primary chrome | decorative extra | no G3 rows |
| brief | contradiction | missing optional acceptance | no brief rows |

Verdict follows the worst cell: any **fail** → FAIL; only **nits** → PASS-nits candidate; all **clear** → candidate PASS-UAT, Bob stamp required.

## Examples (text only)

- G1 fail: brief phrase `Book a table`, image shows `Bok a table` → blocker.
- G2 nits: mock primary button 16px below header, image 18px → nit, not FAIL.
- G3 fail: brief nav is Home/Book; image adds Admin → blocker `NOT_IN_BRIEF`.
- brief fail: brief says primary CTA is both `Book` and `Buy` with no winner.

Do not invent fixture PNGs here. Golden/adversarial images are #3/#5.

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
