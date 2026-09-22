---
name: pdf-uat
description: >
  Visual UAT of PDF briefs and print artifacts using design-uat G1-G3.
  Use when the user says PDF UAT, review this PDF, print proof, text
  layer vs raster, multi-page PDF, or /pdf-uat. Workers do not stamp
  ready for human UAT (Bob only).
---

# PDF UAT

Parent skill: `design-uat` (same G1/G2/G3, same report template, same verdicts).
Do not add a G4. Do not invent pages.

## When

The brief or the artifact is a **PDF** (campaign, print, leaflet, brief PDF).

## Procedure

1. Inventory pages. Missing pages the brief names are a `brief` / G2 row. Do not invent a page.
2. **G1 (spelling):** if a text layer exists, read **that** for words. Raster/OCR is fallback only when there is no text layer — say so in Evidence. Do not silently OCR-only a searchable PDF.
3. **G2 / G3:** rasterize each page (pdftoppm, agent vision, or exported PNG) for layout, contrast, and invented chrome. Text-layer G1 does not skip G2/G3.
4. Emit `docs/templates/design-uat-report.md` rows. Verdicts: `FAIL` / `PASS-nits candidate` / `candidate PASS-UAT, Bob stamp required` only.

## Do not

- Flatten to a screenshot and throw away a live text layer.
- Stamp ready for human UAT.
- Open live instance URLs or commit secrets.
