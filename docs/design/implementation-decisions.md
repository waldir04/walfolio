# Implementation Decisions — Walfolio Adaptation

**Document type**: Design and implementation decisions
**Status**: Proposed
**Last updated**: 2026-11-26
**Owner**: Waldir
**Product source**: [`../product-overview.md`](../product-overview.md)
**Reference analysis**: [`design-reference.md`](./design-reference.md)
**Design tokens**: [`design-system.md`](./design-system.md) (source of truth)
**Component catalog**: [`component-inventory.md`](./component-inventory.md)

---

## 1. Purpose and Scope

Status vocabulary follows [`design-reference.md`](./design-reference.md) §2: **Verified / Proposed / Assumption / Open**. This document uses **Proposed** for design decisions and **Open** for unresolved content, assets, or approvals.

This document defines how the Airfolio reference is adapted to Walfolio. It records:

- The owner decisions applied on 2026-11-26.
- The proposed section order and section mapping.
- Content and asset requirements.
- Proposed tablet and mobile behavior.
- Proposed Walday and Walplay detail-page layouts.
- Accessibility, technical, and validation considerations.
- The Open Items Register.

It does **not** define token values; those live only in [`design-system.md`](./design-system.md). It does not implement frontend code.

---

## 2. Owner Decisions Applied

**Proposed — owner-approved on 2026-11-26**

| # | Decision |
| --- | --- |
| D1 | Accept the proposed section order provisionally, following Airfolio's visual sequence. Final validation remains pending content. |
| D2 | Omit the trust strip unless it can be populated with verified information. |
| D3 | Do not use invented statistics or decorative metrics. Remove the About stat cards if no meaningful verified data is available. |
| D4 | Omit Testimonials and FAQs from the initial Walfolio scope. |
| D5 | Do not introduce a personal quote as a replacement for Testimonials at this stage. |
| D6 | Keep the Contact CTA, adapted to Walfolio's purpose. |
| D7 | Keep Blog, newsletter, Shop, Cart, and other commercial template elements out of scope. |
| D8 | Preserve Walday and Walplay as individual product detail pages. Document their layouts as proposed extensions of the Airfolio design system because no reference designs exist. |
| D9 | Accept the proposed tablet and mobile adaptations as initial implementation proposals, not verified design specifications. |
| D10 | Document the teal button contrast issue as an accessibility concern. Do not silently change the reference color or declare an accessibility exception as approved. |

---

## 3. Final Proposed Section Order

**Proposed** — follows the Airfolio visual sequence, with omitted sections removed. Final validation is pending content (OI-02 / OD-05).

| # | Section | Status | Source pattern | Purpose |
| --- | --- | --- | --- | --- |
| 1 | Header | Proposed | Airfolio header | Orientation and primary Contact action |
| 2 | Hero | Proposed | Airfolio hero | Identity, value proposition, portrait, CTAs |
| 3 | Skills & Capabilities | Proposed | Airfolio Services | Technical breadth in four capability cards |
| 4 | About Me | Proposed | Airfolio About | Background, approach, photograph |
| 5 | Professional Experience | Proposed | Airfolio Experience | Roles, dates, contributions |
| 6 | Wal Ecosystem | Proposed | Airfolio Projects | Walday/Walplay cards with status and detail links |
| 7 | Contact | Proposed | Airfolio pre-footer CTA | Email/profile actions |
| 8 | Footer | Proposed | Airfolio footer | Navigation, contact/social links, legal |

**Removed from the reference sequence**

- Trust strip (unless verified; OI-17).
- Testimonials (owner decision D4; no replacement quote per D5).
- FAQs (owner decision D4).
- Blog / Inspiration (owner decision D7).
- Newsletter, Shop, Cart, Utility Pages (owner decision D7).

**Design consequence**

- The page retains the reference's band rhythm across white, light, and navy surfaces, with diagonal transitions at the adapted boundaries.
- Because Testimonials/FAQ/Blog are removed, the blue accent band and the pale-teal card are not part of the initial page. The Contact band becomes the main dark conversion moment.
- The reference's alternating rhythm and diagonal transitions remain the primary fidelity anchor.

**Open**

- Content validation may require reordering or merging sections (OI-02; OD-05).
- If Video Introductions or Life Outside Code are approved later, they must use an explicitly Proposed extension pattern, not an invented reference layout (OI-11, OI-12).

### 3.1 Alignment with the Product Overview

**Verified against** [`../product-overview.md`](../product-overview.md). This table records coverage, not approval of missing content.

