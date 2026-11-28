# Phase 1 Data Model: Portfolio Foundation

**Feature**: `001-portfolio-foundation` | **Date**: 2026-11-28

The foundation introduces no product data entities and no persistence. It defines the governance
structures that later specifications consume. Fields are documentation-level; none is serialized.

## 1. Design Token

A named visual value with a documented category, value, and evidence status. It is declared in
`src/app/styles/tokens.css` and defined authoritatively in `docs/design/design-system.md`.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `name` | string | yes | Design-system token name, e.g. `color.teal-primary`, `type.h2`, `layout.container` |
| `cssName` | string | yes | Implementation name in the token source, e.g. `--color-teal-primary`, `--text-h2` |
| `category` | enum | yes | `color`, `typography`, `spacing`, `layout`, `breakpoint`, `radius`, `border`, `shadow`, `surface` |
| `value` | string | yes | CSS value; provisional values carry the same literal until calibrated |
| `status` | enum | yes | `Verified`, `Approx.`, `Proposed`, `Open`, `reference-only` |
| `source` | string | yes | Section of `design-system.md` that defines it |
| `used` | boolean | yes | Whether the foundation consumes it; reference-only tokens are declared but unused |
| `notes` | string | no | Calibration or open-item reference (e.g. OI-01, OI-15) |

**Relationships**: A token may back zero or more semantic surface/border mappings. Surface tokens
(`surface.section-light`, etc.) reference color tokens. Breakpoint tokens group the responsive
contract.

**Validation rules** (from FR-019–FR-031, FR-056, FR-060, AC-007–AC-013, AC-042–AC-047):

- Every documented category is represented; each token name is traceable to the design-system
  document.
- No token is declared outside the single governed source; `shared` holds none.
- `status` is preserved verbatim; a provisional token is never documented or described as
  verified.
- Verified values are not altered; any change updates `design-system.md` first and stays
  provisional until approved.
- Reference-only tokens are declared but do not generate components or imply omitted sections.
- `color.teal-primary` remains `Open` for white-text use; no text-bearing primary action is built.
- Breakpoints are `Proposed`: mobile `< 768px`, tablet `768–1279px`, desktop `≥ 1280px`. Tablet and
  desktop are `@theme` min-width tokens; the mobile upper bound is recorded as
  `--breakpoint-mobile-max` because Tailwind's mobile range is the default.
- `layout.container-fluid` is represented with the fluid `--layout-gutter`; the mobile type sizes
  `type.h1.mobile` and `type.h2.mobile` are represented as Proposed text tokens.
- Shadow values remain `Proposed`/`Open`; typography weights remain `Approx.`.

**Status lifecycle**:

```text
Proposed/Approx. ──(visual validation, owner approval)──> Verified
Open ──(owner decision)──> Proposed or Verified
Verified ──(approved change, design doc updated first)──> Verified (new value)
```

No transition is performed by this foundation; all transitions require owner approval and a
design-document update.

## 2. Quality Gate

A canonical command that must produce a real pass or fail result.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `script` | string | yes | `lint`, `format:check`, `typecheck`, `test`, `build` |
| `command` | string | yes | Actual tool invocation in `package.json` |
| `tool` | string | yes | Real validation tool (ESLint, Prettier, tsc, Vitest, Vite) |
| `failsOn` | string | yes | The failure class the gate must detect |
| `coverageThreshold` | object | no | Present only for `test`: 80% lines/statements/functions/branches |
| `invokedBy` | list | yes | Local pre-push hook and CI application job |

**Validation rules** (FR-032–FR-043, AC-019–AC-028):

- Every canonical script exists and invokes a real tool; no echoing, skipping, or unconditional
  zero exit.
- `lint` tolerates zero warnings; `format:check` uses Prettier check mode.
- `typecheck` runs no-emit strict compilation; `build` fails on build errors.
- `test` enables coverage and enforces 80% globally; the 90% critical threshold is not enforced.
- Hooks and CI invoke the same scripts without duplicated logic and without bypass.
- `prepare` installs Husky.

