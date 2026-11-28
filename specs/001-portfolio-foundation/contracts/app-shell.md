# Contract: Application Shell

**Feature**: `001-portfolio-foundation` | **Type**: UI/DOM contract

Defines the only DOM the foundation may render. Later section specifications extend the page but
must preserve every MUST below.

## Document

| Requirement | Rule |
| --- | --- |
| Document language | `<html lang="en">` in `index.html`; the active locale matches the rendered text |
| Title | A single minimal title consisting of the confirmed Walfolio name. This static `<title>` is the one documented metadata exception to text externalization: it is pre-bootstrap metadata, not component copy, and moves when D-002 is resolved |
| Metadata | No meta description, canonical URL, Open Graph/Twitter tags, structured data, sitemap, or alternates. These are blocked by D-002 |
| Entry | `index.html` → `src/main.tsx` → `@/app/App` |
| Assets | No favicon, logo, icon font, portrait, or image asset is invented or referenced |

## Shell structure

```text
body
└── main
    └── h1  →  English resource: home.title ("Walfolio")
```

**MUST**

- Render exactly one `main` landmark and exactly one `h1`.
- Take the H1 text from `src/shared/i18n/en.ts`; no hardcoded user-facing rendered copy.
- Keep the static `<title>` limited to the confirmed Walfolio name and record it as the only
  text-externalization exception.
- Render a logical heading hierarchy (one H1, no skipped levels).
- Use semantic HTML with no `role` attributes that duplicate native semantics.
- Inherit the shared focus-visible and reduced-motion behavior even though no focus stop exists.
- Be token-driven: no raw hex colors, arbitrary spacing, radii, or shadows outside the token
  source.

**MUST NOT**

- Render `header`, `nav`, `footer`, `aside`, or any landmark with no real content.
- Render links, buttons, inputs, selects, textareas, or any focusable control.
- Render a skip link (no repeated navigation exists) or a language switcher.
- Render portfolio sections, placeholder cards, "coming soon" copy, lorem ipsum, or invented
  claims.
- Render a text-bearing primary button (teal contrast is `Open`).
- Claim WCAG 2.2 AA or any formal conformance in markup, comments, or documentation.
- Hide horizontal overflow globally to mask a layout defect.
- Use fixed heights that prevent text expansion.

## Accessibility baseline

| Requirement | Foundation behavior |
| --- | --- |
| Keyboard operability | Vacuously satisfied: zero focusable elements. Recorded, not claimed as a passed interaction test |
| Focus indicator | Defined once in the shared styling layer for future components; not clipped or obscured |
| Bypass mechanism | Not required until the first change introduces repeated navigation; that change MUST add one targeting the main content |
| Target size | Not exercised; binds the first interactive component (≥ 44 × 44 px) |
| Color-only meaning | None introduced |
| Reduced motion | `prefers-reduced-motion: reduce` neutralizes transitions/animations at the styling layer |
| Automated checks | axe-core runs on the rendered container; `color-contrast` disabled with documented reason (jsdom has no layout) |

## Verification

- `HomePage.test.tsx`: one `main`, one H1 with the resource text, no header/nav/footer/controls,
  no console noise.
- `accessibility.test.tsx`: axe-core clean on the rendered shell, one `main`, one H1, zero focusable
  elements.
- Document test: `index.html` contains `lang="en"`, a single `#root` mount node, the module entry,
  no metadata/assets beyond the minimal title, and the title is the only source literal.
- Manual: keyboard traversal exposes no focus stop (recorded as such), five validation widths show
  no horizontal overflow, reduced-motion rendering inspected.

## Change rule

Any change that introduces navigation or an interactive control MUST update this contract: add the
bypass mechanism, extend focus and target-size verification, and update the tests. Such a change
belongs to a later specification, not to this foundation.