| Product Overview item | Covered by | Status / note |
| --- | --- | --- |
| E1 — Responsive one-page portfolio | §6 | Proposed tablet/mobile; desktop verified |
| E2 — Core sections: Hero, Experience, About, Skills, Wal, Contact | §3, §4, §5 | All present in the Proposed order |
| E3 — Walday and Walplay detail pages | §7 | Proposed extension; no reference design |
| E4 — Working contact path | §5.7, §9.7 | Link-based by default; links Open (OI-09) |
| E5 — Basic SEO | §9.6 | Semantic structure, metadata, indexable product pages |
| E6 — Accessibility baseline | §8 | Includes the unresolved teal contrast issue (OI-15) |
| E7 — Honest presentation | §5, §7.2, §11 | No invented claims, metrics, or availability |
| E8 — English/Spanish support | §9.5 | Depth and switcher Open (OD-01 / OI-10) |
| C1 — Video introductions | OI-11 | Deferred until videos and subtitles exist (OD-03, OD-10) |
| C2 — Life Outside Code | OI-12 | Deferred until approved content exists (OD-07) |
| C3 — Additional Wal products | §5.6 | Grid accepts future entries without redesign |
| Out-of-scope list | §11 | Blog, newsletter, Shop, Cart, commercial elements excluded |

**Deviations from the provisional Product Overview order**

- The Product Overview's provisional order places Experience before About and Skills. The Proposed order follows Airfolio's visual sequence (Skills → About → Experience). This is permitted by OD-05 and must be validated with content (OI-02).
- The Product Overview lists Video Introductions and Life Outside Code as conditional/proposed. Both remain deferred and are not given invented layouts.

---

## 4. Section Mapping

**Proposed**

| Airfolio section | Walfolio section | Action | What changes | Dependencies |
| --- | --- | --- | --- | --- |
| Header / navigation | Header | **Adapt** | Remove Pages dropdown, Cart, Shop; add anchor nav; keep Contact CTA; add language switcher if approved | OI-09, OI-10 |
| Hero | Hero | **Reuse + adapt** | Replace heading, eyebrow, body, CTAs, portrait; keep split layout, brush, shapes | OI-03, OI-13 |
| Trust strip | — | **Omit unless verified** | No unverified company logos or claims | OI-17 |
| Services | Skills & Capabilities | **Adapt** | Reframe from services to capabilities; four cards; remove sales language | OI-04, OI-13 |
| About | About Me | **Reuse + adapt** | Replace copy and photo; remove stat cards unless verified data exists | OI-05, OI-13 |
| Experience | Professional Experience | **Reuse + adapt** | Replace roles, dates, organizations, descriptions; replace image | OI-06, OI-13 |
| Projects | Wal Ecosystem | **Adapt + combine** | Use project cards for Walday/Walplay; add honest status tags; link to detail pages; scalable for future products | OI-07, OI-08, OI-13 |
| Testimonials | — | **Omit** | No real testimonials; no substitute personal quote | D4, D5 |
| FAQs | — | **Omit** | No FAQ content; no pale-teal CTA card | D4 |
| Pre-footer CTA | Contact | **Reuse + adapt** | Personal contact prompt; email/profile actions; keep navy band and inverted buttons | OI-09 |
| Blog / Inspiration | — | **Omit** | Out of scope | D7 |
| Footer | Footer | **Adapt** | Brand + short line; Explore/Connect columns; social links; remove newsletter, Shop, Utility Pages | OI-09, OI-13 |
| Product pages | Walday / Walplay detail pages | **Proposed extension** | No reference design; reuse header/footer, section headers, cards, CTA | OI-07, OI-13, OI-16 |
| Video Introductions | — | **Defer / omit** | No reference layout; only if videos and subtitles exist later | OI-11, OD-03, OD-10 |
| Life Outside Code | — | **Defer / omit** | Conditional personal section; no reference layout | OI-12, OD-07 |

---

## 5. Content Requirements per Section

**Proposed / Open** — content is owner-supplied. Nothing in this table authorizes invented claims.

### 5.1 Header

- Short navigation labels: About, Skills, Experience, Wal, Contact.
- Contact CTA label and destination.
- Language switcher if Spanish is in scope (OI-10).
- Mobile menu behavior.

### 5.2 Hero

