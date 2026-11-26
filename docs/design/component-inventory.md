# Component Inventory — Airfolio

**Document type**: Component analysis
**Status**: Proposed
**Last updated**: 2026-11-26
**Owner**: Waldir
**Design tokens**: [`design-system.md`](./design-system.md) (source of truth)
**Reference analysis**: [`design-reference.md`](./design-reference.md)
**Walfolio adaptation**: [`implementation-decisions.md`](./implementation-decisions.md)

---

## 1. Purpose

This document catalogs the reusable interface components visible in the Airfolio reference. For each component it records purpose, structure, relevant design properties, reuse potential, verified interactions, and Walfolio usage.

Design values are referenced by token name only. All token values are defined in [`design-system.md`](./design-system.md).

Document-level status uses the same four terms as the other design documents:

- **Verified** — visible in the reference or measured from it.
- **Proposed** — introduced for Walfolio, not present in the reference.
- **Assumption** — a working default that may change.
- **Open** — requires owner or design input.

For interaction evidence only, two qualifiers are used:

- **Apparent** — implied by a visible affordance but behavior is not shown.
- **Not shown** — no state or behavior evidence.

---

## 2. Catalog Summary

| Component | Category | Reference | Walfolio use | Interaction evidence |
| --- | --- | --- | --- | --- |
| Header / navigation | Navigation | Verified | **Adapt** | Links; dropdown/cart not verified |
| Logo / wordmark | Identity | Verified | **Adapt** | Link |
| Hero composition | Section composition | Verified | **Adapt** | CTAs/links |
| Media/content split | Section composition | Verified | **Keep / adapt** | Static |
| Split section header | Content | Verified | **Keep** | Static |
| Centered section header | Content | Verified | **Keep** | Static |
| Button set | Action | Verified | **Keep / adapt** | States not shown |
| Inline link with arrow | Navigation | Verified | **Keep** | Link |
| Icon card (service card) | Content card | Verified | **Adapt** → capability card | Static |
| Stat card | Content card | Verified | **Not used by default** | Static |
| Experience card | Content card | Verified | **Keep / adapt** | Static |
| Project card | Work card | Verified | **Adapt** → Wal/work card | Link |
| Testimonial band | Social proof | Verified | **Omit** | Carousel apparent, not verified |
| FAQ accordion row | Disclosure | Verified | **Omit** | Expand/collapse apparent |
| Pale-teal CTA card | Conversion | Verified | **Omit with FAQ** | Button link |
| Contact band | Conversion | Verified | **Keep / adapt** | Buttons |
| Blog card | Content card | Verified | **Omit** | Link |
| Tag / category pill | Metadata | Verified | **Keep** | Static |
| Footer | Navigation | Verified | **Adapt** | Links, input |
| Newsletter form | Capture | Verified | **Omit** | Submission not verified |
| Decorative element set | Visual identity | Verified | **Keep selectively** | Static |
| Trust strip | Social proof | Verified (cut) | **Omit unless verified** | Static |
| Product page components | Page extension | Not in reference | **Proposed** | N/A |
| Language switcher | Navigation | Not in reference | **Proposed** | N/A |

---

## 3. Navigation and Identity

### 3.1 Header / Navigation

**Purpose**: orient the visitor, expose the main sections, and provide a primary action.

**Verified structure**

- Full-width white bar.
- Logo/wordmark at the left.
- Inline text links in the center.
- A dropdown trigger (“Pages”), a cart link (“Cart(0)”), and a filled primary CTA at the right.
- Single horizontal row on the desktop reference.

**Design properties**: `color.white`, `color.navy-800`, `type.text-md`, `button.primary`, `layout.header-height`, `layout.container`.

**Reuse**: high. It is the global navigation shell for the homepage and product pages.

**Interaction evidence**

- Links and CTA are verified as standard navigation affordances.
- Dropdown and cart behavior are **not shown**.
- Hover, focus-visible, and current-page states are **not shown**.

**Walfolio use — Adapt**

- Replace commercial items with anchor navigation: About, Skills, Experience, Wal, Contact.
- Remove Pages, Cart, and Shop.
- Keep a Contact CTA in the primary-button slot.
- Add a language switcher if Spanish is implemented (Proposed; see OI-10).
- Add a mobile menu trigger and accessible disclosure behavior (Proposed).

