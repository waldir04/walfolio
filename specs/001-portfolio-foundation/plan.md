# Implementation Plan: Portfolio Foundation

**Branch**: `feat/001-portfolio-foundation` | **Date**: 2026-11-28 | **Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `specs/001-portfolio-foundation/spec.md`

## Summary

Scaffold a single static React 19 + TypeScript + Vite + Tailwind CSS v4 application at the
repository root with a reduced FSD structure (`app`, `pages`, `shared`), one governed token source
at `src/app/styles/tokens.css`, an honest one-page shell (one `main`, one H1, no controls), the
canonical quality script contract wired to real tools, and foundation tests that fail on console
noise. The work also updates developer/CI documentation and records durable decisions in an ADR.

**Implementation status: READY (D-001 resolved).** The owner approved Node.js 26 LTS on
2026-11-28 in `docs/decisions/D-001-nodejs-version.md`, resolving spec D-001 and constitution
DEF-17. Design and planning artifacts are complete; scaffolding may begin once Node.js 26 is
installed locally and implementation is explicitly authorized.

## Technical Context

**Language/Version**: TypeScript 5.x (strict); React 19. Node.js: **26 LTS**, approved 2026-11-28
(D-001); `.nvmrc` pins major line `26` at scaffold.

**Primary Dependencies**: Runtime `react`, `react-dom`. Development/build: `vite`,
`@vitejs/plugin-react`, `tailwindcss` v4 + `@tailwindcss/vite`, `typescript` (+ React/Node types).
Quality: `eslint`, `@eslint/js`, `typescript-eslint`, `eslint-plugin-react-hooks`,
`eslint-config-prettier`, `globals`, `prettier`. Test: `vitest`, `@vitest/coverage-v8`, `jsdom`,
`@testing-library/react`, `@testing-library/jest-dom`, `axe-core`. Git: `husky`, `lint-staged`,
`@commitlint/cli`, `@commitlint/config-conventional` (the last two already required by the
existing `commitlint.config.cjs` and `.husky/commit-msg`).

**Storage**: N/A. Static content in the repository; no database, API, CMS, or auth.

**Testing**: Vitest + React Testing Library + jsdom, coverage via `@vitest/coverage-v8` with an
enforced 80% global threshold, automated accessibility assertions with raw `axe-core`, and a
console/rejection guard that fails the suite. Responsive widths and focus appearance remain manual
verification (no Playwright/visual-regression dependency is added).

**Target Platform**: Static browser application built to `dist/`; no server, runtime secrets, or
external services. Validation widths: 375, 768, 1024, 1280, 1440 px.

**Project Type**: Single frontend web application at the repository root (no `frontend/` or
`backend/` directories).

**Performance Goals**: No numeric budgets exist (deferred). The plan keeps the dependency surface
minimal, ships no heavy libraries, and adds no runtime service or font service.

**Constraints**: No router, rendering strategy, SSG tool, i18n library, deployment, or CI gate may
be introduced. Existing CI workflows, Husky hooks, lint-staged, and commitlint configuration are
authoritative and must keep working. The shell renders no interactive element, so skip-link and
44 × 44 px target criteria bind only future interactive work. The unresolved teal contrast
(`color.teal-primary` + white at ≈4.1:1) stays `Open`; no text-bearing primary button is built.

**Scale/Scope**: One shell page, three real layers, one H1, one token source, five canonical
scripts. No portfolio sections or product pages.

## Owner Decision D-001 (Resolved)

| Item | State |
| --- | --- |
| Node.js version | **Node.js 26 LTS**, approved 2026-11-28; `.nvmrc` value `26` |
| Decision record | `docs/decisions/D-001-nodejs-version.md`; constitution DEF-17 marked resolved |
| Why it mattered | `package.json`, `package-lock.json`, and `.nvmrc` must land together (FR-005); CI fails if `package.json` exists without the other two |
| Plan behavior | Scaffold only after Node.js 26 is installed locally; pin `26`, generate the lockfile on Node.js 26, and deliver all three files together |
| Change control | A different Node.js major line requires a new documented owner decision, not an untracked version change |

The approval was a separate owner decision, as required by spec §9 and FR-004. The plan records
the approved version but does not re-decide it.

## Constitution Check

*GATE: evaluated before Phase 0 research and re-evaluated after Phase 1 design.*