**State machine**:

```text
declared ──run──> pass | fail
fail ──fix cause──> pass        (never: bypass, --no-verify, lowered threshold)
```

## 3. Owner Decision

An unresolved choice that blocks part of implementation until approved. Mirrors spec Section 9
and the constitution's Deferred Decisions Register. No storage.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | string | yes | `D-001` … `D-009` |
| `decision` | string | yes | The choice to be made |
| `state` | enum | yes | `Open`, `Resolved` (with date), `Blocking` |
| `blocks` | list | yes | Implementation areas that cannot proceed |
| `handling` | string | yes | What the foundation does meanwhile |
| `approval` | string | no | Owner approval reference when resolved |

**Instances relevant to the plan**:

| ID | State | Blocks | Handling |
| --- | --- | --- | --- |
| D-001 Node.js version | Resolved 2026-11-28 — Node.js 26 LTS | — | Pin `26` in `.nvmrc`; generate the lockfile on Node.js 26 |
| D-002 Rendering strategy | Open | Final routes/metadata | Vite development/build only; no rendering claim |
| D-003 Router | Open | Navigation architecture | No router |
| D-004 i18n library/Spanish | Open | Translation runtime/switcher | English resource only |
| D-005 Inter assets/licensing | Open | Final typography | Documented fallback, no asset |
| D-006 Teal contrast | Open | Text-bearing primary action | Token documented; action absent |
| D-007 axe-core tooling | Resolved 2026-11-28 | — | Assertions implemented |
| D-008 Critical modules/90% | Open | 90% threshold | Enforce 80% only |
| D-009 Section order | Open | Portfolio sections | No sections |

**Validation rules**: An `Open` decision (FR-075, AC-049) must not be silently resolved; resolution
requires recorded owner approval. D-001 is resolved as Node.js 26 LTS (`docs/decisions/D-001-nodejs-version.md`);
scaffolding must pin `26` and must not substitute another major line.

## 4. Translation Resource

The structured English text store that keeps user-facing copy out of components.

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `locale` | string | yes | `en` (default and fallback) |
| `namespace` | string | yes | Interface area, e.g. `home` |
| `key` | string | yes | Descriptive key, e.g. `home.title` |
| `value` | string | yes | English text |
| `type` | string | yes | `Messages` type derived from the resource for compile-time key checking |

**Validation rules** (FR-055, AC-031, AC-032):

- All foundation user-facing rendered copy is externalized; no hardcoded copy in components.
- The static `index.html` `<title>` is the single documented metadata exception: it contains only
  the confirmed Walfolio name, is not component copy, and is replaced when D-002 is resolved.
- Keys are descriptive and namespaced; the fallback locale is English.
- Exactly one H1 string exists for the shell, using the confirmed Walfolio name.
- No Spanish content, switcher, or i18n dependency is introduced.

**Layout**:

```text
shared/i18n/en.ts
└── home
    └── title: "Walfolio"
```

## 5. Foundation Shell (view contract, not an entity)

Not persisted data, but the only rendered structure and therefore a review unit.

| Property | Rule |
| --- | --- |
| Landmarks | Exactly one `main` |
| Headings | Exactly one `h1` |
| Absent elements | No `header`, `nav`, `footer`, links, buttons, inputs, or other focusable controls |
| Language | Document `lang="en"` |
| Text source | Translation resource; the static `<title>` is the documented metadata exception |
| Layout | Token-driven; no horizontal overflow at approved widths; no fixed heights |
| Motion | No decorative/autoplaying motion; reduced-motion respected |
| Metadata | Minimal title only; description/canonical/OG/structured data deferred (D-002) |

**Validation**: covered by `HomePage.test.tsx`, the document contract test, axe-core, and manual
width/focus checks. Absence of focus stops is recorded as vacuous, not as verified focus behavior.
