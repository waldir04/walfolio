# Design System — Airfolio

**Document type**: Design system
**Status**: Proposed
**Last updated**: 2026-11-26
**Owner**: Waldir
**Source of truth for**: Design tokens, type scale, spacing, radii, borders, shadows, button/link/card rules
**Reference analysis**: [`design-reference.md`](./design-reference.md)
**Component catalog**: [`component-inventory.md`](./component-inventory.md)
**Walfolio adaptation**: [`implementation-decisions.md`](./implementation-decisions.md)

---

## 1. Purpose and Source-of-Truth Rule

This document is the single source of truth for Walfolio's design tokens. Other design documents must reference token names from this file rather than restating values.

The system is extracted from `style_guide.jpg` and validated against the numbered homepage exports. Values are marked:

- **Verified** — directly observed or measured in the references.
- **Approx.** — visually estimated; cannot be extracted exactly from JPG.
- **Proposed** — introduced for Walfolio implementation; not present in the reference.
- **Open** — undecided or requires owner/design input.

No accessibility exception has been approved. The teal button contrast concern in §11 is an open decision.

---

## 2. Color Tokens

### 2.1 Palette

**Verified / Approx.** — sampled from rendered swatches and homepage exports.

| Token | Value | Status | Source | Intended use |
| --- | --- | --- | --- | --- |
| `color.white` | `#FFFFFF` | Verified | Sections/cards | Page and card surfaces |
| `color.surface-subtle` | `#F5F8FF` | Verified | Hero, Services, Experience | Light section background |
| `color.navy-800` | `#1C1C58` | Verified | Headings, footer, CTA | Primary dark text and dark surfaces |
| `color.navy-700` | `#3E3E70` | Verified | Body text, trust strip | Secondary text and secondary dark surface |
| `color.text-muted` | `#6E6E93` | Approx. | Supporting copy, meta | Muted text |
| `color.teal-primary` | `#088D84` | Verified | Primary buttons, accents | Primary action and brand accent |
| `color.blue-accent` | `#255BF8` | Verified | Testimonial band, links, blue CTA | Secondary accent and links |
| `color.magenta-accent` | `#AA29A0` | Verified | Style-guide swatch; icons/decorations | Decorative accent; not a primary action color |
| `color.surface-pale-teal` | `#F0F9F8` | Verified | FAQ CTA card | Pale accent surface |
| `color.surface-tag` | `#F4F4F4` | Verified | Tag pills | Small metadata surface |
| `color.surface-card-alt` | `#FDFDFF` | Verified | Stat cards | Card surface variant |
| `color.border-subtle` | `≈#E6E9F0` | Approx. | Card edges/shadows | Hairline separation |
| `color.ui-black` | `#000000` | Verified | Style-guide UI demos; FAQ borders | Reference-only UI black; not a general text token |

### 2.2 Color rules

**Verified**

- Headings use `color.navy-800`; body copy uses `color.navy-700`; muted copy uses `color.text-muted`.
- Primary actions use `color.teal-primary`; secondary accent surfaces/links use `color.blue-accent`.
- `color.magenta-accent` appears in decorative gradients and icons, not as a button fill.
- Light sections use `color.surface-subtle`; dark bands use `color.navy-800`, except the trust strip, which uses `color.navy-700`.

**Proposed**

- Do not substitute Wal product colors for this palette. The reference identity is the palette.
- Avoid using `color.magenta-accent` for text on light surfaces; its contrast is not established.
- Keep `color.ui-black` out of the Walfolio component set unless a specific reference element requires it.

**Reference-only tokens**

`color.surface-pale-teal`, `color.surface-card-alt`, and `color.ui-black` are retained for reference completeness. Their associated patterns (FAQ CTA card, stat cards, style-guide UI) are omitted or unused in the initial Walfolio page. They may support future extensions but are not required by the initial section order.

**Open**

- Exact border color and shadow tint cannot be extracted from JPG (OI-01).
- Whether `color.navy-700` is an independent token or an opacity variant of `color.navy-800` is not verifiable. It is treated as an independent token because it is a measured surface and text color.