- Eyebrow (e.g., role statement).
- H1 value proposition in Waldir's first-person voice. Walfolio is the presentation layer; it must not read as the Wal ecosystem's brand site.
- Keep the Waldir, Wal, and Walfolio names distinct in copy and navigation.
- One short supporting paragraph.
- Primary CTA (Contact) and secondary CTA (View work / Explore ecosystem).
- Portrait asset with transparent background or an approved crop.
- No invented client names, metrics, or availability claims.

### 5.3 Skills & Capabilities

- Four capability groups, each with a title, one short description, and an icon.
- The groups must reflect actual skills, not a service menu.
- Exact grouping is **Open** (OI-04).
- No proficiency percentages or invented ratings.

### 5.4 About Me

- First-person professional background.
- Development philosophy and approach.
- Optional approved photograph.
- Optional verified facts (e.g., years of experience) only if the owner supplies them.
- Stat cards are removed by default; no decorative metrics (D3, OI-05).

### 5.5 Professional Experience

- Roles, organizations, date ranges, responsibilities, and technologies.
- Decide detailed history vs. summarized senior narrative (OD-08 / OI-06).
- Organization icons/brand marks only for real organizations.
- No invented projects, titles, or achievements.

### 5.6 Wal Ecosystem

- One card per product: Walday and Walplay.
- Present the products as work in progress, not as commercial offerings. No pricing, sales funnel, or marketing CTA.
- Honest status wording and description (OD-04 / OI-07).
- Link to each product detail page.
- The grid must accept future products without a redesign.
- Optional visuals must not imply finished functionality.
- If non-Wal selected projects are included, they use the same card pattern (OI-08).

### 5.7 Contact

- A short personal invitation.
- At least one working contact route: email, LinkedIn, GitHub, or another approved profile.
- No contact form by default (OD-02 / OI-09).
- No response-time promises or availability claims unless confirmed.
- The Contact band can link to a `mailto:` address or an anchor; the final mechanism is Open (OI-09).

### 5.8 Footer

- Walfolio/Waldir wordmark and a short line.
- **Explore** links mirroring the page sections.
- **Connect** links to email and approved profiles.
- Social icons with accessible labels.
- Legal/copyright line if required.
- No newsletter, Shop, Utility Pages, or marketing claims.

---

## 6. Responsive Behavior

**Desktop is Verified; tablet and mobile are Proposed** (D9). No mobile/tablet references exist.

Breakpoints are defined in [`design-system.md`](./design-system.md) as `breakpoint.mobile`, `breakpoint.tablet`, and `breakpoint.desktop`.

### 6.1 Section behavior matrix

| Section | Desktop (reference-verified; adapted content) | Tablet (Proposed) | Mobile (Proposed) |
| --- | --- | --- | --- |
| Header | Single row: logo, navigation, Contact CTA | Logo + CTA visible; nav behind a menu trigger; language switcher in the menu | Logo + menu trigger; CTA may remain visible or move into the menu |
| Hero | Two columns: text left, portrait right | Two columns through the upper tablet range, then stack text above portrait | Single column; text first, portrait second; CTAs stack or full-width; decorations reduced |
| Skills | 4 capability cards in one row | 2×2 grid | Single column |
| About | Photo left, content right | Stack photo above content or content above photo; keep a single reading column | Single column; photo first or after the intro; no stat cards by default |
| Experience | Content left with 2×2 cards; photo right | Stack media below the cards; keep 2×2 cards where width allows | Single column; cards 1×1; media after content |
| Wal Ecosystem | 2-column project cards (two initial entries; scalable) | 2 columns through the tablet range, then 1 column | Single column; media above text |
| Contact | Centered navy band with two buttons | Centered band; buttons may wrap | Centered band; buttons stack full-width |
| Footer | Brand + Explore/Connect columns + legal | Brand + 2 link columns | Brand + stacked link groups |
| Product pages | Proposed extension layout (no reference) | Stack product hero media/content | Single column; status and summary remain above the fold |

### 6.2 Responsive principles

**Proposed**

- Preserve the section order and band rhythm; do not hide sections to make the layout fit.
- Use fluid gutters and `clamp()` type; avoid fixed card heights.
- Keep the 4→2→1 grid reflow for card sets.
- Keep tap targets at least 44 × 44 px.
- Preserve visible focus indicators; ensure decorative clipping does not cut focus rings.
- Reduce or reposition the brush and geometric shapes on small screens.
- Test Spanish copy expansion; headings may need different line breaks.
- Validate the angled dividers for horizontal overflow and safe-area behavior.

### 6.3 Responsive validation

**Open** — the proposed tablet/mobile layouts require visual review (OI-19). They are not verified designs.

