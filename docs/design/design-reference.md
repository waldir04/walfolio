# Design Reference — Airfolio

**Document type**: Design analysis
**Status**: Proposed
**Last updated**: 2026-11-26
**Owner**: Waldir
**Source of truth for**: Reference observations and section structure
**Design tokens**: Defined only in [`design-system.md`](./design-system.md)
**Adaptation decisions**: See [`implementation-decisions.md`](./implementation-decisions.md)
**Component catalog**: See [`component-inventory.md`](./component-inventory.md)

---

## 1. Purpose and Scope

This document records what the Airfolio reference contains: its page sequence, section purposes, layout structure, visual composition, and reference limitations.

It does **not** define design tokens (colors, type scale, spacing values). Those live in [`design-system.md`](./design-system.md). It also does not decide Walfolio's content mapping; that is recorded in [`implementation-decisions.md`](./implementation-decisions.md).

The analysis is based on seven JPG exports in `docs/design/references/airfolio/`. No Figma file, source assets, or mobile/tablet references were provided.

---

## 2. Status Vocabulary

The same vocabulary is used across the four design documents:

| Status | Meaning in these documents |
| --- | --- |
| **Verified** | Directly observed in the reference exports or measured from them. |
| **Proposed** | A design or implementation decision made for Walfolio, not present in the reference. |
| **Assumption** | A working default that has not been confirmed and may change. |
| **Open** | Undecided, missing, or blocked on owner input. Cross-referenced in the Open Items Register in [`implementation-decisions.md`](./implementation-decisions.md). |

---

## 3. Source Files

**Verified**

| File | Dimensions | Role |
| --- | ---: | --- |
| `style_guide.jpg` | 1358 × 5569 | Visual system reference |
| `01.jpg` | 1440 × 1007 | Header, hero, start of trust strip |
| `02.jpg` | 1440 × 2012 | Services, About |
| `03.jpg` | 1440 × 3099 | Experience, Projects, start of testimonial band |
| `04.jpg` | 1440 × 775 | Testimonials |
| `05.jpg` | 1440 × 1619 | FAQs, pre-footer CTA |
| `06.jpg` | 1440 × 1847 | Blog/Inspiration, footer |

The numbered files are consecutive crops of one desktop homepage. They are not alternate designs and must not be reordered.

---

## 4. Reference Limitations

**Verified**

- **Desktop only.** There are no tablet or mobile exports.
- **Flattened JPGs.** Exact spacing, radii, shadow values, gradients, font weights, and interaction states cannot be extracted with confidence.
- **Cropped sections.** `01.jpg` cuts off the trust strip. `03.jpg` ends with the start of the blue testimonial band that continues in `04.jpg`.
- **No product pages.** The references contain only a homepage. Walday and Walplay detail pages have no design reference.
- **No interaction evidence.** Hover, focus, active, accordion-open, dropdown-open, and carousel states are not shown.
- **Placeholder content.** Copy, testimonials, company logos, project screenshots, and blog entries are template placeholders, not verified claims.

**Reference inconsistency — style guide**

The style guide's “Main Colors” labels do not match the rendered swatches. The teal swatch carries a blue hex label, the blue swatch carries a yellow hex label, the magenta swatch repeats the same yellow label, and “Primary 2” appears twice. The rendered swatch colors were sampled and are recorded in [`design-system.md`](./design-system.md). The printed labels are treated as a reference defect.

Other style-guide inconsistencies:

- H4 and H5 are both listed at the same size.
- The shadow scale's final labels are ambiguous (`xxlarge`/`xxxlarge`).
- Font weights, text style names, letter spacing, and paragraph widths are not labeled.

---

## 5. Homepage Sequence

**Verified** — order is preserved exactly as exported. Walfolio's adapted names are shown for continuity with the other documents.