### 2.3 Reference style-guide defect

The style guide's printed “Main Colors” labels do not match the swatches:

- The teal swatch is labeled with the blue value.
- The blue swatch is labeled with a yellow value.
- The magenta swatch repeats the yellow value.
- “Primary 2” is duplicated.

The token values above come from the rendered swatches and homepage samples, not from the printed labels.

---

## 3. Typography

### 3.1 Font family

| Token | Value | Status |
| --- | --- | --- |
| `font.family` | Inter | Verified |

Inter is declared in the style guide. No other typeface appears.

### 3.2 Type scale

**Verified** — extracted from `style_guide.jpg`.

| Token | Size | Rem | Line height | Typical use |
| --- | ---: | ---: | ---: | --- |
| `type.h1` | 56 px | 3.5 rem | 120% | Hero headline |
| `type.h2` | 48 px | 3 rem | 120% | Section headlines |
| `type.h3` | 40 px | 2.5 rem | 120% | Subsection/feature headline |
| `type.h4` | 24 px | 1.5 rem | 140% | Card/feature title |
| `type.h5` | 24 px | 1.5 rem | 140% | Same as H4 in the reference |
| `type.h6` | 20 px | 1.25 rem | 140% | Minor heading |
| `type.text-xl` | 20 px | 1.25 rem | 150% | Lead paragraph / prominent body |
| `type.text-lg` | 18 px | 1.125 rem | 150% | Large body |
| `type.text-md` | 16 px | 1 rem | 150% | Default body |
| `type.text-sm` | 14 px | 0.875 rem | 150% | Secondary body/meta |
| `type.text-xs` | 12 px | 0.75 rem | 150% | Fine print/labels |

**Reference defect**: H4 and H5 are identical in the style guide. For Walfolio, `type.h4` is the canonical 24 px heading; `type.h5` is retained as an alias only for reference completeness.

### 3.3 Weights and styling

| Property | Value | Status |
| --- | --- | --- |
| Body weight | ≈400 | Approx. |
| Navigation/button weight | ≈500 | Approx. |
| Heading weight | ≈600–700 | Approx. |
| Letter spacing | Not specified | Open (OI-01) |
| Paragraph measure | ≈60–70 characters in reference | Approx. |

**Proposed**

- Use `type.h1` only for the page's single H1.
- Use `type.h2` for section headlines and `type.h3`/`type.h4` for card hierarchy.
- Default body is `type.text-md`; supporting copy is `type.text-sm` or `type.text-lg` where the reference uses a larger measure.
- Maintain the reference's tight heading line height (120%) and generous body line height (150%).

**Open**

- Exact font weights and variable-font settings require visual calibration (OI-01).
- Spanish text expansion may require tighter heading max-widths or adjusted line breaks (OI-10).

---

## 4. Layout, Container, and Spacing

### 4.1 Layout tokens

| Token | Value | Status | Notes |
| --- | --- | --- | --- |
| `layout.container` | ≈1280 px | Verified / Approx. | Primary content width at the 1440 px reference; ≈80 px gutters |
| `layout.container-wide` | ≈1312–1320 px | Verified / Approx. | About/Projects media extend wider; exact shared token unknown |
| `layout.header-height` | 88 px | Verified | Desktop reference |
| `layout.section-padding-y` | ≈80–120 px | Approx. | Varies by section |
| `layout.grid-gap-sm` | ≈20 px | Approx. | Experience 2×2 cards |
| `layout.grid-gap-md` | ≈32 px | Approx. | Services 4-column grid |
| `layout.grid-gap-lg` | ≈44 px | Approx. | Projects and Blog 2-column grids |
| `layout.hero-text-split` | ≈573 px / ≈611 px | Verified / Approx. | Text/visual columns at 1440 px |
| `layout.faq-measure` | ≈766 px | Verified / Approx. | Centered FAQ column; reference only |

