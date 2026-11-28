# Tasks: Portfolio Foundation

**Input**: Design documents from `/specs/001-portfolio-foundation/`

**Prerequisites**: plan.md, spec.md, research.md, data-model.md, contracts/, quickstart.md

**Tests**: Required by this specification (FR-019, FR-030, FR-054, FR-061, FR-063, FR-064; AC-007,
AC-034, AC-037, AC-041). They are not optional here.

**Organization**: Tasks are grouped by user story so each story can be implemented, tested, and
reviewed independently. Setup and Foundational phases carry no story label.

## Resolved Prerequisite: D-001 (Node.js 26 LTS)

The owner approved Node.js 26 LTS on 2026-11-28 in `docs/decisions/D-001-nodejs-version.md`,
resolving constitution DEF-17. `package.json`, `package-lock.json`, and `.nvmrc` must still land
together (FR-005), and `.nvmrc` must pin `26`. **T001 verifies the recorded approval and local
Node.js 26 availability before T003**. If the record is missing or `.nvmrc` would not pin `26`,
stop and report it; do not substitute another version.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependency on an incomplete task)
- **[Story]**: `US1`–`US5`, mapping to spec §3 user stories
- Every task names the exact file or artifact it touches

## Path Conventions

Single application at the repository root (no `frontend/`/`backend/`). Application code lives under
`src/`; documents under `docs/` and `specs/001-portfolio-foundation/`.

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Owner gate, atomic scaffold, and tooling configuration. No user story work may begin
until this phase and Phase 2 are complete.