| # | Airfolio section | Walfolio section | Reference | Background token | Band height | Purpose |
| --- | --- | --- | --- | --- | --- | --- |
| 0 | Header / navigation | Header | `01.jpg` | `color.white` | `layout.header-height` | Logo, nav, secondary links, primary CTA |
| 1 | Hero | Hero | `01.jpg` | `surface.section-light` | ≈688 px | Identity statement, supporting copy, two CTAs, portrait |
| 2 | Trust strip | *(omitted unless verified)* | `01.jpg` (cut) | `surface.secondary-dark` | ≈225 px visible | Claimed company logos and endorsement |
| 3 | Services | Skills & Capabilities | `02.jpg` | `surface.section-light` | ≈1017 px | Service offering, four icon cards, CTA pair |
| 4 | About | About Me | `02.jpg` | `surface.section-white` | ≈992 px | Personal story, photograph, stats, profile CTA |
| 5 | Experience | Professional Experience | `03.jpg` | `surface.section-light` | ≈1161 px | Role cards and supporting image |
| 6 | Projects | Wal Ecosystem | `03.jpg` | `surface.section-white` | ≈1935 px incl. transition | Work/product cards, detail links, portfolio CTA |
| 7 | Testimonials | *(omitted)* | `04.jpg` | `surface.accent` | ≈634 px at edge | Social proof carousel |
| 8 | FAQs | *(omitted)* | `05.jpg` | `surface.section-white` | ≈1120 px | Accordion questions and contact prompt |
| 9 | Pre-footer CTA | Contact | `05.jpg` | `surface.dark` | ≈499 px | Final conversion band |
| 10 | Blog / Inspiration | *(omitted)* | `06.jpg` | `surface.section-white` | ≈1300 px | Article teasers |
| 11 | Footer | Footer | `06.jpg` | `surface.dark` | ≈536 px | Navigation, newsletter, social, legal |

**Measurement note**: heights are background-band heights at the left edge of each export. Diagonal transitions make the true section height vary across the viewport, and some bands are cut by the export boundary.

---

## 6. Section Analysis

Each subsection begins with verified structure. Approximate visual judgments are marked with “≈”, “approx.”, or a qualifying phrase; anything not supported by the exports is identified as unknown.

### 6.1 Header

**Verified**

- White surface; full-width row; measured desktop height is recorded as `layout.header-height` in [`design-system.md`](./design-system.md).
- Logo and wordmark left; inline navigation (About Us, Services, Portfolio, Pages dropdown, Cart); teal CTA (“Hire Me”) right.
- Links and CTA align on a single horizontal band.
- The header does not overlap the hero in the export; it sits on its own white band.

**Relationship**: establishes the container and spacing rhythm used by the hero and lower sections.

**Unknown**: stickiness, dropdown contents, cart behavior, and hover/focus states are not shown.

### 6.2 Hero

**Verified**

- Two-column composition on a light surface.
- Left column: small eyebrow, three-line H1, body copy, two side-by-side buttons. Text is left-aligned.
- Right column: a portrait photograph cropped at the bottom, layered over a painterly brush stroke.
- Decorative geometric shapes appear at the corners and around the portrait: a filled circle, an outlined square, a ring, and a rounded blob.
- Measured text and visual column widths are recorded as `layout.hero-text-split` in [`design-system.md`](./design-system.md); the columns are separated by a broad gap.
- The portrait area extends to the right edge of the content container and is cut by the hero's bottom edge.

**Relationship**: the hero sets the brand palette and the two-button pattern reused later. Its light background transitions directly into the dark trust strip.

**Unknown**: the brush stroke is a raster asset; its construction, resolution, and transparent bounds cannot be verified from the flattened export.

### 6.3 Trust Strip

**Verified**

- Dark strip immediately below the hero.
- Left-aligned label (“Trusted by top companies worldwide”) and five monochrome logos.
- The strip is cut by the `01.jpg` export boundary; its full height and bottom transition are not visible.
- The endorsements are template placeholders and are not evidence of any relationship.

**Walfolio status**: omitted unless populated with verified information (OI-17). See [`implementation-decisions.md`](./implementation-decisions.md).

### 6.4 Services (Walfolio: Skills & Capabilities)

**Verified**

- Light surface with an angled lower edge into the white About section.
- Split section header: eyebrow and two-line H2 on the left; supporting paragraph on the right.
- Four equal-width cards in one row. Each card has a gradient line icon, a short title, and a paragraph.
- Cards sit on white surfaces with a soft shadow and a large corner radius.
- A centered pair of buttons follows the grid.
- The section closes with a broad diagonal transition.

**Relationship**: introduces the card grid used again for Experience, Projects, and Blog. The centered button pair echoes the hero.

**Note**: the cards are framed as commercial services (“UI/UX Design”, “Webflow development”, “Marketing”, “Branding”). Walfolio adapts the structure to capabilities, not services.

### 6.5 About

**Verified**

- White surface.
- Two columns: a large photograph on the left with two decorative circular shapes overlapping its corners; content on the right.
- Right column: eyebrow, two-line H2, paragraph, three stat cards in a row, and a teal button.
- The photograph is portrait-oriented and cropped; the decorative shapes sit partly outside the image bounds.
- The section header is left-aligned.