### 3.2 Logo / Wordmark

**Purpose**: brand identity and a link to the top of the page.

**Verified structure**

- A small geometric mark followed by a wordmark.
- White-background variant in the header.
- Light/white wordmark variant in the footer.

**Design properties**: uses the brand color(s) and `type.h4`/wordmark styling; exact mark construction is not extractable.

**Reuse**: high.

**Walfolio use — Adapt**

- Replace with the Walfolio/Waldir wordmark.
- Keep a header variant and a footer variant.
- Favicon and mark assets are **Open** (OI-13).

### 3.3 Hero Composition

**Purpose**: establish identity and a primary action immediately.

**Verified structure**

- Two-column split on a light surface.
- Left: eyebrow, H1, short body copy, and a two-button action pair.
- Right: portrait with a painterly brush stroke and layered geometric shapes.
- The portrait is bottom-cropped by the section edge.

**Design properties**: `layout.hero-text-split`, `type.h1`, `type.text-lg`, `color.surface-subtle`, `button.primary`, `button.secondary`, decorative assets.

**Reuse**: structurally reusable as a page-opening pattern; the product pages use a simpler Proposed variant, not a copy of this hero.

**Interaction**: the two CTAs are standard actionable affordances; states are not shown.

**Walfolio use — Adapt**

- Replace the eyebrow, headline, body copy, CTAs, and portrait with verified content (OI-03).
- Preserve the split composition, brush, and decorative shapes.
- Portrait and brush assets are **Open** (OI-13).

---

## 4. Section Headers

### 4.1 Split Section Header

**Purpose**: introduce a section while placing supporting context beside the heading.

**Verified structure**

- Left: eyebrow, H2.
- Right: a paragraph aligned to the top of the heading block.
- Used by Services.

**Design properties**: `type.text-sm`/`type.text-md` for the eyebrow, `type.h2` for the heading, `type.text-lg`/`type.text-md` for the paragraph, `color.navy-800` and `color.navy-700`, `layout.container`.

**Reuse**: high for any section that benefits from a side explanation.

**Walfolio use — Keep**, adapted to Skills & Capabilities.

### 4.2 Centered Section Header

**Purpose**: introduce a section with a strong centered focal point.

**Verified structure**

- Eyebrow, H2, and a supporting line, all centered.
- Used by Projects, FAQs, CTA, and Blog.

**Design properties**: same type and color tokens as the split header; constrained measure.

**Reuse**: high.

**Walfolio use — Keep** for Wal Ecosystem and Contact where appropriate.

**Interaction**: static.

### 4.3 Media / Content Split

**Purpose**: pair a large image with a content column.

**Verified structure**

- Two columns with one dominant media block.
- About: media left, content right, with decorative circles overlapping the image.
- Experience: content left, media right, with decorative shapes at opposite corners.
- Content column follows the section-header hierarchy: eyebrow, H2, body, then cards or actions.

**Design properties**: `layout.container-wide` for media span, `layout.section-padding-y`, `radius.media`, `type.h2`, `type.text-lg`/`type.text-md`, decorative assets.

**Reuse**: high. It is the main editorial layout pattern for About and Experience.

**Interaction**: static.

**Walfolio use — Keep / adapt**

- Reuse for About Me and Professional Experience.
- Replace the reference photography and decorative compositions with approved assets (OI-13).
- On tablet/mobile, stack the media and content; the order is proposed per section.

---

## 5. Actions

### 5.1 Button Set

**Purpose**: primary and secondary actions across the page.

**Verified variants**

- Filled teal primary.
- Outlined teal secondary.
- Filled blue.
- White filled and white outlined on navy.
- Black filled/outlined UI demo buttons in the style guide.

**Verified structure**

- Rectangular label with generous horizontal padding.
- Rounded corners.
- No visible icon in most homepage buttons; the link arrows are separate.

**Design properties**: `button.primary`, `button.secondary`, `button.blue`, `button.inverted-primary`, `button.inverted-secondary`, `radius.button`, `type.text-md`. The black style-guide demos map to `button.ui-dark`/`button.ui-outline` and are reference-only.

**Reuse**: high.

**Interaction evidence**

- Standard actionable affordances are visible.
- Hover, active, focus-visible, and disabled states are **not shown**.

**Walfolio use — Keep / adapt**

