#!/usr/bin/env python3
"""Generate fixtures/ golden pack for issue #3."""
from __future__ import annotations

from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

ROOT = Path(__file__).resolve().parents[1] / "fixtures"


def font(size: int = 28) -> ImageFont.ImageFont:
    for name in (
        r"C:\Windows\Fonts\arial.ttf",
        r"C:\Windows\Fonts\segoeui.ttf",
        r"C:\Windows\Fonts\calibri.ttf",
    ):
        p = Path(name)
        if p.is_file():
            return ImageFont.truetype(str(p), size)
    return ImageFont.load_default()


def base() -> tuple[Image.Image, ImageDraw.ImageDraw]:
    img = Image.new("RGB", (800, 400), (255, 255, 255))
    return img, ImageDraw.Draw(img)


def main() -> None:
    ROOT.mkdir(exist_ok=True)
    f = font(32)
    f_sm = font(20)

    (ROOT / "brief.md").write_text(
        """# Fixture brief — Club Madeira host CTA card

## Screen
Host recruitment card, 800x400, white background.

## Required copy (exact)
- Title: Smart Catalogue
- CTA button: Join as host
- Subtitle: Embed on your club site

## Layout
- Title top-left at ~24px margin, color #111111
- CTA button bottom-left, fill #0B6E4F, text white, 160x44
- No other buttons or brand marks

## Colors
- Background #FFFFFF
- Accent/CTA #0B6E4F
""",
        encoding="utf-8",
    )

    img, d = base()
    d.text((24, 24), "Smart Catalogue", fill=(17, 17, 17), font=f)
    d.text((24, 70), "Embed on your club site", fill=(80, 80, 80), font=f_sm)
    d.rectangle([24, 320, 184, 364], fill=(11, 110, 79))
    d.text((40, 330), "Join as host", fill=(255, 255, 255), font=f_sm)
    img.save(ROOT / "clean-control.png")

    img, d = base()
    d.text((24, 24), "Smart Catalogue", fill=(17, 17, 17), font=f)
    d.text((24, 70), "Embed on your club site", fill=(80, 80, 80), font=f_sm)
    d.rectangle([24, 320, 184, 364], fill=(11, 110, 79))
    d.text((36, 330), "Join as hosst", fill=(255, 255, 255), font=f_sm)
    img.save(ROOT / "g1-spelling.png")

    img, d = base()
    d.text((24, 24), "Smart Catalogue", fill=(17, 17, 17), font=f)
    d.text((24, 70), "Embed on your club site", fill=(80, 80, 80), font=f_sm)
    d.rectangle([24, 320, 184, 364], fill=(180, 40, 40))
    d.text((40, 330), "Join as host", fill=(255, 255, 255), font=f_sm)
    img.save(ROOT / "g2-layout-color.png")

    img, d = base()
    d.text((24, 24), "Smart Catalogue", fill=(17, 17, 17), font=f)
    d.text((24, 70), "Embed on your club site", fill=(80, 80, 80), font=f_sm)
    d.rectangle([24, 320, 184, 364], fill=(11, 110, 79))
    d.text((40, 330), "Join as host", fill=(255, 255, 255), font=f_sm)
    d.rectangle([220, 320, 400, 364], fill=(30, 30, 30))
    d.text((235, 330), "Buy now", fill=(255, 255, 255), font=f_sm)
    d.text((600, 24), "AWS Lambda", fill=(120, 120, 120), font=f_sm)
    img.save(ROOT / "g3-hallucination.png")

    (ROOT / "expected-nits.yaml").write_text(
        """# Golden fixture expected nits (FR #3 + #5 clean-control notes)
# severity: blocker | major | nit
fixtures:
  clean-control.png:
    brief: brief.md
    expected_nits: []
  g1-spelling.png:
    brief: brief.md
    expected_nits:
      - gate: G1
        where: g1-spelling.png CTA label
        expected: Join as host
        actual: Join as hosst
        severity: blocker
  g2-layout-color.png:
    brief: brief.md
    expected_nits:
      - gate: G2
        where: g2-layout-color.png CTA fill
        expected: "#0B6E4F"
        actual: "#B42828 (approx red, not brief accent)"
        severity: major
  g3-hallucination.png:
    brief: brief.md
    expected_nits:
      - gate: G3
        where: g3-hallucination.png extra button
        expected: only CTA Join as host
        actual: Buy now button
        severity: blocker
        tag: NOT_IN_BRIEF
      - gate: G3
        where: g3-hallucination.png top-right copy
        expected: no AWS / Lambda lead
        actual: AWS Lambda text
        severity: blocker
        tag: NOT_IN_BRIEF
""",
        encoding="utf-8",
    )

    (ROOT / "README.md").write_text(
        """# Golden fixtures (issue #3)

Brief + PNGs + `expected-nits.yaml` for repeatable design-uat scoring.

| Artifact | Gate exercised | Expect |
| --- | --- | --- |
| `clean-control.png` | — | zero nits |
| `g1-spelling.png` | G1 | CTA typo `hosst` |
| `g2-layout-color.png` | G2 | CTA fill not `#0B6E4F` |
| `g3-hallucination.png` | G3 | `Buy now` + `AWS Lambda` not in brief |

Regenerate: `python tools/make_golden_fixtures.py`

Workers: review against `brief.md`, compare to `expected-nits.yaml`. Do not stamp UAT.
""",
        encoding="utf-8",
    )
    print("ok", sorted(p.name for p in ROOT.iterdir()))


if __name__ == "__main__":
    main()
