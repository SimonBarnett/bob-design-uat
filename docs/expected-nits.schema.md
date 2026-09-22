# expected-nits.yaml schema (P1/P2)

Golden (#3) and adversarial (#5) packs use this shape. This seed does **not** add fixture images.

```yaml
fixture_id: T-G01
gate: G1   # G1 | G2 | G3 | brief
severity: blocker  # blocker | major | nit
brief_field: primary_cta
where: hero / primary button
expected: "Book a table"
actual: "Bok a table"
not_in_brief: false
clean_control: false
```

## Rules

- One file per fixture directory: `fixtures/<pack>/<id>/expected-nits.yaml` (list of nits; empty list only for the clean control).
- `clean_control: true` requires zero nits.
- `gate` must match the skill tags G1/G2/G3/brief.
- `brief_field` names the brief heading or token the nit cites.
- Do not commit secrets or live customer screenshots with PII.