### 4.2 Grid patterns

**Verified**

| Pattern | Columns | Used by |
| --- | --- | --- |
| Hero split | 2 | Hero |
| About split | 2 | About Me |
| Experience split | 2 (content + media), with a 2×2 card grid inside the content column | Professional Experience |
| Skills grid | 4 equal columns | Skills & Capabilities |
| Wal grid | 2 columns | Wal Ecosystem (two initial cards; scalable) |
| Blog grid | 2 columns | Blog (reference only; omitted) |
| Footer | Brand + link columns | Footer |

**Proposed**

- Use CSS Grid with fluid `minmax()` tracks rather than fixed pixel widths.
- Keep the reference's 4-column → 2-column → 1-column reflow for card grids.
- Preserve the two-column split until the layout cannot support the text measure, then stack.

### 4.3 Spacing scale

**Proposed** — a practical scale consistent with the observed rhythm. It is not extracted from the reference.

| Token | Value |
| --- | ---: |
| `space.1` | 4 px |
| `space.2` | 8 px |
| `space.3` | 12 px |
| `space.4` | 16 px |
| `space.5` | 24 px |
| `space.6` | 32 px |
| `space.7` | 40 px |
| `space.8` | 48 px |
| `space.9` | 64 px |
| `space.10` | 80 px |
| `space.11` | 120 px |

**Open**: exact section padding and component spacing tokens require calibration against the references (OI-01).

---

## 5. Radii, Borders, Shadows

### 5.1 Radii

| Token | Value | Status | Use |
| --- | ---: | --- | --- |
| `radius.button` | ≈8 px | Approx. | Buttons |
| `radius.card` | ≈12 px | Approx. | Cards, panels |
| `radius.media` | ≈16–20 px | Approx. | Large images/media |
| `radius.pill` | ≈4 px | Approx. | Tags/category labels |
| `radius.circle` | 9999 px | Verified | Avatars, circular controls |

### 5.2 Borders

| Token | Value | Status | Use |
| --- | --- | --- | --- |
| `border.hairline` | 1 px `color.border-subtle` | Approx. | Card separation |
| `border.outline-teal` | 1 px `color.teal-primary` | Verified | Secondary button |
| `border.dark-row` | 1 px dark border, visually near-black | Verified / Approx. | FAQ accordion in the reference; not used in initial Walfolio scope |

### 5.3 Shadows

**Verified**

The style guide defines an eight-step scale named `xxsmall`, `xsmall`, `small`, `medium`, `large`, `xlarge`, `xxlarge`, `xxxlarge`. The last labels are ambiguous in the export.

**Open**: exact shadow values are not extractable from JPG (OI-01).

**Proposed implementation ramp** — not extracted; calibrate during visual validation.

| Token | Proposed value |
| --- | --- |
| `shadow.xxsmall` | `0 1px 2px rgba(28, 28, 88, 0.04)` |
| `shadow.xsmall` | `0 2px 4px rgba(28, 28, 88, 0.05)` |
| `shadow.small` | `0 4px 8px rgba(28, 28, 88, 0.06)` |
| `shadow.medium` | `0 8px 16px rgba(28, 28, 88, 0.08)` |
| `shadow.large` | `0 12px 24px rgba(28, 28, 88, 0.10)` |
| `shadow.xlarge` | `0 16px 32px rgba(28, 28, 88, 0.12)` |
| `shadow.xxlarge` | `0 24px 48px rgba(28, 28, 88, 0.14)` |
| `shadow.xxxlarge` | `0 32px 64px rgba(28, 28, 88, 0.16)` |

**Rule**: cards in the reference use a restrained shadow plus a hairline separation; avoid heavy elevation.

---

## 6. Buttons and Links

### 6.1 Button variants

**Verified variants** (sizes Approx.)