---

## 7. Walday and Walplay Product Detail Pages

**Proposed extension** — no reference design exists (D8, OI-16).

### 7.1 Shared structure

Each product page should reuse the global header and footer and the design system's typography, buttons, cards, tags, and surfaces.

Walday and Walplay are treated as internal Walfolio pages, consistent with Product Overview assumption A2. No external product destination is assumed; if one exists, it remains Open (OI-07). Page routes are an implementation concern, not a design token.

Proposed page outline:

1. **Header** — same global navigation; current-section awareness if supported.
2. **Product hero**
   - Product name as the page H1.
   - Honest status badge (e.g., “In development”; exact wording Open, OI-07).
   - One-sentence description.
   - Optional product visual that does not imply finished functionality.
   - Optional back link to the Wal Ecosystem section.
3. **Overview** — what the product is and why it exists.
4. **Current status and scope** — explicit maturity statement; what exists and what does not, only if factual.
5. **Design/technical notes** — optional section describing the work and decisions, without exposing confidential or invented details.
6. **Technology** — optional tags, only if accurate.
7. **Contact CTA** — a compact reuse of the Contact band or a link back to the homepage contact section.
8. **Footer** — same global footer.

### 7.2 Content rules

- No availability dates, roadmaps with committed dates, user counts, traction, or release claims.
- No screenshots or demos that imply finished functionality.
- Status language must appear on both the ecosystem card and the product page.
- Each page must be independently indexable with a meaningful title and description.
- The layout must accept future products as content changes, not redesigns.

### 7.3 Visual rules

- Reuse `type.h1` for the product name, `type.h2` for sections, and existing section-header patterns.
- Use the tag component for status and technology labels.
- Use the same light/white/dark band rhythm; avoid inventing a new product-page visual language.
- Keep the page shallow and content-led, consistent with the Product Overview's assumption that product pages are content-only pages.

### 7.4 Open items

- Product-page layout approval (OI-16).
- Product status wording and descriptions (OI-07 / OD-04).
- Product visuals and screenshots (OI-13).
- Whether any external product destination exists (OI-07).
- Language coverage of product pages (OI-10).

---

## 8. Accessibility

### 8.1 Baseline requirements

**Verified requirement source**: Product Overview E6 and §12.

- Keyboard-operable navigation and controls.
- Semantic landmarks and a correct heading hierarchy.
- One H1 per page.
- Alternative text for meaningful imagery; decorative elements ignored by assistive technology.
- Visible focus states.
- Sufficient color contrast.
- Subtitles on any published video.
- No reliance on color alone for status.

### 8.2 Teal button contrast

**Open — no resolution approved** (D10, OI-15, OD-06)

- The reference's primary teal button uses white text at approximately 4.1:1 contrast, as recorded in [`design-system.md`](./design-system.md) §11.
- WCAG AA requires 4.5:1 for normal-size text.
- No color change has been made, and no accessibility exception has been approved.
- The decision must be made before implementation:
  - Preserve the exact reference color and address contrast through larger/bolder button text, if it qualifies as large text.
  - Darken the teal for text-bearing buttons while preserving the overall identity.
  - Approve a documented exception, if fidelity is chosen over AA for this element.
- The formal conformance target remains undecided (OD-06 / OI-14).

### 8.3 Interaction accessibility

**Proposed**

- Mobile menu: disclosure button with `aria-expanded`, focus management, Escape to close.
- Language switcher: accessible label, current-language state, keyboard operation.
- Contact links: descriptive link text; no ambiguous “click here”.
- Any future carousel/accordion must be keyboard operable and respect `prefers-reduced-motion`.
- Focus-visible styles must be designed; the reference does not show them.

---

## 9. Technical Implementation Considerations

This section records considerations, not a technology choice.

### 9.1 Tokens and components

- Implement the tokens in [`design-system.md`](./design-system.md) as the single source for color, type, spacing, radii, borders, and shadows.
- Build shared primitives: container, section header, button, tag, card, link, angled divider, footer.
- Reuse the same primitives on the product pages.
- Avoid one-off visual values that bypass the token system.

### 9.2 Typography

- Load Inter with `font-display: swap`.
- Self-hosting is preferred for performance and privacy; final hosting is an implementation decision.
- Include Latin and Latin Extended subsets for Spanish.
- Preload the primary font files and choose fallbacks that minimize layout shift.
- Validate the reference's heading line heights and weights visually.

### 9.3 Images and assets