- Primary: Contact CTA, product links.
- Secondary: “View work” / “Explore ecosystem”.
- Inverted pair: Contact band.
- Resolve the teal-button contrast concern before finalizing (OI-15).

### 5.2 Inline Link with Arrow

**Purpose**: navigate to a project, article, or detail page.

**Verified structure**

- Text label followed by a right arrow.
- Blue in the rendered sections.

**Design properties**: `link.inline`, `color.blue-accent`, `type.text-md`/`type.text-sm`.

**Reuse**: high for product and project cards.

**Walfolio use — Keep**, with labels such as “View product” or “View project”.

---

## 6. Content Cards

### 6.1 Icon Card (Service Card → Capability Card)

**Purpose**: present a compact service or capability with an icon.

**Verified structure**

- White card with a soft shadow.
- Gradient line icon at the top-left.
- Short title.
- Short paragraph.
- Equal-height cards in a 4-column row.

**Design properties**: `color.white`, `radius.card`, `shadow.small`/`shadow.medium` (Proposed values), `space.5`/`space.6` padding, `type.h4` or `type.h6` title, `type.text-sm`/`type.text-md` body.

**Reuse**: high.

**Interaction**: static.

**Walfolio use — Adapt**

- Convert service offerings into capability cards (e.g., frontend architecture, UI engineering, design systems, accessibility — exact titles are **Open**, OI-04).
- Remove sales language.
- Icons may be recreated rather than copied (OI-13).

### 6.2 Stat Card

**Purpose**: show a quantitative proof point.

**Verified structure**

- Small white card with a large number and a short label.
- Three cards in a row inside About.

**Design properties**: `color.surface-card-alt`, `color.navy-800`, `type.h3`/`type.h4` number, `type.text-sm` label.

**Reuse**: visually reusable.

**Walfolio use — Not used by default**

- The reference numbers are invented.
- Remove the stat cards unless verified data is supplied (OI-05).
- Do not substitute decorative metrics.

### 6.3 Experience Card

**Purpose**: summarize a role or engagement.

**Verified structure**

- White card in a 2×2 grid.
- Brand/platform icon at the top.
- Role title.
- Date range.
- Short description.

**Design properties**: `color.white`, `radius.card`, `shadow.small` (Proposed), `space.5` padding, `type.h4`/`type.h6`, `type.text-sm`, `color.navy-700`.

**Reuse**: high; the strongest structural match for Professional Experience.

**Interaction**: static.

**Walfolio use — Keep / adapt**

- Replace all roles, companies, dates, and descriptions with verified content (OI-06).
- Brand icons must correspond to real organizations or be removed.
- Decide detailed vs. summarized history (OD-08).

### 6.4 Project Card → Wal / Work Card

**Purpose**: present a project or product with a visual, summary, metadata, and detail link.

**Verified structure**

- Large landscape thumbnail.
- Title.
- Short description.
- A row of small tag pills.
- “View project →” link.
- 2×2 grid; light border and soft shadow.

**Design properties**: `radius.card`, `radius.media`, `border.hairline`, `color.white`, `type.h4`/`type.h6`, `type.text-sm`, tag component, `link.inline`.

**Reuse**: high and structurally important for Walfolio.

**Interaction**: the detail link is verified as an affordance; destination behavior is not shown.

**Walfolio use — Adapt**

- Use one card per Wal product (Walday, Walplay).
- Replace tags with honest status/category labels.
- Link to the corresponding product detail page.
- Keep the grid scalable for future products without redesign.
- If non-Wal projects are supplied, the same card can present them (OI-08).

### 6.5 Blog Card

**Purpose**: tease an article.

**Verified structure**

- Image on the left; content on the right.
- Category pill and read-time label.
- Title, excerpt, and “Read more →” link.
- 2×2 grid.

**Design properties**: `color.white`, `radius.card`, `border.hairline`, `type.h4`, `type.text-sm`, tag component, `link.inline`.

**Reuse**: visually reusable, but the content type is out of scope.

**Walfolio use — Omit**

- Blog/articles are outside the confirmed product scope.
- Do not repurpose this pattern for “Life Outside Code” unless that conditional section is approved (OI-12).

---

## 7. Social Proof and Disclosure

### 7.1 Testimonial Band

**Purpose**: display a customer quote with attribution and navigation controls.

**Verified structure**