- [ ] T001 Verify that D-001 is recorded as Node.js 26 LTS in `docs/decisions/D-001-nodejs-version.md` and that Node.js 26 is available locally (install with `nvm install 26` if needed); if the record is missing or Node.js 26 cannot be installed and verified, stop and report it without creating files, per `specs/001-portfolio-foundation/plan.md` §Owner Decision D-001 (Resolved)
- [ ] T002 Confirm the working branch is `feat/001-portfolio-foundation` and that no unrelated changes are staged, per `.specify/memory/constitution.md` Principle XIV
- [ ] T003 Create the atomic application scaffold in `package.json`, `.nvmrc`, and `package-lock.json` together: `"type": "module"`, the approved Node.js 26 LTS major line (`26`) from the D-001 record (do NOT choose a different line), runtime deps `react@19`, `react-dom@19`, dev deps exactly `vite`, `@vitejs/plugin-react`, `tailwindcss`, `@tailwindcss/vite`, `typescript`, `@types/react`, `@types/react-dom`, `@types/node`, `eslint`, `@eslint/js`, `typescript-eslint`, `eslint-plugin-react-hooks`, `eslint-config-prettier`, `globals`, `prettier`, `vitest`, `@vitest/coverage-v8`, `jsdom`, `@testing-library/react`, `@testing-library/jest-dom`, `axe-core`, `husky`, `lint-staged`, `@commitlint/cli`, `@commitlint/config-conventional`; scripts `dev: vite`, `lint: eslint . --max-warnings 0`, `format:check: prettier --check .`, `typecheck: tsc -b --pretty false` (no output; `noEmit: true` is set in both referenced tsconfigs), `test: vitest run --coverage`, `build: vite build`, `prepare: husky`; generate the lockfile with npm and deliver all three files in the same change
- [ ] T004 [P] Create `.gitignore` ignoring `node_modules/`, `dist/`, and `coverage/`
- [ ] T005 [P] Create `.prettierrc.json` and `.prettierignore` ignoring `node_modules`, `dist`, `coverage`, `package-lock.json`, `.specify/`, `specs/`, and `docs/design/references/`; do not reformat pre-existing documents. If a pre-existing out-of-scope file fails repo-wide `format:check`, add that specific path to `.prettierignore` with a recorded reason rather than mass-reformatting it or weakening the gate
- [ ] T006 [P] Create `tsconfig.json` (solution refs), `tsconfig.app.json` (DOM libs, `jsx: "react-jsx"`, `module: "ESNext"`, `moduleResolution: "bundler"`, `strict`, `noUncheckedIndexedAccess`, `exactOptionalPropertyTypes`, `noEmit: true`, `types: ["vite/client", "node"]` (Node types are needed by the test setup's rejection guard; app code must not use Node globals), `paths: { "@/*": ["./src/*"] }`), `tsconfig.node.json` (Vite/Vitest config files, Node types, `noEmit: true`), and `src/vite-env.d.ts` with `/// <reference types="vite/client" />` so `?raw` imports type-check
- [ ] T007 [P] Create `vite.config.ts` with `@vitejs/plugin-react`, `@tailwindcss/vite`, and `resolve.alias: { "@": fileURLToPath(new URL("./src", import.meta.url)) }` using `node:url` (do not use the invalid `"/src"` literal)
- [ ] T008 [P] Create `eslint.config.js` flat config with `@eslint/js`, `typescript-eslint` recommended-type-checked configured with `parserOptions.projectService: true`, `eslint-plugin-react-hooks`, `globals` for browser and Node config scopes, `eslint-config-prettier` last, and explicit `no-explicit-any`, `no-non-null-assertion`, and `func-style: expression`; ignore `dist`, `coverage`, `docs`, `specs`, and `.specify`; no boundary plugin and no `import/no-restricted-paths`
- [ ] T009 [P] Create `vitest.config.ts` with `environment: "jsdom"`, `setupFiles: ["./src/test/setup.ts"]`, v8 coverage over `src/**` excluding test files, `src/test/**`, and `src/main.tsx`, with 80% lines/statements/functions/branches (no 90% critical threshold); merge `vite.config.ts` via `mergeConfig` or repeat the `@` alias so tests resolve `@/…`
- [ ] T010 [P] Create `index.html` with `<html lang="en">`, one root mount node (`#root`), a `<script type="module" src="/src/main.tsx">` entry, and a single minimal title using the confirmed Walfolio name; no description, canonical, Open Graph, structured data, favicon, or other asset reference

**Checkpoint**: Scaffold satisfies CI detection (package.json + lockfile + .nvmrc together).

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Token layer, shared styling, i18n resource, and test infrastructure required by every
user story.

- [ ] T011 [P] Create `src/app/styles/tokens.css` as the only global token source: `@theme` with all 13 documented colors, `--font-sans` (Inter fallback chain), Approx. weight tokens (`--font-weight-body: 400`, `--font-weight-nav: 500`, `--font-weight-heading: 600`), the full text scale h1–h6 plus xl/lg/md/sm/xs with paired line heights and Proposed `--text-h1-mobile` (2.5rem) / `--text-h2-mobile` (2.25rem), breakpoint `--breakpoint-tablet: 48rem` / `--breakpoint-desktop: 80rem`, five radii, and the eight-step shadow ramp; `:root` spacing `--space-1…11` (4, 8, 12, 16, 24, 32, 40, 48, 64, 80, 120 px), layout (`--layout-container`, `--layout-container-wide`, `--layout-container-fluid: calc(100% - (2 * var(--layout-gutter)))`, `--layout-gutter: clamp(1.25rem, 5.5vw, 5rem)`, `--layout-header-height: 88px`, `--layout-section-padding-y`, `--layout-grid-gap-sm/md/lg`, `--layout-hero-text-split`, `--layout-faq-measure`), mobile boundary `--breakpoint-mobile-max: 47.9375rem`, borders (`--border-hairline`, `--border-outline-teal`, reference-only `--border-dark-row`), and all seven surface mappings; add a provenance comment naming the design-system token and its `Verified | Approx. | Proposed | Open | reference-only` status on every block; record `color.teal-primary` (`#088D84`) as `Verified` with the white-text contrast restriction `Open`
- [ ] T012 [P] Create `src/app/styles/global.css` importing `tailwindcss` then `./tokens.css`, plus base styles, a visible `:focus-visible` treatment that is not clipped, and a `prefers-reduced-motion: reduce` block; no global `overflow-x: hidden` and no fixed heights
- [ ] T013 [P] Create `src/shared/i18n/en.ts` exporting a typed nested `en` resource (`home.title: "Walfolio"`) and an exported `Messages` type; no i18n library, loader, or switcher
- [ ] T014 [P] Create `src/test/setup.ts` loading `@testing-library/jest-dom/vitest`, asserting no unexpected `console.warn`/`console.error` after each test, and failing the suite on unhandled promise rejections; do not silence console output globally
- [ ] T015 [P] Create `src/test/axe.ts` running `axe-core` against a rendered container, setting `document.documentElement.lang = "en"` to mirror `index.html` for page-level rules, and disabling only `color-contrast` with the documented reason that jsdom has no layout engine

**Checkpoint**: Foundation ready — user stories can start.

---

## Phase 3: User Story 1 - Initialize and run the foundation (Priority: P1) 🎯 MVP

**Goal**: A runnable, installable, buildable application that renders the honest shell.

**Independent Test**: From a clean checkout using Node.js 26 LTS, `npm ci`, `npm run dev`,
and `npm run build` succeed; the shell renders one `main` with one H1 "Walfolio" and no controls.

### Tests for User Story 1

- [ ] T016 [P] [US1] Write `src/pages/home/ui/HomePage.test.tsx` asserting via roles/accessible names: exactly one `main` (`getByRole("main")`), exactly one H1 (`getByRole("heading", { level: 1, name: en.home.title })`), and no `header`, `nav`, `footer`, link, button, input, or other focusable control
- [ ] T017 [P] [US1] Write `src/app/App.test.tsx` asserting the composition root mounts the shell without adding landmarks or console noise
- [ ] T018 [P] [US1] Write `src/test/document.test.ts` reading `index.html` via `?raw` and asserting `lang="en"`, exactly one `#root` mount node, the module entry to `/src/main.tsx`, the minimal title equal to `en.home.title`, no meta description/canonical/Open Graph/structured data/favicon/asset reference, and that the literal "Walfolio" does not appear in `HomePage.tsx` or `App.tsx` sources (externalization contract plus the documented title exception)

### Implementation for User Story 1

- [ ] T019 [US1] Create `src/pages/home/ui/HomePage.tsx` as a typed arrow component rendering `<main><h1>{en.home.title}</h1></main>` with token-driven styling and no hardcoded copy
- [ ] T020 [US1] Create `src/pages/home/index.ts` exporting the slice public API (`HomePage`)
- [ ] T021 [US1] Create `src/app/App.tsx` importing `HomePage` from `@/pages/home`
- [ ] T022 [US1] Create `src/main.tsx` importing `@/app/styles/global.css` once and mounting `App` into the single root node
- [ ] T023 [P] [US1] Write `README.md` covering Node.js 26 LTS (from `.nvmrc`), `npm ci`, `npm run dev`, `build`, all five canonical scripts, hook behavior, the application-at-root constraint, and axe-core as development-only tooling with the disabled `color-contrast` reason
- [ ] T024 [US1] Verify `.nvmrc` contains `26`, `npm ci` does not rewrite `package-lock.json`, `npm run dev` serves the shell without uncaught runtime errors, and `npm run build` emits static assets to `dist/`; record actual outcomes for `specs/001-portfolio-foundation/quickstart.md`

**Checkpoint**: US1 is independently functional and buildable.

---

## Phase 4: User Story 2 - Apply the design, accessibility, and responsive foundation (Priority: P2)

**Goal**: Token governance, accessibility baseline, and responsive foundation are verifiable.

**Independent Test**: Every token category has a semantic representation with provenance status in
`src/app/styles/tokens.css`; axe reports no violations on the shell; no horizontal overflow occurs at
the five approved widths; keyboard traversal exposes zero focus stops, recorded as vacuous.

### Tests for User Story 2

- [ ] T025 [P] [US2] Write `src/test/styles.contract.test.ts` importing `src/app/styles/tokens.css` and `src/app/styles/global.css` via `?raw` and asserting every category (color, typography, spacing, layout, breakpoint, radius, border, shadow, surface) and every token name listed in `contracts/tokens.md` is present, including reference-only border/surface tokens, mobile type tokens, `layout.container-fluid`, and the mobile breakpoint boundary; every token declaration block in `tokens.css` carries a `Verified | Approx. | Proposed | Open | reference-only` status; `color.teal-primary` is `Verified` with its white-text contrast restriction `Open`; no second global token source exists; `global.css` imports Tailwind then tokens, defines `:focus-visible` and `prefers-reduced-motion`, and contains no global `overflow-x: hidden` or fixed heights; foundation `.tsx` files contain no raw hex/rgb values or arbitrary `[...]` visual values
- [ ] T026 [P] [US2] Write `src/test/accessibility.test.tsx` rendering `App`, running the `axe.ts` helper, and asserting one `main`, one H1 (`getByRole("heading", { level: 1, name: en.home.title })`), and zero focusable elements (`a, button, input, select, textarea, [tabindex]`)

### Implementation and Validation for User Story 2

- [ ] T027 [P] [US2] Audit CSS/UI values in `src/pages/home/ui/HomePage.tsx` and `src/app/App.tsx` for raw hex colors, arbitrary spacing, radii, or shadows; confirm only semantic tokens/utilities are used and no `color.teal-primary` with white text is used
- [ ] T028 [P] [US2] Audit `src/app/styles/global.css` for the defined focus-visible treatment and reduced-motion block, and confirm no global overflow masking or fixed heights exist
- [ ] T029 [US2] Perform manual responsive validation at 375, 768, 1024, 1280, and 1440 px against `src/app/styles/tokens.css`; confirm no horizontal overflow and record tablet/mobile as **Proposed** adaptations, with 1440 px as a documented approximation; capture screenshots when available, otherwise state that visual evidence is unavailable
- [ ] T030 [P] [US2] Perform manual keyboard traversal of the running shell; record "no focusable element exists" as vacuous, not as a passed focus test, per `src/app/styles/global.css`
- [ ] T031 [P] [US2] Confirm across `src/` that no text-bearing teal primary button, no color-only meaning, and no WCAG 2.2 AA/conformance claim exists

**Checkpoint**: US2 governance, accessibility, and responsive baselines are verifiable.

---

## Phase 5: User Story 3 - Extend the application within clear boundaries (Priority: P3)

**Goal**: Layer boundaries and import direction are correct and review-verifiable, with no automated
boundary enforcement.

**Independent Test**: A temporary cross-boundary probe is flagged in review; a correctly placed
module passes all configured checks; the probe is removed and never committed.

- [ ] T032 [P] [US3] Verify `src/` contains only `app`, `pages`, `shared`, and test infrastructure `src/test`; confirm no empty `features`, `entities`, or `widgets` directory exists
- [ ] T033 [P] [US3] Verify every import in `src/app/App.tsx`, `src/main.tsx`, and `src/pages/home/ui/HomePage.tsx` points downward (`app → pages → shared`) and uses `@/…`; flag any `../../..` climbing import
- [ ] T034 [P] [US3] Verify `src/app/App.tsx` consumes `@/pages/home` through the slice public API and not internal files
- [ ] T035 [US3] Add a temporary cross-boundary probe under `src/shared/`, confirm the review checklist in `specs/001-portfolio-foundation/contracts/module-boundaries.md` flags it, then remove it and verify git status is clean of the probe
- [ ] T036 [P] [US3] Verify `src/shared/i18n/en.ts` contains only the generic, typed English resource and no business rule or page-specific composition
- [ ] T037 [P] [US3] Verify `src/pages/home/ui/HomePage.tsx` uses arrow syntax, explicitly typed props, a single responsibility, no speculative abstraction, and no unjustified type assertion, non-null assertion, or compiler suppression

**Checkpoint**: US3 boundaries are correct and review-verified; no boundary tooling was added.

---

## Phase 6: User Story 4 - Verify quality locally and in CI (Priority: P4)

**Goal**: Each canonical gate is proven real by a deliberate failure, and local/CI execution paths
are intact.

**Independent Test**: Each canonical script fails on a deliberate violation and passes otherwise; the
pre-push sequence runs the same five scripts CI runs; no bypass is used.

- [ ] T038 [US4] Prove `lint` is real: add an unused variable or explicit `any` in a throwaway change under `src/`, confirm non-zero exit from `eslint . --max-warnings 0` configured in `eslint.config.js`, then revert. These negative checks share one working tree and each gate scans the whole application, so T038–T042 MUST run sequentially with the probe reverted between checks (or in isolated worktrees), not concurrently
- [ ] T039 [US4] Prove `format:check` is real: misformat a throwaway `.tsx` file, confirm non-zero exit from Prettier configured in `.prettierrc.json`, then revert
- [ ] T040 [US4] Prove `typecheck` is real: assign a string to a `number` in a throwaway change under `src/`, confirm non-zero exit from the `tsconfig.app.json` project build, then revert
- [ ] T041 [US4] Prove `test` is real: break one assertion and add a stray `console.warn`, confirm non-zero exit from `vitest run --coverage` with `src/test/setup.ts`; also add a throwaway uncovered module (or disable enough covered tests) to force coverage below 80 and confirm the threshold fails the run rather than passing silently; then revert all probes
- [ ] T042 [US4] Prove `build` is real: introduce a syntax/import error in a throwaway change, confirm non-zero exit from `vite build`, then revert
- [ ] T043 [US4] Run the full canonical sequence `lint`, `format:check`, `typecheck`, `test`, `build` from `package.json`; confirm coverage is ≥ 80% globally, zero unexpected console output, and no unhandled rejections
- [ ] T044 [US4] Verify `.husky/pre-commit`, `.husky/commit-msg`, and `.husky/pre-push` execute their configured tools without `--no-verify`; confirm `.lintstagedrc.json` and `commitlint.config.cjs` are unchanged; do not create commits without explicit user authorization
- [ ] T045 [US4] Verify CI compatibility without modifying `.github/workflows/ci.yml`: `detect` requires `package.json` + `package-lock.json` + `.nvmrc`, `.nvmrc` contains `26`, and the application job runs `npm ci` followed by the same five scripts
- [ ] T046 [P] [US4] Audit `package.json` scripts for echo-only commands, `|| true`, `--passWithNoTests`, disabled coverage, or skipped checks; none may exist

**Checkpoint**: US4 gates are proven real locally and aligned with existing CI.

---

## Phase 7: User Story 5 - Review the foundation without hidden decisions (Priority: P4)

**Goal**: Durable decisions and provisional values are documented; no still-open deferred decision
is resolved.

**Independent Test**: Review the ADR, token provenance, dependency inventory, and `docs/ci.md`; every
deferred decision is absent or explicitly recorded, and no provisional token is presented as verified.

- [ ] T047 [P] [US5] Create `docs/adr/0001-portfolio-foundation.md` recording the approved stack, single token source, FSD-lite boundaries, deferred rendering/router/i18n decisions, the D-001 approval reference (`docs/decisions/D-001-nodejs-version.md`) and Node.js 26 LTS decision, the 80% coverage decision, the axe-core D-007 development-only decision, and the Inter fallback deviation; state that 90% is not enforced
- [ ] T048 [P] [US5] Update only the stale statements in `docs/ci.md`: scaffolded application state, detection behavior, and `axe-core` as development-only accessibility tooling; do not restructure or rewrite unrelated sections
- [ ] T049 [P] [US5] Audit `package.json` dependencies against the plan inventory in `specs/001-portfolio-foundation/plan.md`; confirm zero unapproved runtime dependencies and no `@testing-library/user-event`
- [ ] T050 [P] [US5] Audit `src/` and configuration for absent deferred decisions: no router, rendering strategy, SSG tool, i18n library, hosting/deployment config, analytics, backend, or API; confirm `color.teal-primary` remains `Verified` as a color and `Open` for white-text use
- [ ] T051 [P] [US5] Confirm `AGENTS.md`, `.specify/memory/constitution.md`, `docs/product-overview.md`, and `docs/design/*` are unchanged by the implementation (git diff shows no modification)
- [ ] T052 [P] [US5] Confirm no secret, credential, tracking script, portfolio copy, invented metric, testimonial, "coming soon" placeholder, or fabricated brand asset exists in `src/` or `index.html`

**Checkpoint**: US5 review artifacts are complete and honest.

---

## Phase 8: Polish & Cross-Cutting Concerns

**Purpose**: Final consistency and evidence, without expanding scope.

- [ ] T053 [P] Run the full `specs/001-portfolio-foundation/quickstart.md` validation flow end to end (setup, canonical checks, functional, accessibility, responsive, governance) and replace placeholder expectations with the actual observed results
- [ ] T054 [P] Confirm `vitest.config.ts` enforces exactly the 80% global threshold and that no 90% critical-module threshold is enforced or implied
- [ ] T055 Prepare the Pull Request description in Markdown following the PR rules in `AGENTS.md`, listing only checks actually executed as passed/failed/not-run, plus manual accessibility and responsive evidence; include screenshots/recordings when available or a clear placeholder identifying the required capture; do not create or push a PR
- [ ] T056 [P] Verify the delivered change contains no unrelated files, no `frontend/` or `backend/` directory, and no deployment, hosting, preview, or additional CI gate
- [ ] T057 Re-run `lint`, `format:check`, `typecheck`, `test`, and `build` after the documentation edits from T047, T048, T053, and T055; record the real final results

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: T001 gates T003; T003 must finish before T004–T010; all configs must finish
  before Phase 2.
- **Phase 2 (Foundational)**: Depends on Phase 1; blocks every user story.
- **Phase 3 (US1)**: Depends on Phase 2; first executable story because US2–US5 verify artifacts it
  creates.
- **Phase 4 (US2) and Phase 5 (US3)**: Depend on US1 (the shell and structure it verifies) in addition
  to Phase 2; US2 and US3 may run in parallel after US1.
- **Phase 6 (US4)**: Depends on US1 and US2; the gate proofs and coverage check need the shell tests
  and axe assertions to exist.
- **Phase 7 (US5)**: Depends on US1–US4; the ADR, `docs/ci.md` update, and audits cover the delivered
  artifacts.
- **Phase 8 (Polish)**: Depends on all selected stories.

### User Story Dependencies

- **US1 (P1)**: No story dependency after Phase 2. MVP.
- **US2 (P2)**: Depends on US1; verifies the foundational token/style layer plus US1's shell.
- **US3 (P3)**: Depends on US1; verifies the structure and imports US1 created.
- **US4 (P4)**: Depends on US1 and US2; verifies scripts from Phase 1 and tests from US1/US2.
- **US5 (P4)**: Depends on US1–US4; verifies decisions and dependencies across all phases.

### Within Each User Story

- US1 tests are written before the US1 implementation and must fail first. US2 contract tests are
  written against the Phase 2 token/style files and the US1 shell; they must be observed failing
  before any US2-driven correction and must never be weakened to pass.
- Component before slice public API before composition root before bootstrap (US1).
- Story complete and validated before moving to the next priority in a serial run.

### Parallel Opportunities

- T004–T010 (Phase 1 configs) run in parallel after T003.
- T011–T015 (Phase 2 files) run in parallel.
- T016–T018 (US1 tests) run in parallel; then T019 → T020 → T021 → T022.
- T025–T026 (US2 tests) run in parallel; T027, T028, T030, T031 are independent audits.
- T032–T034, T036–T037 (US3 audits) run in parallel; T035 (probe) is sequential.
- T038–T042 (US4 negative checks) run sequentially because each gate scans the whole repository and
  one probe can break another gate; after all probes are reverted, T043 → T044/T045/T046.
- T047–T048 (US5 documents) run in parallel; T049–T052 audits in parallel.
- T053, T054, T056 in parallel; T055 and T057 after their inputs.

---

## Parallel Example: User Story 1

```bash
# Tests first (different files):
Task: "Write src/pages/home/ui/HomePage.test.tsx"
Task: "Write src/app/App.test.tsx"
Task: "Write src/test/document.test.ts"

# Then implementation chain:
Task: "Create src/pages/home/ui/HomePage.tsx"
Task: "Create src/pages/home/index.ts"
Task: "Create src/app/App.tsx"
Task: "Create src/main.tsx"
```

## Parallel Example: User Story 2

```bash
Task: "Write src/test/styles.contract.test.ts"
Task: "Write src/test/accessibility.test.tsx"
Task: "Audit raw visual values in src/pages/home/ui/HomePage.tsx"
Task: "Audit focus-visible and reduced motion in src/app/styles/global.css"
```

---

## Implementation Strategy

### MVP First (User Story 1)

1. Complete Phase 1 (after T001 approval) and Phase 2.
2. Complete Phase 3 (US1).
3. Stop and validate US1 independently: clean install, dev shell, production build.
4. US1 is the smallest deliverable; US2 adds token/a11y/responsive verification, US3 boundaries,
   US4 gate proof, US5 decision records.

### Incremental Delivery

1. Setup + Foundational → configs and shared layers exist.
2. US1 → runnable shell and build → validate.
3. US2 → tokens, axe, responsive evidence → validate.
4. US3 → boundary review evidence → validate.
5. US4 → proven quality gates and hook/CI alignment → validate.
6. US5 → ADR and documentation → validate.
7. Polish → quickstart results and PR description.

### Parallel Team Strategy

After Phase 2: Developer A completes US1 first. Then Developer B takes US2 (token/a11y verification)
and Developer C takes US3 (boundary review) in parallel. US4 runs after US1/US2, and US5 runs after
US1–US4; the owner or reviewer takes US5. US4 and US5 finish last because they verify other work.

---

## Notes

- D-001 is resolved as Node.js 26 LTS. T001 still verifies the recorded decision and local Node.js 26 availability before T003; `.nvmrc` must pin `26`.
- No router, rendering strategy, SSG, i18n library, hosting, analytics, backend, or extra CI gate may
  be added by any task.
- No commit, push, or PR may be created without explicit user authorization (AGENTS.md).
- [P] means different files and no dependency on an incomplete task.
- Verify tests fail before implementing; never lower coverage or silence console output to pass.
- Record actual validation results; mark unavailable checks as not run.
