# Golden fixtures (issue #3)

Brief + PNGs + `expected-nits.yaml` for repeatable design-uat scoring.

| Artifact | Gate exercised | Expect |
| --- | --- | --- |
| `clean-control.png` | — | zero nits |
| `g1-spelling.png` | G1 | CTA typo `hosst` |
| `g2-layout-color.png` | G2 | CTA fill not `#0B6E4F` |
| `g3-hallucination.png` | G3 | `Buy now` + `AWS Lambda` not in brief |

Regenerate: `python tools/make_golden_fixtures.py`

Workers: review against `brief.md`, compare to `expected-nits.yaml`. Do not stamp UAT.