- Use explicit width/height or aspect ratios to prevent layout shift.
- Prefer AVIF/WebP with responsive `srcset`/`sizes`.
- Prioritize the hero image; lazy-load below-the-fold media.
- Keep the hero portrait cutout and brush visually faithful without shipping oversized files.
- Recreate geometric decorations as SVG where practical.
- Do not publish product screenshots that imply unavailable functionality.

### 9.4 Layout and responsive engineering

- Use CSS Grid for the 4-column, 2-column, and split layouts.
- Use `clamp()` for fluid type and spacing where appropriate.
- Implement diagonal transitions with `clip-path`, SVG, or pseudo-elements; verify no horizontal overflow and no clipped focus rings.
- Avoid fixed heights for cards and content blocks; Spanish copy will expand.
- Test at mobile, tablet, and desktop widths, plus 1440 px against the reference.

### 9.5 Internationalization

- English is the default; Spanish support is confirmed, depth is Open (OD-01 / OI-10).
- The reference has no language switcher; its placement is a Proposed header addition.
- Product pages need a language strategy consistent with the homepage.
- Avoid text baked into images where translation is required.

### 9.6 SEO

- Meaningful page titles and descriptions.
- Open Graph and share metadata.
- Semantic document structure.
- One indexable page per published product.
- Canonical URLs and language alternates when Spanish is implemented.
- No keyword stuffing or invented claims.

### 9.7 Contact

- Link-based contact is the default (OD-02 / OI-09).
- A hosted form is a separate decision and must not be implied by the Contact band.
- Do not publish an email address until the owner approves it.

### 9.8 Analytics

- None by default (OD-09 / OI-18).
- Do not add tracking during implementation without approval.

### 9.9 Performance

- The page is mostly static; optimize fonts, hero media, and thumbnails.
- Avoid heavy carousel/accordion libraries when the interactions are omitted.
- Keep decorative assets lightweight.
- Measure against ordinary connections and devices, consistent with Product Overview §12.

### 9.10 Visual validation

- Compare the rendered homepage to the 1440 px references.
- Validate tablet/mobile against the Proposed adaptations, not against non-existent references.
- Treat the site's own implementation quality as part of the product evidence (Product Overview §12, principle 10).
- Document unavoidable deviations caused by missing assets or accessibility fixes.
- Do not silently change the reference palette to work around contrast; record the decision.

---

## 10. Asset Requirements

**Open** — all assets below are owner-supplied or must be approved. None are present in the repository.

| Asset | Needed for | Status | Notes |
| --- | --- | --- | --- |
| Walfolio/Waldir wordmark | Header, footer | Open | OI-13 |
| Favicon | Browser identity | Open | OI-13 |
| Hero portrait cutout | Hero | Open | Transparent or approved crop |
| Hero brush stroke | Hero | Open | Transparent raster or SVG recreation |
| About photograph | About Me | Open | Personal/work imagery |
| Experience photograph | Professional Experience | Open | Personal/work imagery |
| Walday visual(s) | Wal card, product page | Open | Must not imply finished functionality |
| Walplay visual(s) | Wal card, product page | Open | Must not imply finished functionality |
| Additional project visuals | Selected work (if approved) | Open | OI-08 |
| Capability icons | Skills cards | Open | Recreate or use an approved set |
| Organization icons | Experience cards | Open | Only for real organizations |
| Social icons | Footer/contact | Open | Use an approved icon set |
| Decorative shapes/line art | Hero, Contact | Open | Recreate as SVG |
| Inter font files | Typography | Open | Hosting/licensing decision (OI-13) |
| Testimonial/FAQ/blog/company assets | Omitted sections | Not required | Do not source unless scope changes |

**Rule**: no placeholder marketing copy, lorem ipsum, or invented metrics may be used as final content. Temporary development placeholders must be clearly marked and removed before release.

---

## 11. Out of Scope for the Initial Walfolio Release

**Proposed** — consistent with the owner decisions and the Product Overview.

- Trust strip / company logos unless verified (D2).
- Testimonials and personal quote replacement (D4, D5).
- FAQ section and pale-teal FAQ CTA card (D4).
- Blog / Inspiration section (D7).
- Newsletter capture (D7).
- Shop, Cart, Utility Pages, and other commerce/template pages (D7).
- Invented statistics, client logos, testimonials, or product claims.
- Video Introductions unless the videos and subtitles exist (deferred; OI-11 / OD-10, with hosting under OD-03).
- Life Outside Code unless approved with personal content (deferred; OI-12 / OD-07).
- Analytics/tracking by default (OD-09 / OI-18).
- A contact form by default (OD-02 / OI-09).
- New visual identities or Wal product colors as replacements for the Airfolio palette.