**Relationship**: the only section that pairs a media block with quantitative proof. The stat cards are visually reusable but their content is placeholder.

**Note**: the statistics (project count, satisfaction percentage, design project percentage) are invented template data. Walfolio removes this pattern unless verified facts are supplied (OI-05).

### 6.6 Experience (Walfolio: Professional Experience)

**Verified**

- Light surface with an angled lower edge into the white Projects section.
- Two columns: content on the left, a tall photograph on the right with decorative shapes at its top-right and bottom-left.
- Left column: eyebrow, two-line H2, paragraph, then a 2×2 grid of role cards.
- Each role card contains a platform/brand icon, a role title, a date range, and a short description.
- The right photograph is cropped and bottom-aligned; decorative shapes overlap its corners.

**Relationship**: reverses the About split (content left, media right) while keeping the same two-column rhythm.

**Note**: the roles, companies, and dates are template placeholders and must not be reused.

### 6.7 Projects (Walfolio: Wal Ecosystem)

**Verified**

- White surface with a diagonal exit into the blue testimonial band.
- Centered section header: eyebrow, H2, supporting line.
- 2×2 project cards. Each card has a large landscape thumbnail, a title, a paragraph, three tag pills, and a “View project →” link.
- Cards have a light border and a soft shadow; thumbnails are rounded at the top.
- A centered teal button (“Check the full Portfolio”) follows the grid.
- The bottom edge is a broad blue diagonal that begins the next section.

**Relationship**: the most directly reusable work-presentation pattern. It supports a scalable grid for Walday, Walplay, and future work.

**Note**: project screenshots and names are template placeholders.

### 6.8 Testimonials (Omitted from Walfolio Initial Scope)

**Verified**

- Full-bleed blue band with diagonal top and bottom edges.
- Centered five-star row, quote, author row (avatar, name, role, company logo), circular previous/next buttons at the outer edges, and five pagination dots.
- Content is horizontally centered and constrained to a narrow reading measure.

**Interaction**: the arrows and dots strongly imply a carousel, but autoplay, swipe, and transition behavior are not shown.

**Walfolio status**: omitted by owner decision D4. No personal quote is introduced as a substitute (owner decision D5). See [`implementation-decisions.md`](./implementation-decisions.md).

### 6.9 FAQs (Omitted from Walfolio Initial Scope)

**Verified**

- White surface.
- Centered header and supporting line.
- Five stacked accordion rows with a question, a plus icon, and a thin dark border.
- A pale-teal CTA card follows the accordion: heading, supporting line, and a teal “Contact” button.
- Row borders are visually near-black; the exact border token is not reliably separable from JPG compression.

**Interaction**: plus icons imply expand/collapse, but no open state is shown.

**Walfolio status**: omitted for the initial scope by owner decision D4. No FAQ content exists. See the Open Items Register in [`implementation-decisions.md`](./implementation-decisions.md).

### 6.10 Pre-Footer CTA (Walfolio: Contact)

**Verified**

- Full-bleed navy band with an angled top edge.
- Decorative line-art scribbles in the corners.
- Centered H2, supporting line, and two buttons: a white filled button and a white outlined button.
- The band sits directly above the footer.

**Relationship**: provides a strong dark pause before the footer and mirrors the hero's two-button pattern in inverted colors.

**Note**: the heading uses “AirWave”, a template artifact inconsistent with “Airfolio”; it is not Walfolio content.

### 6.11 Blog / Inspiration (Omitted from Walfolio Initial Scope)

**Verified**

- White surface.
- Centered header with eyebrow, H2, and supporting line.
- 2×2 cards. Each card has a landscape thumbnail on the left and content on the right: category pill, read-time label, two-line title, excerpt, and “Read more →” link.
- A centered blue button (“Browse Articles”) follows the grid.

**Walfolio status**: omitted; blog/articles are outside the confirmed product scope.

### 6.12 Footer

**Verified**

- Navy surface, straight top edge.
- Left block: logo/wordmark, short newsletter introduction, email input, Subscribe button, and consent text.
- Right area: four link columns (Page, Shop, Utility Pages, Follow us) with social icons in the last column.
- Bottom bar: copyright line and three legal links, separated by a hairline divider.

**Walfolio status**: adapted. Newsletter, Shop, and Utility Pages are removed; the link columns become personal navigation and contact/social links.

### 6.13 Media and Aspect-Ratio Observations

**Approx.** — ratios cannot be confirmed without source assets.

