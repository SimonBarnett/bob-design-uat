/**
 * Example Playwright hook for G2 layout overlap (#71).
 * Copy into your capture script; do not commit live URLs or credentials.
 * Returns pairs of selectors whose visible bounding boxes intersect.
 */
export async function findOverlappingElements(page, selector = '[data-uat-visible]') {
  return page.evaluate((sel) => {
    const rects = [...document.querySelectorAll(sel)]
      .filter((el) => {
        const s = getComputedStyle(el);
        return s.visibility !== 'hidden' && s.display !== 'none' && el.getBoundingClientRect().width > 0;
      })
      .map((el) => {
        const r = el.getBoundingClientRect();
        return {
          selector: el.tagName.toLowerCase() + (el.id ? `#${el.id}` : ''),
          x: r.x,
          y: r.y,
          w: r.width,
          h: r.height,
        };
      });

    function intersects(a, b) {
      return a.x < b.x + b.w && a.x + a.w > b.x && a.y < b.y + b.h && a.y + a.h > b.y;
    }

    const pairs = [];
    for (let i = 0; i < rects.length; i++) {
      for (let j = i + 1; j < rects.length; j++) {
        if (intersects(rects[i], rects[j])) {
          pairs.push({ a: rects[i].selector, b: rects[j].selector });
        }
      }
    }
    return pairs;
  }, selector);
}