---

## 12. Open Items Register

**Open** — unresolved content, assets, and design decisions. None of these blocks creation of the design documentation.

| ID | Status | Item | Related | Impact | Default / next step |
| --- | --- | --- | --- | --- | --- |
| OI-01 | Open | Figma source/token availability | Reference precision | Exact spacing, radii, shadows, weights, gradients remain Approx. | Proceed with documented approximations; refine if Figma is supplied |
| OI-02 | Open | Final section order and content validation | OD-05 | Order may change after content review | Use the Proposed order in §3 provisionally |
| OI-03 | Open | Hero copy, eyebrow, CTA labels, portrait | Content | Hero cannot be finalized | Owner supplies copy and portrait |
| OI-04 | Open | Skills capability groups | Content | Skills section cannot be populated | Owner supplies four groups |
| OI-05 | Open | About bio, photo, verified facts | Content | About cannot be finalized | Remove stat cards by default |
| OI-06 | Open | Experience content and depth | OD-08 | Experience cannot be populated | Owner supplies roles or approved summary |
| OI-07 | Open | Walday/Walplay status, descriptions, destinations | OD-04 | Product cards/pages cannot be finalized | Use only honest “in development” wording if approved |
| OI-08 | Open | Selected non-Wal projects | Content | Wal Ecosystem may show only two cards | Omit additional projects until supplied |
| OI-09 | Open | Contact links and mechanism; footer Connect links | OD-02 | Contact band/footer cannot be finalized | Use link-based contact once links are supplied |
| OI-10 | Open | Spanish depth and language switcher | OD-01 | Content model and header layout are affected | English-first until decided |
| OI-11 | Open | Video Introductions | OD-03, OD-10 | Conditional section; no reference layout | Defer/omit until videos and subtitles exist |
| OI-12 | Open | Life Outside Code | OD-07 | Conditional personal section | Defer/omit until approved content exists |
| OI-13 | Open | Asset availability and rights | Assets | Hero, About, Experience, Wal, logo, icons, and font files cannot be final | Owner supplies assets; use only clearly marked development placeholders |
| OI-14 | Open | Accessibility conformance target | OD-06 | Acceptance criteria depend on the target | Treat E6 baseline as the working expectation |
| OI-15 | Open | Teal button contrast resolution | OD-06 | Primary button styling cannot be finalized | Documented concern only; no change or exception approved |
| OI-16 | Open | Product detail page design approval | Extension | Walday/Walplay pages have no reference | Use the Proposed extension in §7 |
| OI-17 | Open | Trust strip verified content | Content | Strip remains omitted unless verified | Omit by default |
| OI-18 | Open | Analytics/measurement | OD-09 | Tracking scope | None by default |
| OI-19 | Open | Responsive validation | D9 | Tablet/mobile are unverified proposals | Validate during visual review |

---

## 13. Validation Checklist

**Documentation**

- [x] Four documents exist under `docs/design/`.
- [x] Design tokens are defined only in `design-system.md`.
- [x] The same Verified / Proposed / Assumption / Open vocabulary is used across documents.
- [x] Owner decisions D1–D10 are recorded in §2.
- [x] The proposed section order is marked Proposed and preserves the Airfolio sequence.
- [x] Omitted sections and commercial elements are documented.
- [x] Walday and Walplay product pages are documented as Proposed extensions.
- [x] Tablet/mobile behavior is marked Proposed, not extracted.
- [x] The teal contrast issue is documented without approving a color change or exception.
- [x] Content and asset gaps are listed in the Open Items Register.
- [x] Product Overview decision IDs are cross-referenced.
- [x] No application code, dependencies, configuration, or commits were created or modified.

**Visual validation — future**

- [ ] Compare the rendered desktop homepage to the 1440 px references.
- [ ] Validate the Proposed tablet/mobile layouts.
- [ ] Calibrate Approx. tokens if a Figma source becomes available.
- [ ] Resolve OI-15 before finalizing the primary button.
- [ ] Confirm no placeholder content remains before release.

---

## 14. Cross-References

- Product definition and OD IDs: [`../product-overview.md`](../product-overview.md)
- Reference structure and limitations: [`design-reference.md`](./design-reference.md)
- Token definitions: [`design-system.md`](./design-system.md)
- Component catalog: [`component-inventory.md`](./component-inventory.md)