| Principle | Gate | Status |
| --- | --- | --- |
| I. Clean Code, Simplicity, Maintainability | Only layers/components with real responsibility; no speculative abstractions | PASS — `shared` holds only the i18n resource; no empty slices |
| II. Strict TypeScript and Type Safety | `strict`, no `any`, no unjustified assertions/suppressions | PASS — `tsc -b` with `noEmit: true` in the referenced tsconfigs; ESLint `no-explicit-any`/`no-non-null-assertion` |
| III. Design Fidelity and Token Governance | Semantic tokens, single source, provenance preserved | PASS — `tokens.css` is the only global token source; statuses annotated |
| IV. FSD-Lite Architecture and Module Boundaries | Downward imports, path alias, no empty layers, review-verified boundaries | PASS — `app` ← `pages` ← `shared`; `@/*` alias; no boundary plugin (per Principle IV and spec FR-016) |
| V. Component Design and Function Syntax | Arrow functions, explicit props, no data in presentational components | PASS — shell page is a typed arrow component; no data access |
| VI. Accessibility as a Requirement | Semantic landmarks, one H1, lang, focus-visible, reduced motion, no AA claim | PASS — single `main` + H1, `lang="en"`, focus/motion defined in styling layer; no conformance claim |
| VII. Internationalization Readiness | All user-facing text externalized, no hardcoded copy, fallback predictable | PASS — typed English resource module; no i18n library; the static `<title>` is the one documented metadata exception |
| VIII. Testing, Zero-Warning, Coverage | Vitest/RTL, behavior tests, console guard, 80% enforced | PASS — plan defines thresholds and console/rejection failure |
| IX. Performance and Media Efficiency | Minimal deps, font fallback, no heavy libraries | PASS — no media/font service; no unnecessary runtime deps |
| X. SEO, Metadata, Semantic Structure | No final metadata or rendering assumption | PASS — the foundation is not a published page (A-010), so the published-page title/description rule is not triggered; the static minimal title is the documented pre-bootstrap exception, and meta/canonical/OG wait for D-002 |
| XI. Honest Content and Product-Status Accuracy | No invented copy, no fake features | PASS — one H1 with the confirmed name; no placeholder sections |
| XII. Static Architecture, Privacy, Security | No backend/API/CMS/auth/analytics; no secrets | PASS — static build only |
| XIII. Technology Stack and Dependency Governance | Only React/TS/Vite/Tailwind + approved tooling; deps justified | PASS — every dependency is approved stack or documented dev tooling; Node.js 26 LTS is approved by D-001 and pinned at scaffold |
| XIV. Quality Gates, Git Workflow, Commit Convention | Canonical scripts, hooks, CI unchanged, no bypass | PASS — scripts invoke real tools; workflows and hook config unchanged |
| XV. Documentation, Decision Records, Visual Validation | ADR for durable decisions; docs aligned; no fabricated evidence | PASS — ADR + README + `docs/ci.md` update; responsive results recorded as manual/proposed |

**Gate result**: no constitutional violations; Complexity Tracking is empty. D-001 is resolved, so
no owner decision blocks implementation start; only local Node.js 26 installation and explicit
implementation authorization remain.

## Project Structure

### Documentation (this feature)

```text
specs/001-portfolio-foundation/
├── plan.md              # This file
├── research.md          # Phase 0 decisions and rejected alternatives
├── data-model.md        # Governance entities and validation rules
├── quickstart.md        # End-to-end validation guide
├── contracts/
│   ├── app-shell.md     # Semantic shell and document contract
│   ├── scripts.md       # Canonical script and hook contract
│   ├── tokens.md        # Token registry and provenance contract
│   └── module-boundaries.md  # Layer/import review contract
├── checklists/
└── tasks.md             # Created by /speckit.tasks, not here
```

### Source Code (repository root)

```text
# Repository root — application at root, no frontend/ or backend/
index.html                       # lang="en"; single root node; provisional title only
package.json                     # canonical scripts + prepare: husky
package-lock.json                # committed lockfile, generated on Node.js 26
.nvmrc                           # approved Node.js 26 LTS (`26`)
.gitignore                       # node_modules, dist, coverage
.prettierrc.json / .prettierignore
eslint.config.js                 # flat config, typed rules, zero warnings
vite.config.ts                   # react + tailwind plugins, @ alias
vitest.config.ts                 # jsdom, setup file, coverage thresholds
tsconfig.json / tsconfig.app.json / tsconfig.node.json
README.md                        # setup, commands, hooks, app-at-root constraint
docs/decisions/D-001-nodejs-version.md  # owner approval: Node.js 26 LTS
docs/adr/0001-portfolio-foundation.md
docs/ci.md                       # updated scaffolded state + axe-core note

src/
├── main.tsx                     # bootstrap: mounts App, imports global styles once
├── vite-env.d.ts                # Vite client types for CSS and ?raw imports
├── app/
│   ├── App.tsx                  # composition root: renders the shell page
│   └── styles/
│       ├── tokens.css           # ONLY global token source (@theme + semantic custom props)
│       └── global.css           # tailwind import, base layer, focus-visible, reduced motion
├── pages/
│   └── home/
│       ├── index.ts             # public API of the slice
│       ├── ui/HomePage.tsx      # <main><h1>{copy}</h1></main>
│       └── ui/HomePage.test.tsx
├── shared/
│   └── i18n/
│       └── en.ts                # typed, namespaced English resource (no library)
└── test/
    ├── setup.ts                 # jest-dom, console/rejection guard
    └── axe.ts                   # axe-core helper (contrast rule disabled in jsdom)
```

