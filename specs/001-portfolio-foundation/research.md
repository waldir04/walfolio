# Phase 0 Research: Portfolio Foundation

**Feature**: `001-portfolio-foundation` | **Date**: 2026-11-28

Each section records the decision, rationale, and rejected alternatives. The Node.js decision was
resolved by the owner on 2026-11-28 and is recorded in `docs/decisions/D-001-nodejs-version.md`.

## R1. Node.js version — RESOLVED (owner decision D-001)

**Decision**: Node.js 26 LTS, approved by the owner on 2026-11-28. `.nvmrc` pins the `26` major
line at scaffold. The foundation records the approval instead of selecting a version itself.

**Rationale**: Node.js 26 became Active LTS on 2026-10-28 and is supported through 2029-04-30.
Vite 8.4.0 declares `engines.node` as `^20.19.0 || >=22.12.0`, so Node.js 26 satisfies the build
tool, and `ubuntu-latest` in GitHub Actions supports the LTS line. The local machine currently has
Node.js 24, so Node.js 26 must be installed with `nvm install 26` before scaffolding.

**Criteria satisfied**:

- Active LTS line supported by `ubuntu-latest` in GitHub Actions.
- Compatible with the selected Vite major's documented engine range (Vite 8.4.0 verified).
- Tooling compatibility (`@vitejs/plugin-react`, Tailwind CSS v4, Vitest, jsdom) must be re-checked
  against Node.js 26 at scaffold time.
- Pinned in `.nvmrc` as `26` and reflected in the committed lockfile.
- Not inherited from Walplay or another project.

**Alternatives considered**:

- Node.js 24 LTS — rejected: maintenance LTS with less remaining support; useful only because it is
  currently installed locally.
- Node.js 22 LTS — rejected: extended support ends 2027-04-30 and it is not the Active LTS.
- Copy a version from another project — rejected: explicitly prohibited by FR-004.
- Scaffold without `.nvmrc` and add it later — rejected: CI fails on `package.json` without
  `.nvmrc`, and the hooks become unusable in the interim.

## R2. Application scaffold and build tool

**Decision**: A single Vite application at the repository root, ESM (`"type": "module"`), with
`index.html` as the entry document, `src/main.tsx` bootstrap, `@vitejs/plugin-react`, and the
official `@tailwindcss/vite` plugin.

**Rationale**: React, TypeScript, Vite, and Tailwind v4 are the approved stack. A root-level single
application matches the existing CI, which installs from the root lockfile and runs scripts at the
root. No meta-framework is allowed, and no framework is needed for one shell page.

**Alternatives considered**:

- Next.js/Remix/Astro — rejected: no meta-framework approved; rendering strategy is deferred.
- Monorepo with `frontend/` — rejected: FR-001 prohibits these directories.
- Manual bundler configuration — rejected: unnecessary complexity over Vite defaults.

## R3. Tailwind v4 token integration

**Decision**: `src/app/styles/tokens.css` is the single governed token source. It contains a
Tailwind v4 `@theme` block for namespaced tokens and a `:root`/`@layer base` section for semantic
custom properties. `src/app/styles/global.css` imports `tailwindcss`, then `tokens.css`, then
declares base, focus-visible, and reduced-motion styles. `main.tsx` imports `global.css` once.

**Rationale**: The spec fixes both the location (`app/styles/tokens.css`) and the expression
(`@theme` plus semantic custom properties). One import graph prevents duplicate global definitions
(FR-019, AC-007). Namespaced `@theme` tokens produce utilities; semantic custom properties cover
layout and spacing values whose scale is not a simple multiple of one base unit.

**Token mapping plan**:

| Category | Representation |
| --- | --- |
| Colors | `@theme` `--color-*` (white, surface-subtle, navy-800, navy-700, text-muted, teal-primary, blue-accent, magenta-accent, surface-pale-teal, surface-tag, surface-card-alt, border-subtle, ui-black) |
| Typography | `@theme` `--font-*` (Inter family), Approx. `--font-weight-body/nav/heading`, and `--text-*` with paired line heights for h1–h6, text-xl/lg/md/sm/xs, plus Proposed `--text-h1-mobile`/`--text-h2-mobile` |
| Spacing | `:root` `--space-1…11` semantic custom properties (4–120 px scale) |
| Layout | `:root` `--layout-container`, `--layout-container-wide`, `--layout-container-fluid` (with fluid `--layout-gutter`), `--layout-header-height`, `--layout-section-padding-y`, `--layout-grid-gap-sm/md/lg`, `--layout-hero-text-split`, `--layout-faq-measure` |
| Breakpoints | `@theme` `--breakpoint-tablet` (768px) and `--breakpoint-desktop` (1280px); `:root` `--breakpoint-mobile-max` records the mobile upper bound because mobile is the default below 768px |
| Radii | `@theme` `--radius-button/card/media/pill/circle` |
| Borders | Semantic custom properties for hairline, outline-teal, and the reference-only dark-row border |
| Shadows | `@theme` `--shadow-xxsmall…xxxlarge` |
| Surfaces | Semantic custom properties mapping section-light/white/dark/secondary-dark/accent/pale-teal/tag; reference-only surfaces retained but unused |