- Full-bleed blue band with diagonal edges.
- Five-star row.
- Centered quote.
- Avatar, name, role, and company logo.
- Circular previous/next buttons and five dots.

**Design properties**: `color.blue-accent`, white text, `type.text-xl`/`type.text-lg`, `radius.circle`.

**Interaction evidence**

- Arrows and dots are **apparent** carousel controls.
- Autoplay, swipe, transition, and pause behavior are **not shown**.

**Walfolio use — Omit**

- No real testimonials exist, and inventing them violates the honesty principle.
- Do not introduce a personal quote as a replacement at this stage (owner decision D5).
- If testimonials are ever supplied, the visual band can be reconsidered without changing the design system.

### 7.2 FAQ Accordion Row

**Purpose**: progressively disclose answers to common questions.

**Verified structure**

- Full-width row with a question and a plus icon.
- Thin dark border.
- Five stacked rows.
- Pale-teal CTA card below.

**Design properties**: `border.dark-row` (reference only), `radius.card`, `type.text-md`, `color.navy-800`.

**Interaction evidence**

- Plus icons make expand/collapse **apparent**.
- No open state, animation, or keyboard behavior is shown.

**Walfolio use — Omit**

- No FAQ content exists.
- Do not introduce an FAQ section solely to fill the layout.
- The pale-teal CTA card is omitted with this section; the Contact CTA handles conversion instead.

---

## 8. Conversion Components

### 8.1 Contact Band (from Pre-Footer CTA)

**Purpose**: final call to action before the footer.

**Verified structure**

- Full-bleed navy band with an angled top edge.
- Decorative line art in the corners.
- Centered heading and supporting line.
- Two buttons: white filled and white outlined.

**Design properties**: `color.navy-800`, white text, `type.h2`, `button.inverted-primary`, `button.inverted-secondary`.

**Reuse**: high.

**Interaction**: buttons are standard actionable affordances; states are not shown.

**Walfolio use — Keep / adapt**

- Replace marketing copy with a personal contact prompt.
- Primary action: email or a contact anchor.
- Secondary action: professional profile or “View experience”.
- Actual links are **Open** (OI-09).
- No contact form is assumed (OD-02).

### 8.2 Footer

**Purpose**: close the page with navigation, contact/social links, and legal information.

**Verified structure**

- Navy surface.
- Brand/wordmark and newsletter block at the left.
- Four link columns: Page, Shop, Utility Pages, Follow us.
- Social icons with labels.
- Bottom legal bar with a hairline divider.

**Design properties**: `color.navy-800`, white/light text, `type.text-sm`, `link.footer`, `link.legal`, `border.hairline`.

**Reuse**: high as a shell; content must change.

**Walfolio use — Adapt**

- Brand + one-line description.
- Replace columns with:
  - **Explore**: Home, About, Skills, Experience, Wal.
  - **Connect**: Email, LinkedIn, GitHub, other approved profiles.
- Keep a compact legal row if needed.
- Remove newsletter, Shop, and Utility Pages.
- Social/profile links are **Open** (OI-09).

### 8.3 Newsletter Form

**Purpose**: capture email subscriptions.

**Verified structure**

- Labeled email input with an outlined field.
- Subscribe button.
- Consent text.

**Design properties**: outlined input, `radius.button`, `type.text-md`.

**Interaction**: submission behavior is **not shown**.

**Walfolio use — Omit**

- No newsletter or email marketing is in scope.
- Do not imply a subscription capability on a personal portfolio.

---

## 9. Metadata Components

### 9.1 Tag / Category Pill

**Purpose**: add compact metadata to cards.

**Verified structure**

- Small rounded rectangle with short text.
- Light gray surface.

**Design properties**: `color.surface-tag`, `radius.pill`, `type.text-xs`/`type.text-sm`, `color.navy-800`.

**Reuse**: high.

**Walfolio use — Keep**

- Project/category tags.
- Product status badges, using honest status wording (OI-07).
- Do not use status pills to imply availability that does not exist.

---

## 10. Decorative and Asset-Driven Components

### 10.1 Decorative Element Set

**Verified**

- Painterly brush stroke behind the hero portrait.
- Filled circle, outlined square, ring, and rounded blob.
- Hand-drawn line art in the Contact band.
- Diagonal section transitions.

**Reuse**: high as identity elements, but they must not interfere with content or accessibility.