**Structure Decision**: Single application at the repository root using FSD-lite. Only `app`,
`pages`, and `shared` exist because only those have real responsibilities; `features`, `entities`,
and `widgets` are deliberately absent (FR-009, FR-010). `src/test/` is test infrastructure, not an
FSD layer, and is documented as such. Tests are colocated with their subject (`pages/home/ui`), and
cross-layer imports use `@/…` (e.g. `@/shared/i18n/en`).

## Phase 0: Research Outcomes

Full detail in [research.md](./research.md). Decisions that shape the plan:

1. **Node.js (D-001)**: resolved by the owner as Node.js 26 LTS on 2026-11-28; research R1 records
   the evaluation and `docs/decisions/D-001-nodejs-version.md` records the decision.
2. **Tailwind v4 token strategy**: `tokens.css` holds `@theme` definitions for namespaced
   utilities (color, font, text, radius, shadow, breakpoint) plus `:root` semantic custom
   properties for layout/spacing tokens whose scale is not multiplicative. All documented tokens
   are represented, including reference-only borders/surfaces, the mobile type sizes,
   `layout.container-fluid`, and the mobile breakpoint upper bound. `global.css` imports Tailwind
   and then tokens so there is exactly one global token graph.
3. **Token provenance**: every block carries a `Verified | Approx. | Proposed | Open |
   reference-only` comment with the design-system token name, so provisional values stay traceable
   and centrally adjustable.
4. **i18n readiness without a library**: a typed `en.ts` object with descriptive nested keys and
   an exported type; components import it directly. No loader, switcher, or dependency.
5. **Testing**: Vitest `jsdom`, a setup file loading `@testing-library/jest-dom/vitest` that fails
   on unexpected `console.warn`/`error` and unhandled rejections, `axe-core` run against the
   rendered container with `color-contrast` disabled (jsdom has no layout), 80% global thresholds on
   statements/branches/functions/lines, and documented exclusions for test files and `main.tsx`
   bootstrap only. A separate styles-contract test parses `tokens.css`/`global.css` via `?raw`.
6. **Lint/format risk**: no Prettier config exists today. The plan adds one and scopes
   `.prettierignore` to generated output and non-code reference assets; pre-existing documents are
   not mass-reformatted. If a pre-existing file fails `format:check`, it is recorded rather than
   silently rewritten outside the task scope.
7. **Build/typecheck split**: `build` runs `vite build` (real production build); `typecheck` runs
   `tsc -b --pretty false` with `noEmit: true` in both referenced tsconfigs, so the gate produces no
   output. They are separate canonical gates, so neither hides the other.

## Phase 1: Design Artifacts

- [data-model.md](./data-model.md) — Design Token, Quality Gate, Owner Decision, Translation
  Resource; fields, status lifecycles, validation rules; no persistence.
- [contracts/app-shell.md](./contracts/app-shell.md) — permitted DOM, landmark/heading/language
  rules, what must not render, focus/motion inheritance.
- [contracts/scripts.md](./contracts/scripts.md) — required scripts, real-tool requirement,
  failure semantics, hook/CI alignment.
- [contracts/tokens.md](./contracts/tokens.md) — required token categories, provenance notation,
  consumption rules, prohibited raw values, open items.
- [contracts/module-boundaries.md](./contracts/module-boundaries.md) — layer responsibilities,
  allowed import directions, alias rule, review checklist.
- [quickstart.md](./quickstart.md) — scaffold → validate → manual accessibility/responsive checks,
  with the Node.js 26 prerequisite and expected outcomes.

## Dependency Inventory (FR-043)

