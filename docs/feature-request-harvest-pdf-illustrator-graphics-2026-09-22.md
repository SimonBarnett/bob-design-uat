# Feature request: harvest PDF, Illustrator, and graphics skills

**Repo:** https://github.com/SimonBarnett/bob-design-uat  
**Raised:** Simon on #bobiverse 2026-09-22 — “this should harvest pdf, illustrator and graphics skills” + “can I have an FR please”  
**Parked by:** ce-priority-dev1-11904  
**Dispatch:** no (park only; 16948 already looping #2 #3 #7 #8)

## Intent of the project

`design-uat` is Bob’s **visual UAT** skill: compare a brief to what the user will actually see, then fail on spelling (G1), layout (G2), and invented chrome (G3). Workers never stamp human UAT.

The product is supposed to cover **real design artifacts**, not only PNG screenshots. Fleet work ships PDFs (briefs, print, campaign), Illustrator sources, and other graphics (SVG, exported boards). Those files are the brief-or-the-art, same as a mock PNG.

## Good

- G1/G2/G3 + report template + BT0 validator already exist on main (`46fac43`).
- Spec L3 already allows “PDF pages as images” and Figma exports.
- Severity rubric and fail-closed G1 are settled; do not invent a fourth gate.

## Bad

- Skill inputs are **raster-first**. PDF is flattened to page images, so selectable PDF text and vector outlines are thrown away before G1.
- **Illustrator (`.ai`)** is not named. No harvest path from an Illustrator/graphics skill.
- No install/harvest step that copies PDF / Illustrator / graphics playbooks into `~\.grok\skills` next to `design-uat`.
- Figma API is still UNKNOWN (U2); that is not this FR.

## Ugly

- “PDF pages as images” pretends a print brief is a screenshot. OCR on a rasterized PDF will miss or invent spelling that the PDF text layer already has.
- Agents will open `.ai` as zip/PDF and wander without a skill that says: export a proof, then run G1–G3 on the proof — never invent pixels from the binary.

## The feature

**Harvest (or write) PDF, Illustrator, and graphics skills into this repo and wire them as inputs to `design-uat`.** Same three gates. Do not replace G1–G3.

### Skills to land (or stub + harvest)

| ID | Skill | Trigger / job |
| --- | --- | --- |
| S1 | `pdf-uat` (or section in `design-uat`) | Native PDF: use text layer for G1; rasterize each page only for G2/G3. Multi-page inventory. |
| S2 | `illustrator-uat` | `.ai` / AI-exported PDF: proof export (PDF or PNG per artboard), then G1–G3 on proofs. Do not invent artboards. |
| S3 | `graphics-uat` | SVG and other still graphics the brief names. Same report template. |

Harvest means: copy playbooks into `.grok/skills/<name>/SKILL.md` in this repo, `docs/skill-harvest-log.md` note, and `Install-DesignUatSkill.ps1` (or sibling install) copies them to `~\.grok\skills`. Prefer extending existing public playbooks over inventing a new product.

### Acceptance

1. `design-uat` SKILL.md **Inputs** list PDF (text + pages), Illustrator (`.ai` / AI PDF), and SVG/graphics — not only PNG/JPG/WebP.
2. Procedure: PDF G1 reads the text layer when present; raster is G2/G3. Missing text layer is called out, not silently OCR-only.
3. `.ai` path: export/proof then gates. Binary `.ai` without a proof is `brief` / incomplete — do not hallucinate the board.
4. BT0 lists the new skill files. Validator still exits 0.
5. One fixture note or tiny sample (one-page PDF **or** SVG) in `docs/` or fixtures showing a G1 hit from text, not from a screenshot of that PDF.
6. Workers still only `FAIL` / `PASS-nits candidate` / `candidate PASS-UAT, Bob stamp required`.

### LOCKED / UNKNOWN

- **LOCKED:** G1–G3 names and Bob-only UAT stamp. Do not add G4.
- **LOCKED:** do not break existing PNG fixture FRs (#3 #5 #7 #8).
- **UNKNOWN:** which exact upstream Illustrator/PDF skill to harvest if none exists in `agentic_build` / `~\.grok\skills` — write the playbook here rather than block.
- **UNKNOWN:** Illustrator desktop automation. Out of scope; proof export is enough.

### Out of scope

- Figma API (U2).
- Implementing 16948’s open loops (#2 #3 #7 #8).
- Dispatch from this park.
