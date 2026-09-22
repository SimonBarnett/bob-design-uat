---
name: design-uat
description: >
  Bob visual UAT of product UI. Examine screenshots and mocks against the
  original brief for spelling mistakes, hallucinations, UI fuck-ups,
  pixel-perfect layout, and brief nits. Use when Bob says UAT, visual UAT,
  screenshot review, mock vs brief, spelling-in-image, hallucination
  inventory, pixel-perfect, or pick nits on a design. Do not stamp human UAT
  (Bob only).
---

# Design UAT

Read the original brief first. Then look at every supplied image. Report defects. Do not praise. Do not stamp ready-for-human-UAT.

## Inputs

- Brief: issue, `docs/*.md`, or the FR the worker is UAT-ing.
- Images: screenshots, mocks, or renders the worker already has. Do not invent image bytes.
- Optional reference mock for pixel-perfect compare.

## Procedure

1. Extract required copy, layout regions, CTAs, and named objects from the brief.
2. Run the five gates below on each image.
3. Emit a nit list. Empty list means no defect found, not a UAT stamp.

## Gates

### 1. Spelling-in-image

Visible words must match the brief and ordinary spelling. Fail on typos, missing letters, and product names the brief did not use.

### 2. Hallucination / invented chrome

Fail if the image shows controls, brands, nav, data, or copy the brief did not ask for.

### 3. UI fuck-ups

Fail on overflow, clipped text, unreadable contrast, missing required fields, wrong primary CTA, or empty required regions.

### 4. Pixel-perfect / layout-delta

Compare to the brief layout or a supplied mock. Report alignment, spacing, size, and missing/extra regions. "Looks close" is not a pass.

### 5. Brief nits

Also review the brief itself: contradictions, missing acceptance, and copy the UI cannot satisfy.

## Nit format

- gate: one of the five names
- where: image + region or brief heading
- expected: from the brief or mock
- actual: what the image or brief shows
- severity: blocker | major | nit

## Do not

- Stamp human UAT.
- Second-create this repo or second-take an owner-locked FR.
- Commit secrets, live PINs, or customer PII.
- Treat Halloy as a fleet nick. Halloy is Simon's client.
