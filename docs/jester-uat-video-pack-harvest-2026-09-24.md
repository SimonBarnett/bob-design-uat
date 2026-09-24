# Harvest: UAT video pack skill (2026-09-24)

**From:** Jester (Priority UAT agent) per Simon  
**Into:** `SimonBarnett/bob-design-uat`  
**Skill:** `.grok/skills/uat-video-pack/SKILL.md`

## Why

Simon (2026-09-24) split Priority UAT:

- **Standard test skill** → fastest path (WCF / Web SDK); screenshots only on full PASS.
- **Video / human pack** → separate skill (this harvest).

Former standing rules lived inside Priority orchestrator sources under `agentic_fomprep` (`priority-uat-orchestrator` human video packs). They move here so design/visual UAT owns human packs; functional Priority skills stop mandating video on every PASS.

## Source material

Harvested from Jester standing rules (2026-09-15 video pack iterations) and `agentic_fomprep` UAT harvest 2026-09-24 orchestrator wording:

- Human speed; `-draw_mouse 1`; click ripples; idle cuts; burn-in subtitles; correct DISPLAY.
- Gate A human pack delivery pattern (reject empty-desktop captures).

CE Priority DISPLAY examples stay as examples only; skill is product-agnostic.

## Related

- `agentic_fomprep` FR draft: fast UAT path + separate video skill (park when Cursor usage allows).
- Draft PR #44 on `agentic_fomprep` still holds functional UAT skill bodies (should drop mandatory video once this skill lands).

## Acceptance

- [ ] `.grok/skills/uat-video-pack/SKILL.md` present
- [ ] README lists the skill
- [ ] `tools/Validate-DesignUatSkill.ps1` still PASS (or updated allowlist)
- [ ] Bob MRB; no self-merge
