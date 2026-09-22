---
name: illustrator-uat
description: >
  Visual UAT of Adobe Illustrator sources via proof export, then
  design-uat G1-G3. Use when the user says Illustrator, .ai review,
  artboard proof, AI PDF, or /illustrator-uat. Workers do not stamp
  ready for human UAT (Bob only).
---

# Illustrator UAT

Parent skill: `design-uat`. Same G1/G2/G3. Do not add a G4.
Do not invent artboards. Do not parse the `.ai` binary as the picture.

## When

The artifact is **`.ai`**, an Illustrator-exported PDF, or "review the Illustrator file".

## Procedure

1. Inventory artboards the brief names. A binary `.ai` **without** a proof (PDF or PNG per artboard) is incomplete: `brief` row, do not hallucinate the board.
2. Export or accept a **proof** (PDF or PNG per artboard). Then run `design-uat` / `pdf-uat` on those proofs.
3. Linked/missing placed files the brief requires: G2 or `brief`, not invented pixels.
4. Same report template and worker verdicts as `design-uat`.

## Out of scope

- Illustrator desktop / Creative Cloud automation.
- Figma API (`design-uat` U2).

## Do not

- Invent artboards from the `.ai` zip/PDF dump.
- Stamp ready for human UAT.
- Commit secrets.