- Hero portrait: tall portrait cutout, cropped at the hero's bottom edge; no fixed ratio is established.
- About photograph: approximately square/portrait crop, with decorative circles overlapping the corners.
- Experience photograph: tall portrait crop, bottom-aligned, with decorative shapes at opposite corners.
- Project thumbnails: wide landscape images, approximately 2:1 within the card.
- Blog thumbnails: near-square images occupying the left portion of a wide card.
- Testimonial avatar: small circular crop.

These observations describe the reference composition. Walfolio asset crops and final aspect ratios depend on the supplied photography (OI-13).

---

## 7. Page Composition and Transitions

**Verified**

- The page alternates light, white, and dark bands. The light bands are Hero, Services, and Experience; white bands are About, Projects, FAQs, and Blog; dark bands are the trust strip, testimonial band, CTA, and footer.
- Diagonal transitions are a signature composition device, not incidental decoration:
  - Services → About (light to white).
  - Experience → Projects (light to white).
  - Projects → Testimonials (white to blue).
  - Testimonials → FAQs (blue to white).
  - FAQs → CTA (white to navy).
- The CTA → Footer boundary is straight.
- Vertical padding varies by section; the approximate desktop range is recorded as `layout.section-padding-y` in [`design-system.md`](./design-system.md).
- Text alignment: Hero, Services, About, and Experience are left-aligned; Projects, Testimonials, FAQs, CTA, and Blog are centered.
- Repeated layout patterns:
  - Two-column split: Hero, About, Experience.
  - Four-column card grid: Services.
  - 2×2 card grid: Experience, Projects, Blog.
  - Centered section header: Projects, Testimonials, FAQs, CTA, Blog.
  - Split section header: Services.
- Repeated action patterns:
  - Filled primary + outlined secondary (Hero, Services).
  - Single filled CTA (About, Projects).
  - Inverted filled + outlined pair on dark (CTA).
- Text hierarchy is consistent: eyebrow → H2 → body → CTA; the hero substitutes H1 for H2.

**Proposed Walfolio implication**: preserve the alternating bands and diagonal transitions even when the trust strip, testimonials, FAQs, and blog are omitted. The resulting sequence still has enough light/white/dark contrast to retain the reference identity.

---

## 8. Desktop-Only Scope

**Verified**

- All seven references are desktop exports at 1440 px width, except the style guide at 1358 px.
- No tablet or mobile composition, navigation pattern, type scale, or card behavior exists in the references.

**Consequences**

- Desktop layout, proportions, and section order are verified.
- Tablet and mobile layouts are **Proposed** in [`implementation-decisions.md`](./implementation-decisions.md); they are not extracted from Figma.
- Responsive behavior must preserve hierarchy, palette, typography character, and section rhythm rather than copy desktop pixel values.

---

## 9. Reference Observations and Ambiguities

**Verified observations**

- The style guide declares Inter, and the homepage letterforms are visually consistent with it. Exact rendered type sizes were not measured.
- The homepage uses the teal, blue, navy, magenta, white, and light-surface palette recorded in [`design-system.md`](./design-system.md).
- The trust strip uses a lighter navy surface than the footer/CTA; this is a distinct observed surface, not a measurement artifact.
- The hero and experience portraits are cut out/cropped at section edges; the brush and decorative shapes are layered assets.
- The FAQ rows use a much darker border than the project/blog cards.

**Ambiguities**

- Exact container behavior: header, Services, and Blog align to approximately the same container; About and Projects media extend slightly wider. A single container token with a media bleed is plausible but unconfirmed.
- Exact shadow values, gradients, and radii are not extractable from JPG.
- Font weights are not labeled; visual weights are approximate.
- The style guide's color labels are unreliable (see §4).
- The style guide's H4/H5 duplication may be intentional or an export defect.
- Interaction states and behaviors are not verifiable.

**Template artifacts that must not be carried into Walfolio**

- “AirWave” in the CTA and “airdokan” in the style guide.
- “Jane Cooper”, “John Doe”, lorem ipsum, invented statistics, and placeholder company logos.
- Commercial navigation and footer items: Cart, Shop, Utility Pages, newsletter.
- Claims of client relationships or service offerings.

---

## 10. Cross-References

- Design tokens and visual rules: [`design-system.md`](./design-system.md)
- Reusable component catalog: [`component-inventory.md`](./component-inventory.md)
- Walfolio mapping, responsive proposals, product pages, and open items: [`implementation-decisions.md`](./implementation-decisions.md)
- Product requirements and decision IDs: [`../product-overview.md`](../product-overview.md)