| Token | Background | Text | Border | Status |
| --- | --- | --- | --- | --- |
| `button.primary` | `color.teal-primary` | White | None | Verified |
| `button.secondary` | Transparent | `color.teal-primary` | 1 px `color.teal-primary` | Verified |
| `button.blue` | `color.blue-accent` | White | None | Verified |
| `button.inverted-primary` | White | `color.navy-800` | None | Verified (on navy CTA) |
| `button.inverted-secondary` | Transparent | White | 1 px white | Verified (on navy CTA) |
| `button.ui-dark` | `color.ui-black` | White | None | Verified in style guide; not a Walfolio brand button |
| `button.ui-outline` | Transparent | Black | 1 px black | Verified in style guide; not a Walfolio brand button |

**Shared button specifications**

| Property | Value | Status |
| --- | --- | --- |
| Radius | `radius.button` | Approx. |
| Height | ≈52 px desktop; ≈48 px header CTA | Approx. |
| Horizontal padding | ≈24 px | Approx. |
| Label style | `type.text-md`, weight ≈500–600 | Approx. |
| Icon spacing | ≈8 px when an icon is present | Approx. |
| Focus state | Not shown | Open (OI-14) |

**Interaction states**: hover, active, focus-visible, and disabled states are not shown in the references. They are implementation decisions, not extracted design.

### 6.2 Links

| Token | Style | Status |
| --- | --- | --- |
| `link.inline` | `color.blue-accent`, optional trailing arrow | Verified |
| `link.nav` | `color.navy-800`, `type.text-md` | Verified |
| `link.footer` | White/light text on navy | Verified |
| `link.legal` | Small underlined text in the footer | Verified |

**Proposed**: inline links must have visible hover and focus-visible states; the reference does not show them.

---

## 7. Cards, Surfaces, and Tags

### 7.1 Card rules

**Verified / Approx.**

| Property | Value | Status |
| --- | --- | --- |
| Surface | `color.white` or `color.surface-card-alt` | Verified |
| Radius | `radius.card` | Approx. |
| Padding | ≈24–32 px | Approx. |
| Border | Hairline `color.border-subtle` or none | Approx. |
| Shadow | Restrained, diffuse | Verified behavior; values Open |
| Media radius | Top corners rounded; image may be full-bleed within the card | Approx. |

### 7.2 Surface variants

| Token | Value | Use |
| --- | --- | --- |
| `surface.section-light` | `color.surface-subtle` | Hero, Skills & Capabilities, Professional Experience |
| `surface.section-white` | `color.white` | About Me, Wal Ecosystem |
| `surface.dark` | `color.navy-800` | CTA, footer |
| `surface.secondary-dark` | `color.navy-700` | Trust strip; reference only / omitted |
| `surface.accent` | `color.blue-accent` | Testimonial band; reference only / omitted |
| `surface.pale-teal` | `color.surface-pale-teal` | FAQ CTA card; reference only / not used |
| `surface.tag` | `color.surface-tag` | Tags and category labels |

### 7.3 Tags and metadata

| Property | Value | Status |
| --- | --- | --- |
| Background | `color.surface-tag` | Verified |
| Text | `color.navy-800` or body color | Verified |
| Radius | `radius.pill` | Approx. |
| Size | `type.text-sm` or smaller | Approx. |
| Padding | ≈6–10 px vertical, ≈10–12 px horizontal | Approx. |

Tags are reusable for project categories, product status labels, and metadata. Walfolio product status labels must use honest wording (OI-07).

---

## 8. Iconography and Decoration

**Verified**

- Service icons are line-style illustrations with a blue/violet/magenta gradient.
- Social/brand icons are monochrome; footer social icons sit beside text labels.
- Testimonial controls use circular arrow buttons; pagination uses small dots.
- FAQ rows use a plus icon.
- Project/blog links use a trailing arrow.
- Decorative assets include a painterly brush stroke, filled circle, outlined square, ring, rounded blob, and hand-drawn line art.

**Proposed**

- Recreate geometric decorations as SVG where practical; keep the brush stroke as an optimized transparent raster if its texture is required.
- Use one icon family for UI icons; do not mix filled and line styles arbitrarily.
- Mark decorative assets as non-semantic (`aria-hidden`) in implementation.
- Do not use the magenta accent as a status color without a defined semantic meaning.