Every declaration block carries a provenance comment naming the design-system token and its
status. `Open` and `Approx.` values are implemented as documented but never described as verified.

**Alternatives considered**:

- A TypeScript token object — rejected: styling belongs in CSS; Tailwind v4 `@theme` is the
  approved mechanism and avoids a parallel source.
- Tokens in `shared/` — rejected: the spec assigns tokens to `app/styles/tokens.css` and `shared`
  must not hold global design tokens.
- Only Tailwind default utilities with arbitrary values — rejected: bypasses token governance.
- A JS/CSS-in-JS token system — rejected: not approved and unnecessary.

## R4. i18n readiness without an i18n library

**Decision**: `src/shared/i18n/en.ts` exports a deeply nested `en` object of descriptive keys
(e.g. `en.home.title`) and an exported `Messages` type derived from it. Components read the
resource directly; no loader, provider, or switch mechanism is added.

**Rationale**: Principle VII and FR-055 require externalized, structured, descriptive keys with
predictable fallback, while the i18n library remains deferred (DEF-15). A typed constant is the
smallest structure that satisfies all three without adding an unapproved dependency. Adding
Spanish later means adding `es.ts` and a resolution point, not rewriting components.

**Alternatives considered**:

- Hardcode the H1 — rejected: violates Principle VII.
- `react-i18next`/`react-intl` — rejected: unapproved dependency and deferred decision.
- JSON resource files + fetch — rejected: network loading is unnecessary and creates failure
  modes for one string.
- A `t()` function with string keys — rejected: loses type safety; a nested typed object gives
  compile-time key checking with less machinery.

## R5. Testing stack and zero-warning enforcement

**Decision**: Vitest with `environment: 'jsdom'`, `src/test/setup.ts` loading
`@testing-library/jest-dom/vitest`, an `afterEach` assertion that no unexpected `console.warn`/
`console.error` fired, and a process-level `unhandledrejection` handler that fails the current
test. Coverage uses `@vitest/coverage-v8` with `lines`, `statements`, `functions`, and `branches`
at 80, including `src/**`, excluding test files, the test infra directory, and `main.tsx`.

**Rationale**: Constitution Principle VIII and FR-036–FR-038. 80% is ratified; 90% for critical
modules is not, because no critical-module list exists (DEF-18). Excluding only the bootstrap entry
avoids an artificial boost and is documented. The console guard is implemented as a spy, not by
disabling console output.

**Alternatives considered**:

- Enforce a 90% threshold — rejected: unapproved and would invent critical modules.
- `silent: true` or global console stubs — rejected: prohibited by FR-038.
- Istanbul/nyc — rejected: Vitest-native v8 coverage is simpler and approved.
- Separate coverage package/config outside `vitest.config.ts` — rejected: thresholds belong in
  `vitest.config.ts` per Principle VIII.

## R6. Automated accessibility assertions with axe-core

**Decision**: A `src/test/axe.ts` helper runs `axe-core` against a rendered container and asserts
no violations, with the `color-contrast` rule disabled and the reason recorded in code and in the
test output. `HomePage.test.tsx` calls it. Manual keyboard and focus verification remains a
recorded PR step.

**Rationale**: D-007 approves `axe-core` as development-only tooling; FR-054 and AC-041 make it a
gate. jsdom has no layout engine, so contrast and geometry rules cannot produce meaningful results;
disabling that rule is honest and documented rather than a silent skip of the whole engine.

**Alternatives considered**:

- `vitest-axe`/`jest-axe` — rejected: extra wrapper over the approved package.
- Run axe in a real browser — rejected: requires an unapproved browser/E2E dependency.
- Assert on a curated rule subset instead of one disabled rule — rejected: silently narrows
  coverage; the documented single exclusion is easier to review.

## R7. Linting and formatting

**Decision**: ESLint flat config (`eslint.config.js`) with `@eslint/js` recommended,
`typescript-eslint` recommended-type-checked, `eslint-plugin-react-hooks`, and
`eslint-config-prettier`. Zero warnings tolerated. Key explicit rules: `no-explicit-any`,
`no-non-null-assertion`, `func-style: expression` (arrow functions), and unsafe-`any` rules from
the type-checked preset. Prettier is configured in `.prettierrc.json`; `.prettierignore` excludes
`node_modules`, `dist`, `coverage`, `package-lock.json`, `.specify/`, `specs/`, and
`docs/design/references/`.

**Rationale**: Approved tooling only; the existing `.lintstagedrc.json` already invokes
`eslint --max-warnings 0`, so a flat config is required for the hook to function. Scoping
`format:check` away from generated output and reference images keeps it meaningful.

**Risk and handling**: No Prettier configuration exists today, so the first `format:check` could
flag pre-existing files. Implementation runs `prettier --check` on feature-owned paths first; any
pre-existing failure is handled narrowly by adding the specific out-of-scope path to
`.prettierignore` with a recorded reason (or by a separately authorized formatting change), never by
mass-reformatting unrelated documents and never by disabling the gate.

**Alternatives considered**:

