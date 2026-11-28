# Contract: Design Tokens

**Feature**: `001-portfolio-foundation` | **Type**: Style/token contract

`docs/design/design-system.md` defines token names and values. `src/app/styles/tokens.css` is the
only implementation source. This contract defines what must exist and how it may be consumed.
Values quoted here bind the implementation and mirror the design-system document; on any
difference, `docs/design/design-system.md` prevails and this contract plus the token source are
corrected together.

## Location and import graph

```text
src/main.tsx
└── imports src/app/styles/global.css
    ├── @import "tailwindcss";
    ├── @import "./tokens.css";   ← @theme + semantic custom properties
    └── base / focus-visible / reduced-motion styles
```

- Exactly one global token source. No token declarations in `shared/`, components, or `index.html`.
- `tokens.css` is imported once at bootstrap; no component imports it directly.
- Tailwind utilities and semantic custom properties both resolve from this graph.

## Required categories

| Category | CSS representation | Status source |
| --- | --- | --- |
| Color | `@theme` `--color-*` for white, surface-subtle, navy-800, navy-700, text-muted, teal-primary, blue-accent, magenta-accent, surface-pale-teal, surface-tag, surface-card-alt, border-subtle, ui-black | Verified / Approx. / reference-only per design-system §2 |
| Typography | `@theme` `--font-sans` (Inter + fallback), `--font-weight-body/nav/heading` (400/500/600), `--text-h1…h6`, `--text-xl/lg/md/sm/xs` with paired line heights, plus Proposed `--text-h1-mobile` (2.5rem) and `--text-h2-mobile` (2.25rem) | Verified sizes; Approx. weights; Proposed mobile sizes |
| Spacing | `:root` `--space-1…11` (4, 8, 12, 16, 24, 32, 40, 48, 64, 80, 120 px) | Proposed |
| Layout | `:root` `--layout-container`, `--layout-container-wide`, `--layout-container-fluid: calc(100% - (2 * var(--layout-gutter)))`, `--layout-gutter` (fluid 1.25–5rem), `--layout-header-height` (88px), `--layout-section-padding-y`, `--layout-grid-gap-sm/md/lg`, `--layout-hero-text-split`, `--layout-faq-measure` | Verified/Approx. per §4 and §10; gutter derived Approx. |
| Breakpoints | `@theme` `--breakpoint-tablet` (48rem), `--breakpoint-desktop` (80rem); `:root` `--breakpoint-mobile-max` (47.9375rem) records the mobile upper bound while mobile remains the utility default | Proposed |
| Radii | `@theme` `--radius-button` (≈8px), `--radius-card` (≈12px), `--radius-media` (≈16–20px), `--radius-pill` (≈4px), `--radius-circle` (9999px) | Approx. except circle |
| Borders | Semantic custom properties for `--border-hairline`, `--border-outline-teal`, and reference-only `--border-dark-row` | Approx. / Verified / reference-only |
| Shadows | `@theme` `--shadow-xxsmall…xxxlarge` | Proposed (values Open, OI-01) |
| Surfaces | Semantic custom properties mapping section-light, section-white, dark, secondary-dark (reference-only), accent (reference-only), pale-teal (reference-only), tag | Verified / reference-only |

## Provenance notation

Every declaration block carries a comment with the design-system token name and status:

```css
/* Verified — color.teal-primary (#088D84) */
--color-teal-primary: #088d84;
```

Rules:

- `Verified` values are copied exactly.
- `Approx.` values are labelled approximate and centrally adjustable.
- `Proposed` values are labelled proposed and not described as reference measurements.
- `Open` values (border tint, shadow values, teal contrast) stay documented as open.
- A token may carry a `Verified` value and an `Open` usage restriction; both must be stated. In
  particular, `color.teal-primary` is `Verified` as a color and `Open` for white text at ≈4.1:1.
- `reference-only` tokens (for example `--border-dark-row` and the omitted surface variants) are
  declared for completeness but generate no component or implied section.

## Consumption rules

**MUST**

- Reference semantic tokens/utilities (e.g. `text-navy-800`, `var(--layout-container)`).
- Keep structural values (`0`, `100%`, `auto`, `1fr`, `minmax()`) as-is; they are not tokens.
- Center provisional values so recalibration edits only `tokens.css`.

**MUST NOT**

- Use raw hex colors, arbitrary spacing, radii, or shadows in components without a documented,
  reviewed exception.
- Present a provisional or open token as verified.
- Change a verified value without updating `design-system.md` first and obtaining approval.
- Introduce a Walday/Walplay or other product palette.
- Use `color.teal-primary` with white text for final text-bearing actions while D-006/OI-15 is open.
- Use `color.ui-black` or reference-only surfaces as general-purpose styling.

## Typography loading

`Inter` is declared in the family token with a system fallback chain. No `@font-face`, font file,
CDN, or font dependency is added (D-005). The deviation is documented in the ADR.

## Responsive values

Breakpoints are `Proposed` adaptations. Fluid gutters and type may use `clamp()` with token
bounds; tablet/mobile behavior is never described as verified. The 1440 px container behavior is a
documented approximation, not final fidelity.

## Verification

- Token review: every documented category and every documented token name present, including
  reference-only tokens, mobile type sizes, `layout.container-fluid`, and the mobile breakpoint
  boundary; zero duplicate global definitions; statuses traceable.
- `global.css` imports Tailwind then tokens, defines `:focus-visible` and `prefers-reduced-motion`,
  and contains no global `overflow-x: hidden` or fixed heights.
- Component review: zero undocumented raw visual values, including raw hex/rgb values and arbitrary
  `[...]` utilities in foundation `.tsx` files.
- Manual: no horizontal overflow at 375/768/1024/1280/1440 px; focus-visible and reduced-motion
  behavior inspected.