**Open**

- Icon source/library is not selected; no dependency is introduced at this stage (OI-13).
- Exact icon stroke widths and gradient stops are not extractable (OI-01).

---

## 9. Motion and Interaction

**Verified**

- The references show no animation, transition, or micro-interaction states.
- The accordion, carousel, and dropdown imply interaction but expose no behavior.

**Proposed**

- Keep motion minimal and functional: navigation, accordion (only if reintroduced), and optional carousel controls.
- Any motion must respect `prefers-reduced-motion`.
- Do not autoplay a carousel; the reference does not establish that behavior.
- Buttons and links need hover and focus-visible states designed during implementation.

**Open**

- Interaction states and motion guidelines are not specified by the reference (OI-01).

---

## 10. Responsive Tokens

**Proposed** — no mobile/tablet references exist.

| Token | Value | Notes |
| --- | --- | --- |
| `breakpoint.mobile` | `< 768 px` | Single-column layouts |
| `breakpoint.tablet` | `768–1279 px` | 2-column grids, stacked splits |
| `breakpoint.desktop` | `≥ 1280 px` | Reference layout |
| `layout.container-fluid` | `100% - 2 × gutter` | Gutter: ≈20–24 px mobile, ≈32–48 px tablet, ≈80 px desktop |
| `type.h1.mobile` | Proposed ≈40 px | Calibrate during implementation |
| `type.h2.mobile` | Proposed ≈32–36 px | Calibrate during implementation |

**Rule**: responsive values are proposals, not extracted design. They must be validated visually and adjusted to preserve hierarchy.

---

## 11. Accessibility Notes

**Verified baseline from the Product Overview**

- Keyboard-operable navigation and controls.
- Sufficient color contrast.
- Alternative text for imagery.
- Visible focus states.
- Correct heading structure.
- Subtitles if video introductions ship.

**Contrast measurements** (approximate, computed from sampled hex values)

| Pair | Approx. ratio | Assessment |
| --- | ---: | --- |
| `color.navy-800` on `color.surface-subtle` | ≈14.6:1 | Strong |
| `color.navy-700` on `color.surface-subtle` | ≈9.3:1 | Strong |
| White on `color.blue-accent` | ≈5.4:1 | Passes AA for normal text |
| `color.text-muted` on white | ≈4.8:1 | Passes AA for normal text |
| White on `color.teal-primary` | ≈4.1:1 | **Below AA 4.5:1 for normal text** |

### 11.1 Teal button contrast concern

**Open — no resolution approved**

- The reference's primary teal button uses white text at approximately 4.1:1 contrast.
- WCAG AA requires 4.5:1 for normal-size text; large text and non-text UI require 3:1.
- This documentation does **not** change the reference color and does **not** declare an accessibility exception.
- Resolution options must be decided before implementation (OI-15, under OD-06):
  - Darken the teal used for text-bearing buttons while preserving the reference identity.
  - Use a larger/bolder label that qualifies as large text.
  - Record an explicitly approved exception, if the owner chooses fidelity over AA for this element.

**Open**: the formal accessibility conformance target is undecided (OD-06 / OI-14).

---

## 12. Token Governance

- This file is the only place where color, type, layout, spacing, radius, border, and shadow values are defined.
- Other documents reference token names such as `color.teal-primary` or `type.h2`.
- Token changes require updating this file first.
- Tokens marked **Approx.** or **Proposed** must be validated against the references before being treated as final.
- New visual patterns not present in the references must be labeled **Proposed** and justified in [`implementation-decisions.md`](./implementation-decisions.md).

**Related open items**

- OI-01 — Figma source/token availability.
- OI-14 — accessibility target.
- OI-15 — teal button contrast.
- OI-10 — Spanish text expansion.

See the Open Items Register in [`implementation-decisions.md`](./implementation-decisions.md).