| Dependency | Type | Justification | Risk / mitigation |
| --- | --- | --- | --- |
| `react`, `react-dom` | runtime | Approved UI stack | None; pinned major 19 |
| `vite`, `@vitejs/plugin-react` | dev | Approved build tool + official React plugin | Build tool only; no runtime cost |
| `typescript`, `@types/react`, `@types/react-dom`, `@types/node` | dev | Approved language; Node types for Vite/Vitest config | Types only |
| `tailwindcss`, `@tailwindcss/vite` | dev | Approved styling; official v4 Vite integration | CSS output only; no JS runtime |
| `eslint`, `@eslint/js`, `typescript-eslint`, `eslint-plugin-react-hooks`, `eslint-config-prettier`, `globals` | dev | Approved lint tooling; typed strict rules and hook correctness | Dev-only; zero runtime |
| `prettier` | dev | Approved formatting; required by `format:check` and lint-staged | Dev-only |
| `vitest`, `@vitest/coverage-v8`, `jsdom` | dev | Approved test runner/coverage/DOM env | Dev-only |
| `@testing-library/react`, `@testing-library/jest-dom` | dev | Approved testing utilities; behavior assertions | Dev-only |
| `axe-core` | dev | Approved (D-007) automated a11y assertions under Principle XIII | Dev-only; documented as such |
| `husky`, `lint-staged` | dev | Approved Git tooling; existing hooks depend on them | Dev-only |
| `@commitlint/cli`, `@commitlint/config-conventional` | dev | Already required by existing `commitlint.config.cjs`/hook | Dev-only |

Rejected: `vitest-axe` (extra wrapper over approved `axe-core`), `@testing-library/user-event`
(no interactive element yet; add with the first one), router/i18n/SSG libraries (deferred),
Playwright/visual-regression tools (not an approved CI gate).

## Testing Plan

| Level | Coverage |
| --- | --- |
| Component | `HomePage` renders exactly one `main`, one H1 by role/accessibility name with the resource string, no header/nav/footer/buttons/links/inputs |
| App | `App` mounts the shell without console noise |
| Document | `index.html` read via `?raw`: `lang="en"`, one `#root`, module entry, minimal title equal to the resource, no other metadata/assets; source scan confirms rendered copy is externalized |
| Styles contract | `tokens.css`/`global.css` read via `?raw`: all documented tokens/statuses, single token source, focus-visible/reduced-motion, no global overflow masking or fixed heights, no raw visual values |
| Accessibility | `axe-core` on the rendered container; role/name queries; manual keyboard/focus and contrast notes recorded |
| Cross-cutting | Console/rejection guard applies to every test; coverage thresholds enforced by `test` |
| Manual | Five validation widths for overflow; reduced-motion; focus-visible appearance prepared but vacuous now |

## Risks and Mitigations

| Risk | Mitigation |
| --- | --- |
| Node.js 26 outside a selected dependency's engine range | Vite 8.4.0 supports `>=22.12.0`; re-check all selected tool engines before scaffolding. A required change to the Node.js major line needs a new owner decision |
| Tailwind v4 `@theme` namespace details differ from plan assumptions | Validate utility generation during scaffold; keep semantic custom properties as the fallback contract; update `tokens.md` if naming changes |
| Repo-wide `format:check` fails on pre-existing files | Scope ignore file; format only feature-owned files; record rather than mass-reformat |
| `axe-core` contrast rule cannot run in jsdom | Disable that rule explicitly, document the limitation, keep contrast assessment manual |
| jsdom lacks layout, so overflow cannot be asserted in tests | Manual width verification per FR-060; no fake automated claim |
| Existing hooks break because `package.json` arrives without lockfile/`.nvmrc` | Land all three in the same change (FR-005); CI detection enforces it |
| Token file drifts from `design-system.md` | Provenance comments + styles-contract test + contract review gate; token changes update the design document first |
| Vite alias written as `/src` or Vitest not inheriting the alias | Use `fileURLToPath(new URL("./src", import.meta.url))` and `mergeConfig`; verify an `@/…` import in both build and test |
| `tsc -b` emits output because `noEmit` is missing | Set `noEmit: true` in both referenced tsconfigs; confirm `typecheck` leaves no build output |
| Implementation accidentally resolves a deferred decision | Section 9 review checklist in `quickstart.md` and the ADR state the deferred list explicitly |

## Constitution Check (post-design)

Re-evaluated after Phase 1: unchanged. The design adds no new dependency beyond the inventory
above, no layer without responsibility, no automated boundary enforcement, no accessibility
conformance claim, and no still-deferred technology. Node.js 26 LTS is the approved D-001 choice.
Token, shell, script, and boundary contracts are consistent with Principles III, IV, VI, VII,
VIII, XIII, and XIV.

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
| --- | --- | --- |
| None | — | — |
