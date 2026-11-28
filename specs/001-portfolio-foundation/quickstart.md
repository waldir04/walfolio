# Quickstart: Portfolio Foundation

**Feature**: `001-portfolio-foundation` | **Date**: 2026-11-28

Validation guide for the foundation. It proves the application runs, the token layer exists, the
shell is accessible, the quality gates are real, and no still-open deferred decision was resolved.
It does not duplicate implementation details; those belong in `tasks.md` and the implementation.

## Prerequisites

| Requirement | State |
| --- | --- |
| Approved Node.js version (D-001) | **Node.js 26 LTS**, approved 2026-11-28 in `docs/decisions/D-001-nodejs-version.md`; `.nvmrc` pins `26` |
| Node.js matching `.nvmrc` | Node.js 26 installed (`nvm install 26` if the local runtime is older) |
| npm | Required (CI uses `npm ci`) |
| Git branch | `feat/001-portfolio-foundation` |
| Governing docs reviewed | Constitution, Product Overview, design documents, spec §9 |

This repository does not yet contain `.nvmrc`, `package.json`, or a lockfile. The first scaffold
must create all three together on Node.js 26.

## Setup

```bash
nvm use                 # reads the approved .nvmrc
npm ci                  # must not rewrite package-lock.json
npm run dev             # local development server
```

Expected: install succeeds from the committed lockfile; the dev server serves the shell without
uncaught runtime errors; no backend, API, or external service is required.

## Canonical checks

Run each gate individually, then in sequence:

```bash
npm run lint
npm run format:check
npm run typecheck
npm run test
npm run build
```

Expected outcomes:

| Gate | Expected |
| --- | --- |
| `lint` | ESLint, zero warnings |
| `format:check` | Prettier check passes |
| `typecheck` | No-emit strict compilation passes, including config files |
| `test` | Vitest + RTL pass; coverage ≥ 80% global; zero unexpected console output or rejections |
| `build` | `vite build` emits static assets to `dist/` |

A green run means each tool actually executed. A skipped gate is not a pass.

## Negative checks (prove the gates are real)

Apply one deliberate violation at a time in a throwaway change, run the corresponding gate, and
confirm a non-zero exit. Revert immediately.

1. Lint: unused variable or explicit `any` → `lint` fails.
2. Format: misformat a `.tsx` file → `format:check` fails.
3. Type: assign a string to a `number` → `typecheck` fails.
4. Test: break an assertion → `test` fails; add a stray `console.warn` → `test` fails; add a
   throwaway uncovered module (or disable enough covered tests) to force coverage below 80 → `test`
   fails the threshold rather than reporting lower coverage silently.
5. Build: introduce a syntax/import error → `build` fails.

Run these sequentially in one working tree and revert each probe before the next; a probe left in
place can make an unrelated gate fail. Do not commit any of these.

## Functional validation

| Check | How | Expected |
| --- | --- | --- |
| Shell renders | Open the dev server | One `main` landmark containing one H1 "Walfolio"; no header, nav, footer, link, button, or input |
| Document language | Inspect the document | `<html lang="en">` |
| Text externalized | Search `src/` for "Walfolio" | Appears only in the translation resource and tests, not in components; the static `index.html` `<title>` is the documented metadata exception |
| Token source | Inspect `src/app/styles/tokens.css` | Every category and every documented token name in `contracts/tokens.md` present with provenance comments, including reference-only tokens; no other global token file |
| Tokens consumed | Inspect shell styling | Semantic tokens/utilities only; no raw hex/arbitrary values |
| i18n readiness | Inspect `src/shared/i18n/en.ts` | Typed, namespaced, descriptive keys; no i18n dependency |
| Boundaries | Review imports | `app → pages → shared` only; alias used; no empty layers |

## Accessibility validation

Automated:

- `npm run test` includes axe-core assertions against the rendered shell and the styles-contract
  test. Confirm the results show no violations, the disabled `color-contrast` rule is explained in
  the test/README, and the token/global-style invariants pass.

Manual (record results in the PR):

1. Tab through the page: no focus stop is exposed. Record this as "no focusable element exists",
   not as a passed focus test.
2. Confirm the shared focus-visible style is defined and would not be clipped.
3. Toggle OS reduced-motion: no non-essential motion occurs.
4. Confirm no color-only meaning exists.
5. Confirm no WCAG 2.2 AA or conformance claim appears anywhere.
6. Note that contrast for a text-bearing teal primary button remains open (D-006).

## Responsive validation

At 375, 768, 1024, 1280, and 1440 px:

- No horizontal scrolling or clipped content.
- Content remains readable with a single column at the narrowest width.
- 1440 px container behavior is consistent with the documented approximation, not claimed as
  final fidelity.
- Record screenshots if available; state clearly that tablet/mobile are Proposed adaptations.

## Governance validation

| Check | Expected |
| --- | --- |
| Deferred decisions | No router, rendering strategy, SSG, i18n lib, hosting, analytics, or backend present |
| Content honesty | No portfolio sections, lorem ipsum, invented metrics, testimonials, or "coming soon" |
| Docs | `README.md` documents setup/commands/hooks/app-at-root; `docs/ci.md` reflects the scaffolded state and axe-core as dev-only; ADR exists |
| Unchanged governance | `AGENTS.md`, constitution, Product Overview, and `docs/design/*` untouched (except an approved token change) |
| Dependencies | Every dependency justified in the plan inventory; no extra runtime package |
| Secrets | No secret, token, or tracking script committed |

## CI validation

After pushing the branch (only with user authorization):

- `Branch name validation`, `Commit message validation`, and `Detect application` pass.
- `Detect application` reports `present=true`.
- `Application checks` executes install, lint, format, typecheck, test, build — not skipped.
- No new workflow or gate appears.

## Definition of done

All five canonical scripts pass locally and in CI, tests cover the shell contract, coverage is at
least 80%, no unexpected console output occurs, manual accessibility and responsive checks are
recorded, documentation and ADR are updated, and no deferred decision was silently resolved.