- Legacy `.eslintrc` — rejected: deprecated and unnecessary for a new app.
- `eslint-plugin-react-refresh` — rejected: no requirement; extra dependency.
- No Prettier config (defaults) — rejected: repo code style would be implicit and drift-prone.
- Type-unaware linting only — rejected: insufficient for Principle II.

## R8. TypeScript project configuration

**Decision**: A solution-style root `tsconfig.json` referencing `tsconfig.app.json` (DOM libs,
`jsx: react-jsx`, `strict`, `noUncheckedIndexedAccess`, `exactOptionalPropertyTypes`, bundler
resolution, `noEmit: true`, `@/*` path, `vite/client` types) and `tsconfig.node.json` (Vite/Vitest
config files, Node types, `noEmit: true`). `typecheck` runs `tsc -b --pretty false`; no-emit is
configured in the referenced projects because `--build` and `--noEmit` are not combined on the CLI.

**Rationale**: Splitting app and Node tooling avoids leaking Node globals into browser code while
still type-checking configuration files. Strict options exceed the minimum required by Principle
II without exotic settings.

**Alternatives considered**:

- One tsconfig including config files — rejected: mixes Node and DOM globals.
- `allowJs`/loose settings — rejected: weakens safety.
- Skipping config type-checking — rejected: leaves build scripts unverified.

## R9. Build vs. typecheck separation

**Decision**: `build` runs `vite build`; `typecheck` runs the TypeScript project build with no
emit. The two canonical scripts stay independent.

**Rationale**: Both are required canonical gates. `vite build` fails on genuine build errors;
type errors are caught by `typecheck`. Duplicating `tsc` inside `build` doubles CI time without
adding a distinct signal.

**Alternatives considered**:

- `tsc -b && vite build` — rejected as redundant with the dedicated gate.
- `vite build` with no type gate — rejected: would weaken quality.

## R10. Path alias and module boundaries

**Decision**: A single `@/*` alias maps to `src/*`, configured in `tsconfig.app.json` and in
`vite.config.ts` as `fileURLToPath(new URL("./src", import.meta.url))` (an absolute path, not the
literal `"/src"`). `vitest.config.ts` merges `vite.config.ts` with `mergeConfig` (or repeats the
same alias), because a separate Vitest config does not inherit Vite aliases. Layer order is
`app` → `pages` → `shared`. No boundary lint rule or plugin is added.

**Rationale**: FR-016 and Principle IV require an alias and review-verified boundaries; automated
enforcement is explicitly out of scope. One alias is enough for this size and keeps imports short.

**Alternatives considered**:

- Per-layer aliases (`@app`, `@pages`, `@shared`) — rejected: extra configuration with no current
  benefit.
- ESLint `import/no-restricted-paths` — rejected: prohibited by FR-016 for this foundation.
- Deep relative imports — rejected by FR-016.

## R11. Typography loading

**Decision**: `--font-sans: Inter, ui-sans-serif, system-ui, -apple-system, "Segoe UI",
Roboto, "Helvetica Neue", Arial, sans-serif`. No `@font-face`, font file, CDN, or font dependency
is added; the fallback is documented as the D-005 deviation.

**Rationale**: Inter is Verified as the family, but assets and licensing are Open (D-005, OI-13).
A metric-compatible system fallback limits layout shift and honors FR-025 while avoiding an
unapproved asset or service.

**Alternatives considered**:

- Google Fonts CDN — rejected: unapproved third-party service and privacy concern.
- Self-hosted Inter files — rejected: assets/licensing unresolved.
- System font only — rejected: drops the verified family token.

## R12. Responsive strategy and validation

**Decision**: Mobile-first CSS driven by the Proposed breakpoints (default < 768px, tablet 768px+,
desktop 1280px+), fluid gutters via `clamp()` and the layout tokens, no fixed heights. Overflow is
verified manually at 375, 768, 1024, 1280, and 1440 px and recorded in the PR.

**Rationale**: FR-056–FR-062 and A-007. No automated layout runner is approved, so the plan does
not claim automated overflow coverage; the shell is simple enough that manual verification is
sufficient and honest.

**Alternatives considered**:

- Playwright viewport assertions — rejected: unapproved new tooling/CI gate (DEF-19).
- Desktop-first pixel copies — rejected by FR-056.
- Global `overflow-x: hidden` — rejected by FR-061; it would mask defects.

## R13. Documentation and ADR placement

**Decision**: Add `README.md` (root) for setup/commands/hooks/app-at-root, add
`docs/adr/0001-portfolio-foundation.md` for durable decisions, and update `docs/ci.md` from the
"not scaffolded" state. Do not touch `AGENTS.md`, the constitution, product, or design documents.

**Rationale**: FR-066–FR-069 and AC-050/AC-051. No ADR directory exists; `docs/adr/` is the
conventional home and is additive documentation, not a governance rewrite.

**Alternatives considered**:

- Put the ADR in `specs/` — rejected: ADRs are durable repository decisions, not feature
  artifacts.
- Rewrite `docs/ci.md` wholesale — rejected: only the stale statements are updated.
- Edit `AGENTS.md` — prohibited by FR-069.