**Walfolio use — Keep selectively**

- Preserve the brush, circles, and diagonal transitions as identity.
- Reduce or reposition decorations on tablet/mobile.
- Recreate geometric shapes as SVG where practical.
- Mark purely decorative elements as non-semantic in implementation.
- Asset availability is **Open** (OI-13).

### 10.2 Trust Strip

**Purpose**: display claimed client/company relationships.

**Verified structure**

- Dark strip with a short label and five monochrome logos.

**Walfolio use — Omit unless verified**

- Omit by default.
- It may only be reinstated with verified technology, tool, or collaboration information (OI-17).
- Do not use unverified company logos or imply relationships.

---

## 11. Proposed Walfolio Page-Extension Components

These components do not exist in the Airfolio references. They are **Proposed** extensions of the same design system for the required Walday and Walplay detail pages.

### 11.1 Product Hero

**Purpose**: introduce a product with an honest status.

**Structure**

- Product name as H1.
- Status badge (e.g., “In development” — exact wording Open, OI-07).
- One-sentence description.
- Optional product visual.
- Optional back link to the Wal Ecosystem section.

**Tokens**: `type.h1`, `type.text-lg`, `color.surface-subtle` or `color.white`; the tag component for status.

**Status**: Proposed — no reference design exists (OI-16).

### 11.2 Product Status Badge

**Purpose**: make maturity explicit.

**Structure**

- Tag-style label with short status text.
- Reuses the tag/category pill component.

**Status**: Proposed; content wording Open (OD-04 / OI-07).

### 11.3 Product Content Section

**Purpose**: describe what the product is, its current scope, and honest limitations.

**Structure**

- Section header.
- Prose and/or card grid using existing components.
- Optional technology tags.

**Status**: Proposed. Content must reflect actual maturity and must not imply released functionality.

### 11.4 Product Contact CTA

**Purpose**: provide a path to ask about the product or the work.

**Structure**

- Reuse the Contact band or a compact panel using existing section/card patterns.
- Link to email or the contact section.

**Status**: Proposed.

### 11.5 Language Switcher

**Purpose**: switch between English and Spanish.

**Structure**

- A compact control in the header, visually consistent with the nav.
- Placement and behavior depend on OD-01.

**Status**: Proposed; not present in the reference. Requires accessible disclosure/link behavior and layout testing.

---

## 12. Interaction Inventory

| Interaction | Evidence | Walfolio status |
| --- | --- | --- |
| Nav link navigation | Verified affordance | Keep, with accessible focus states |
| Dropdown menu | Apparent; no open state shown | Removed with commercial nav |
| Cart | Label present; behavior unknown | Out of scope |
| Button activation | Verified affordance | Keep; states to be designed |
| Inline detail link | Verified affordance | Keep |
| Carousel arrows/dots | Apparent | Omitted with Testimonials |
| FAQ expand/collapse | Apparent | Omitted |
| Newsletter submission | Not shown | Out of scope |
| Mobile menu | Not in reference | Proposed |
| Language switcher | Not in reference | Proposed if Spanish ships |

**Rule**: do not describe any apparent interaction as verified behavior.

---

## 13. Component Asset Dependencies

| Component | Asset dependency | Status |
| --- | --- | --- |
| Header/logo | Walfolio mark/wordmark, favicon | Open (OI-13) |
| Hero | Portrait cutout, brush stroke | Open (OI-13) |
| About | Personal/professional photo | Open (OI-13) |
| Experience | Supporting photo, real organization icons | Open (OI-13, OI-06) |
| Wal cards | Walday/Walplay visuals | Open (OI-13) |
| Capability cards | Icon set or custom icons | Open (OI-13) |
| Contact band | Decorative line art | Open (OI-13) |
| Footer | Social icons | Open (OI-13) |
| Product pages | Product visuals, status content | Open (OI-16, OI-07) |
| Testimonials/FAQ/Blog | Not required | Omitted |

---

## 14. Cross-References

- Token definitions: [`design-system.md`](./design-system.md)
- Reference structure and limitations: [`design-reference.md`](./design-reference.md)
- Walfolio mapping, responsive behavior, and Open Items Register: [`implementation-decisions.md`](./implementation-decisions.md)
- Product requirements and OD IDs: [`../product-overview.md`](../product-overview.md)
