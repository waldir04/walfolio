# Feature Specification: Portfolio Foundation

**Feature Branch**: `feat/001-portfolio-foundation`

**Created**: 2026-11-28

**Status**: Ready for implementation (D-001 resolved)

**Input**: User description: "Create a specification for the initial technical and visual foundation of Walfolio: application initialization with the approved stack, FSD-lite structure, design tokens, quality tooling, accessibility and responsive foundations, testing, and documentation, without implementing portfolio content or deferred architectural decisions."

## 1. Purpose and Scope

This specification defines the foundation required before any portfolio section or product page is implemented. It establishes a working application, the approved engineering stack, the design-token layer, the architecture boundaries, the quality gates, and the accessibility and responsive baselines.

The foundation exists so that later section specifications can add content and UI without renegotiating architecture, visual values, tooling, or quality standards. It does not deliver the Walfolio homepage or Wal product pages.

### 1.1 What this foundation delivers

- A runnable application at the repository root using the approved stack.
- A reduced Feature-Sliced Design structure with review-verifiable module boundaries.
- A single source of truth for design tokens, faithful to the Airfolio reference and governance status.
- The canonical quality scripts, local hooks, and CI-compatible application checks.
- Semantic, keyboard-operable, reduced-motion-aware, and responsive foundations.
- Smoke tests, documented setup, and architectural decision records for durable decisions.

### 1.2 What this foundation does not deliver

- Portfolio sections, hero, experience, skills, About, Wal ecosystem content, contact section, or footer content.
- Card/content grids, split text/media layouts, or any section that could exercise four-to-two-to-one reflow.
- Walday or Walplay product detail pages.
- Final page routes, final SEO metadata, or a selected rendering strategy.
- A router, SSG tool, i18n library, hosting, deployment, or preview workflow.
- Backend, API, database, CMS, authentication, contact form, analytics, or tracking.
- Final visual fidelity validation of Airfolio sections, because those sections do not exist yet.

## Clarifications

### Session 2026-11-28

- Q: What must the minimal foundation shell actually render in this phase? → A: One `main` landmark with a single H1 using the confirmed Walfolio name; no header, navigation, footer, or interactive controls; skip link and target-size criteria apply only once real navigation or controls are introduced.
- Q: Should the foundation enforce layer boundaries with automated lint rules, or verify them only in review as Constitution Principle IV requires? → A: Review-only; no boundary-enforcement rule or plugin is added, the path alias is configured for use, and layer compliance is verified in review, matching Principle IV.
- Q: Which Node.js version is approved for the foundation? → A: Node.js 26 LTS, approved by the owner on 2026-11-28 in `docs/decisions/D-001-nodejs-version.md`; `.nvmrc` pins the `26` major line when scaffolding begins. The approval was a separate owner decision, not a selection made by this specification.
- Q: Where should the single governed token source live in the FSD-lite structure? → A: One `app/styles/tokens.css` using Tailwind CSS v4 `@theme` plus semantic custom properties, imported once at bootstrap; the `shared` layer owns no global token definitions.
- Q: How should the foundation handle automated accessibility checking? → A: Add axe-core assertions to the Vitest suite now, documented as development-only tooling per Principle XIII, and keep the manual keyboard and focus verification.
- Q: Does the static `<title>` in `index.html` violate the requirement to externalize all user-facing text? → A: No. The document title is the single documented metadata exception: it is a static pre-bootstrap value derived from the confirmed Walfolio name, is not component copy, and moves to the rendering/metadata solution when D-002 is resolved.
- Q: Do the card/content grid reflow requirements apply to this foundation? → A: No. The shell contains no grid or split layout, so four-to-two-to-one reflow cannot be exercised or accepted here; the foundation supplies the breakpoint and gutter tokens, and the reflow criteria bind the first section specification that introduces such a layout.

## 2. Evidence and Decision Status

This specification preserves the status vocabulary used by the governing documents:

- **Confirmed**: required by the owner request, the Product Overview, or the constitution.
- **Verified**: supported by the exported Airfolio references.
- **Proposed**: an approved Walfolio adaptation that remains provisional.
- **Approx.**: estimated from the reference and not an exact measurement.
- **Open**: undecided and requiring owner approval.

Where a requirement depends on a provisional value, the value and its status are preserved in the token source; no requirement converts it into verified fidelity. Requirements derived from deferred architectural decisions are excluded and listed in Section 9.

## 3. User Scenarios & Testing *(mandatory)*

### User Story 1 - Initialize and run the foundation (Priority: P1)

As the owner-maintainer, I can obtain a clean checkout, install the approved dependencies, start the application locally, and produce a production build using one documented toolchain, so that later portfolio work starts from a working and reproducible base.

**Why this priority**: Nothing else can be delivered or validated until the repository contains a working application that satisfies the existing CI application gate.

**Independent Test**: From a clean checkout with the approved Node.js version installed, run the documented install, development, and build commands. The application serves a shell, the build succeeds, and no backend or external service is required.

**Acceptance Scenarios**:

1. **Given** a clean checkout and the approved Node.js version, **When** dependencies are installed from the committed lockfile, **Then** installation completes without errors and the lockfile is not rewritten.
2. **Given** installed dependencies, **When** the documented development command runs, **Then** the application is reachable locally and renders its foundation shell without uncaught runtime errors.
3. **Given** installed dependencies, **When** the production build runs, **Then** it completes successfully and emits static application assets without requiring a server, API, or database.
4. **Given** the initialized repository, **When** the stack is inspected, **Then** it uses React 19, strict TypeScript, Vite, and Tailwind CSS 4, with no additional application framework.

---

### User Story 2 - Apply the design, accessibility, and responsive foundation (Priority: P2)

As the owner-maintainer, I can consume the documented Airfolio tokens and foundational accessibility behavior from one governed source, so that later sections preserve the reference visual language and can be made accessible and responsive without redefining values.

**Why this priority**: The foundation is the only opportunity to establish token governance and accessibility behavior before UI accumulates. Retrofitting either is costly and risks visual drift.

**Independent Test**: Inspect the token source and render the foundation shell. Every documented token category has a semantic representation with its provenance status in `app/styles/tokens.css`. The shell exposes exactly one `main` landmark and one H1, the document language is set, the shared styling layer defines visible focus-visible and reduced-motion behavior, and the layout does not overflow horizontally at the approved validation widths.

**Acceptance Scenarios**:

1. **Given** the design-system document, **When** the token source is reviewed, **Then** every documented color, typography, spacing, layout, breakpoint, radius, border, shadow, and surface token is represented with its status and no token is silently changed.
2. **Given** a component or style in the foundation, **When** its visual values are inspected, **Then** it references semantic tokens rather than arbitrary colors, spacing, radii, or shadows, except for documented structural values or an approved exception.
3. **Given** the foundation shell, **When** it is traversed using only a keyboard, **Then** no focus stop is exposed because the shell renders no interactive element, and this absence is recorded instead of being reported as verified focus behavior.
4. **Given** the foundation shell at each approved validation width, **When** the page is inspected, **Then** no horizontal scrolling is introduced by the foundation layout.
5. **Given** the operating system reduced-motion preference, **When** the shell renders, **Then** non-essential motion is suppressed or absent.

---

### User Story 3 - Extend the application within clear boundaries (Priority: P3)

As a contributor or implementation agent, I can add a page, feature, or shared primitive in a predictable location and have imports, types, formatting, and review verify the agreed boundaries, so that the codebase stays small, consistent, and reviewable.

**Why this priority**: The foundation must prevent architectural drift before multiple contributors or agents add sections. Boundary clarity is cheaper now than after the page exists.

**Independent Test**: Add a temporary, non-committed probe module that imports across a boundary and confirm the review process flags it as a violation; then verify that a correctly placed module passes every configured check. Remove the probe afterward. No automated boundary-enforcement rule participates in this check.

**Acceptance Scenarios**:

1. **Given** the application structure, **When** layers are inspected, **Then** only layers with real responsibilities exist; no empty `features`, `entities`, or `widgets` layer is created to satisfy a diagram.
2. **Given** any module import, **When** the dependency direction is reviewed, **Then** imports flow downward only and no lower layer imports from a higher layer.
3. **Given** a deep relative import that climbs directories, **When** the change is reviewed, **Then** the import is flagged as a boundary violation; **And** no automated boundary-enforcement rule or plugin is expected to catch it.
4. **Given** a new shared module, **When** its content is reviewed, **Then** it contains no page-specific composition or business rule.
5. **Given** an application function or React component, **When** it is reviewed, **Then** it follows the constitution's function-syntax, prop-typing, and component-responsibility rules.

---

### User Story 4 - Verify quality locally and in CI (Priority: P4)

As a reviewer, I can run the canonical quality commands locally and observe the same checks in CI, so that a green result proves the foundation was actually linted, formatted, type-checked, tested, and built rather than skipped.

**Why this priority**: The repository already defines quality gates. The foundation must activate them without weakening them or introducing placeholder commands.

**Independent Test**: Run each canonical script individually and then the full pre-push sequence. Push a branch and confirm the CI application job is detected and runs the same steps. Compare outputs to confirm no check is skipped or replaced by a success message.

**Acceptance Scenarios**:

1. **Given** the initialized application, **When** `lint`, `format:check`, `typecheck`, `test`, and `build` run, **Then** each invokes a real tool and exits successfully.
2. **Given** a deliberately introduced lint, formatting, type, test, or build failure, **When** the corresponding gate runs, **Then** it fails with a non-zero exit status.
3. **Given** the repository is pushed or a pull request is opened, **When** CI runs, **Then** application detection reports the application as present and the application checks execute instead of being skipped.
4. **Given** a test run, **When** an unexpected `console.warn`, `console.error`, or unhandled promise rejection occurs, **Then** the test suite fails.
5. **Given** the local hooks, **When** a commit or push is attempted with a violation, **Then** the configured hook blocks it without bypassing the check.

---

### User Story 5 - Review the foundation without hidden decisions (Priority: P4)

As the owner or reviewer, I can distinguish confirmed requirements from provisional values and unresolved decisions in one place, so that the foundation does not silently harden deferred architecture or design choices.

**Why this priority**: The constitution prohibits resolving deferred decisions through implementation convenience. A foundation that quietly selects a router, rendering strategy, Node.js version, or contrast fix would contaminate every later specification.

**Independent Test**: Review the specification, token provenance, dependency inventory, and ADR. Every deferred decision is either absent from the implementation or recorded as an owner decision with its approval state. No provisional token is presented as verified.

**Acceptance Scenarios**:

1. **Given** the implementation, **When** dependencies and configuration are inspected, **Then** no router, rendering strategy, SSG tool, i18n library, hosting configuration, analytics, or backend is introduced.
2. **Given** an unresolved design value, **When** it is used, **Then** it is traceable to its `Approx.`, `Proposed`, or `Open` status and is centrally changeable.
3. **Given** a durable architectural choice made during initialization, **When** the documentation is reviewed, **Then** the choice is recorded in an ADR with its context and consequences.
4. **Given** the unresolved primary teal contrast issue, **When** the foundation is reviewed, **Then** no final text-bearing primary button or accessibility-conformance claim has been introduced.

---

### Edge Cases

- `.nvmrc` or `package-lock.json` is missing while `package.json` exists: CI's detection job fails. The foundation must never create that state, even transiently in the delivered branch.
- Node.js 26 LTS is approved but not installed locally: install the approved line with `nvm install 26` before scaffolding; do not substitute another LTS or copy a version from another project.
- Inter font files are unavailable or unlicensed for self-hosting: the application uses a documented fallback without adding an unapproved font service or dependency, and records the deviation.
- A token remains `Approx.` or `Proposed`: it is implemented centrally as provisional, not described as verified, and can be recalibrated without touching component code.
- The unresolved teal primary contrast is needed for a text-bearing action: the action is not finalized in the foundation; the conflict remains open.
- The application shell has no portfolio sections and no navigation: it still exposes exactly one `main` landmark and one H1, and it does not simulate missing sections or links with placeholders.
- No approved icon, logo, favicon, or decorative asset exists: the foundation omits or clearly marks them as unavailable; it does not fabricate brand assets.
- Tests produce unexpected console output: the suite fails rather than suppressing the output.
- Coverage falls below the enforced global threshold: the gate fails; thresholds are not lowered to make the pipeline pass.
- A proposed responsive layout causes horizontal overflow or clipped focus rings: the layout is corrected; the overflow is not hidden globally.
- A contributor needs a layer that has no real content: the layer is not created until a real responsibility justifies it.
- The CI application job was previously skipped and the team assumes quality: after scaffolding, a skipped application job is treated as not validated, not as a pass.

## 4. Requirements *(mandatory)*

### 4.1 Application Initialization and Approved Stack

- **FR-001**: The application MUST live at the repository root and MUST NOT introduce `frontend/` or `backend/` directories.
- **FR-002**: The application MUST use React 19, TypeScript with strict type checking, Vite, and Tailwind CSS 4 as the approved stack. No additional application framework or meta-framework may be introduced.
- **FR-003**: The application MUST use npm with a committed `package-lock.json`, because the existing CI installs with `npm ci`.
- **FR-004**: The repository MUST contain a root `.nvmrc` that pins the owner-approved Node.js 26 LTS major line (`26`). The approval is recorded in `docs/decisions/D-001-nodejs-version.md` and resolves the constitution's DEF-17. The version MUST NOT be copied from another project, and any change to the approved major line requires a new documented owner decision.
- **FR-005**: `package.json`, `package-lock.json`, and `.nvmrc` MUST exist together in the delivered state. CI MUST never observe `package.json` without the other two.
- **FR-006**: The application MUST remain a static presentation surface. It MUST NOT add a backend, custom API, database, CMS, authentication, contact form, analytics, or tracking.
- **FR-007**: Initialization MUST NOT select or encode a rendering strategy, router, SSG tool, or i18n library. The foundation MAY expose a single development entry without route configuration, and MUST NOT finalize routes or production metadata.
- **FR-008**: The production build MUST be reproducible from the committed lockfile and MUST NOT depend on secrets or external runtime services.

### 4.2 Project Structure and Architecture Boundaries

- **FR-009**: The application MUST follow the constitution's FSD-lite layers: `app`, `pages`, `features`, and `shared`. `entities` and `widgets` MAY be introduced only when a real domain model or repeated composition justifies them.
- **FR-010**: Empty layers, folders, or files MUST NOT be created. If the foundation needs only `app`, `pages`, and `shared`, `features`, `entities`, and `widgets` MUST be absent.
- **FR-011**: `app` MUST hold only application composition, providers, global configuration, and bootstrap concerns.
- **FR-012**: `pages` MUST compose page-level structure. The foundation MUST contain exactly one minimal shell page and MUST NOT contain portfolio sections. The shell MUST render one `main` landmark holding a single H1 with the confirmed Walfolio name, and MUST NOT render a header, navigation, footer, or interactive control.
- **FR-013**: `shared` MUST contain only reusable UI primitives, utilities, configuration, and infrastructure adapters. It MUST NOT contain business rules, page-specific composition, or global design-token definitions; those belong to `app/styles/tokens.css`.
- **FR-014**: `features` MUST be introduced only for a real user interaction or use case. The foundation MUST NOT create an empty or speculative feature slice.
- **FR-015**: Imports MUST flow downward only. Lower layers MUST NOT import from higher layers, and slices at the same layer MUST communicate through public APIs.
- **FR-016**: A configured path alias MUST be used instead of deep relative imports that climb directories. Per Constitution Principle IV, automated boundary enforcement is NOT part of this foundation: no boundary-enforcement plugin, tool, or dedicated lint rule is added, and layer-direction and alias compliance are verified in review.
- **FR-017**: Tests MUST be colocated with their subject or mirrored without breaking layer boundaries.
- **FR-018**: The foundation MUST NOT create placeholder components that pretend to be finished portfolio features, sections, or product pages.

### 4.3 Design Foundation and Token Governance

- **FR-019**: The application MUST implement the documented token categories from `docs/design/design-system.md`: colors, typography, spacing, layout, breakpoints, radii, borders, shadows, and surface mappings. They MUST live in one governed source, `app/styles/tokens.css`, expressed as Tailwind CSS v4 `@theme` values plus semantic custom properties and imported once at bootstrap. Token names MUST remain traceable to the design-system document.
- **FR-020**: Every token MUST retain its evidence status: `Verified`, `Approx.`, `Proposed`, or reference-only. Components and documentation MUST NOT present provisional values as verified.
- **FR-021**: Components MUST consume semantic tokens. Arbitrary visual values that bypass the token system are prohibited unless a documented, reviewed exception exists. Structural values such as `0`, `100%`, `auto`, and grid fractions are permitted.
- **FR-022**: Verified token values MUST NOT be silently changed. Any necessary change MUST update `docs/design/design-system.md` first and remain provisional until approved.
- **FR-023**: The foundation MUST NOT introduce Walday, Walplay, or any other product palette as a replacement for the Airfolio palette.
- **FR-024**: Reference-only tokens may be represented in the token registry but MUST NOT generate unused components or imply that omitted Airfolio sections exist.
- **FR-025**: Typography MUST expose the documented Inter family token and type scale. Font loading MUST use appropriate fallback behavior to limit layout shift. No unapproved font asset, font service, or font dependency may be added.
- **FR-026**: The layout layer MUST expose the documented container, wide-media, header-height, section-padding, and grid-gap tokens. The wide-media behavior MUST allow media to extend beyond the primary container without inventing a new verified width.
- **FR-027**: The spacing, radius, shadow, and approximate layout values MUST be centralized in `app/styles/tokens.css` as provisional tokens so they can be recalibrated during later visual validation without editing components.
- **FR-028**: The proposed breakpoints MUST be implemented as tokens: mobile below 768 px, tablet from 768 px to 1279 px, and desktop at 1280 px and above. They are Proposed adaptations, not verified reference behavior.
- **FR-029**: Reusable primitives MUST be created only when the foundation shell or repeated usage justifies them. The foundation MUST NOT build a speculative full component library.
- **FR-030**: The foundation MUST establish focus-visible styling and reduced-motion behavior at the shared styling layer so later components inherit consistent behavior.
- **FR-031**: The unresolved primary teal contrast issue (`color.teal-primary` with white text at approximately 4.1:1) MUST remain documented as Open. The foundation MUST NOT finalize a text-bearing primary button or declare an accessibility exception.

### 4.4 Quality Tooling and Canonical Scripts

- **FR-032**: `package.json` MUST expose the canonical scripts `lint`, `format:check`, `typecheck`, `test`, and `build`. It MUST also provide `prepare` for Husky installation.
- **FR-033**: Each canonical script MUST invoke a real validation tool. Scripts that only echo success, skip checks, or always exit zero are prohibited.
- **FR-034**: `lint` MUST run ESLint across the application with zero warnings tolerated. `format:check` MUST run Prettier in check mode.
- **FR-035**: `typecheck` MUST run the TypeScript compiler in no-emit mode with the strict configuration. `build` MUST run the production build and MUST fail on errors.
- **FR-036**: `test` MUST run Vitest with React Testing Library and coverage enabled, enforcing the initial 80% global threshold. The proposed 90% critical-module threshold MUST NOT be enforced until critical modules are approved.
- **FR-037**: The test environment MUST use the CI-approved DOM environment (`jsdom`) and testing utilities (`@testing-library/*`) plus axe-core for automated accessibility assertions. axe-core MUST be documented as development-only tooling per Principle XIII. Tests MUST NOT perform real network calls.
- **FR-038**: The test suite MUST fail on unexpected `console.warn`, `console.error`, and unhandled promise rejections. Globally silencing console output to make tests pass is prohibited.
- **FR-039**: ESLint MUST reject explicit `any`, unsafe compiler suppressions, and project-rule violations. Type assertions and non-null assertions MUST be limited to validated boundaries and justified.
- **FR-040**: The existing Husky hooks MUST remain functional: pre-commit runs staged formatting and linting, commit-msg validates Conventional Commits, and pre-push runs the full canonical script contract.
- **FR-041**: Existing hook, lint-staged, and commitlint configuration MUST NOT be replaced or weakened. Changes are permitted only when required for compatibility, must preserve or strengthen the check, and must be documented.
- **FR-042**: The foundation MUST NOT bypass or disable hooks, CI, or required checks. `--no-verify` and equivalent bypasses are prohibited without explicit user authorization.
- **FR-043**: A dependency inventory MUST justify every added dependency against the approved stack, existing CI tooling, license, security posture, and bundle impact. Unapproved runtime dependencies are prohibited.

### 4.5 Accessibility Foundation

- **FR-044**: The foundation shell MUST use semantic HTML with a logical document structure and the correct document language. It MUST expose exactly one `main` landmark and one H1, and no landmark that has no real content to contain.
- **FR-045**: Every interactive element MUST be keyboard operable, have a meaningful accessible name, and follow a logical focus order. No keyboard trap may exist.
- **FR-046**: A visible focus indicator MUST be provided for all focusable elements and MUST NOT be obscured by overflow clipping, decorative shapes, or layout transitions. Because the foundation shell renders no focusable element, the shared styling layer MUST define the focus-visible treatment that later components inherit (FR-030).
- **FR-047**: When the application later contains repeated navigation blocks, a bypass mechanism such as a skip link MUST be provided. Because the foundation shell renders no navigation, a bypass mechanism is NOT required now, and the first change that introduces repeated navigation MUST add one.
- **FR-048**: Meaningful images MUST have appropriate alternative text. Decorative elements MUST be hidden from assistive technology.
- **FR-049**: Status, errors, and state MUST NOT be communicated by color alone. The foundation MUST NOT introduce color-only meaning.
- **FR-050**: Interactive targets MUST meet a minimum 44 × 44 px target area. The foundation shell renders no interactive element, so this requirement binds the first interactive components introduced later; the shell MUST NOT gain controls merely to exercise it.
- **FR-051**: Motion MUST respect `prefers-reduced-motion`. The foundation MUST NOT introduce autoplaying or decorative motion that ignores the preference.
- **FR-052**: The foundation MUST use documented token pairs whose contrast is already assessed. Unresolved contrast values MUST NOT be used as final text-bearing surfaces.
- **FR-053**: The foundation MUST NOT claim WCAG 2.2 AA or any formal conformance level. Accessibility status MUST describe the implemented baseline only.
- **FR-054**: Automated accessibility assertions MUST run in the Vitest suite through axe-core, documented as development-only tooling. Manual keyboard and focus verification MUST also be performed and recorded; automated assertions do not replace it.
- **FR-055**: All foundation user-facing rendered copy MUST be externalized into structured English translation resources, with descriptive keys, so Spanish can be added later without structural rework. The static `index.html` `<title>` is the single documented metadata exception: it carries only the confirmed Walfolio name, is not component copy, and is replaced when the deferred rendering/metadata decision (D-002) is resolved. The i18n library and Spanish depth remain deferred.

### 4.6 Responsive Foundation

- **FR-056**: The responsive strategy MUST be mobile-first, token-driven, and based on the proposed breakpoints. It MUST use fluid gutters and appropriate fluid typography rather than fixed desktop pixel copies.
- **FR-057**: Card and content grid patterns introduced by later sections MUST be capable of reflowing from four columns to two columns to one column as width decreases, and split layouts MUST stack when the text measure can no longer be supported. The foundation itself contains no grid or split layout; it MUST provide the breakpoint and gutter tokens that make this reflow possible, and the reflow behavior is accepted in the first section specification that introduces it.
- **FR-058**: Later responsive sections MUST preserve section order, band rhythm, and hierarchy. Sections MUST NOT be hidden merely to make a layout fit. The foundation cannot exercise this requirement because it renders no sections; the token and layout foundations it provides must not preclude it.
- **FR-059**: Fixed card and content heights MUST NOT be used. Container behavior MUST tolerate text expansion, including future Spanish copy.
- **FR-060**: The foundation layout MUST be verified at 375 px, 768 px, 1024 px, 1280 px, and 1440 px. The 1440 px view is compared with the reference container behavior; the other widths are Proposed adaptation checks.
- **FR-061**: No horizontal overflow may be introduced at any approved validation width. Overflow MUST NOT be masked globally to hide a layout defect.
- **FR-062**: Tablet and mobile behavior MUST be documented as Proposed adaptations, not as verified source designs.

### 4.7 Testing and Documentation

- **FR-063**: The test suite MUST include foundation smoke tests covering: the application renders, the shell exposes exactly one `main` landmark and its single H1, the document language is set, no navigation or interactive control is rendered, and the render emits no unexpected console output or rejection.
- **FR-064**: Accessibility-relevant behavior MUST be tested through roles, accessible names, and keyboard interaction where testable. Visual focus appearance requires manual verification and MUST be recorded.
- **FR-065**: Coverage configuration MUST be committed and enforced by the `test` script. Coverage thresholds MUST NOT be lowered merely to make CI pass.
- **FR-066**: Durable foundation decisions MUST be recorded in an ADR, including the approved stack, the token-source strategy, the FSD-lite boundaries, the deferred rendering/router/i18n decisions, the Node.js version approval, and the testing threshold decision.
- **FR-067**: Repository developer documentation MUST describe the approved Node.js version, install, development, build, and canonical validation commands, hook behavior, and the application-at-root constraint.
- **FR-068**: `docs/ci.md` MUST be updated from "application not scaffolded" to the real scaffolded state, including the application detection and check behavior, and its tooling list MUST record axe-core as development-only accessibility tooling. No governance document may be rewritten to accommodate implementation convenience.

### 4.8 Governance and Regression Constraints

- **FR-069**: The constitution, Product Overview, design documents, and `AGENTS.md` MUST NOT be modified as a side effect of the foundation. The only permitted exception is a token change explicitly required and approved through FR-022. Configuration and setup documentation may be updated only where this specification requires it.
- **FR-070**: Existing CI workflows, branch-name validation, commit-message validation, and PR source validation MUST remain in place and MUST NOT be weakened. No additional CI gates or deployment workflows may be added.
- **FR-071**: The foundation MUST NOT create `main`, configure branch protection, change required checks, or modify repository settings.
- **FR-072**: The foundation MUST NOT create deployment or hosting configuration, previews, security-header configuration, or release automation.
- **FR-073**: The foundation MUST NOT introduce portfolio copy, lorem ipsum, invented metrics, testimonials, client claims, product availability claims, or "coming soon" placeholders.
- **FR-074**: No secret, credential, sensitive environment value, tracking script, or unauthorized integration may be committed.
- **FR-075**: Open decisions listed in Section 9 MUST remain open. The implementation MUST NOT silently resolve them, and any later resolution MUST be recorded with owner approval.

## 5. Success Criteria *(mandatory)*

### 5.1 Measurable Outcomes

- **SC-001**: A new contributor can go from a clean checkout to a running application using one documented command sequence in under 10 minutes, excluding dependency download time.
- **SC-002**: 100% of the canonical quality gates (`lint`, `format:check`, `typecheck`, `test`, `build`) pass locally and in CI on the delivered foundation.
- **SC-003**: After scaffolding, CI reports application detection as present and executes the application checks; 0 application checks are skipped or reported as passed without execution.
- **SC-004**: 100% of documented token categories and documented token names are represented in the token source (including reference-only tokens), and 0 undocumented raw visual values appear in foundation components outside the token source or a documented exception.
- **SC-005**: The test suite enforces at least 80% global coverage and passes with 0 unexpected console warnings, console errors, or unhandled promise rejections.
- **SC-006**: The codebase contains 0 explicit or implicit `any` usages and 0 unjustified compiler suppressions in foundation code.
- **SC-007**: Keyboard-only traversal of the foundation shell reaches every interactive element in a logical order, with 0 keyboard traps and a visible focus state on each stop; because the shell renders no interactive element, the traversal must expose no focus stop, and this is recorded as vacuously satisfied rather than as a passed interaction test.
- **SC-008**: The foundation renders without horizontal overflow at all five approved validation widths.
- **SC-009**: 0 unapproved runtime dependencies and 0 deferred architectural choices are introduced by the foundation.
- **SC-010**: 0 changes are made to the constitution, Product Overview, design documents, or `AGENTS.md`; existing branch, commit, and PR checks remain operational.

## 6. Acceptance Criteria *(mandatory)*

The following criteria are the review gates for the foundation. Each is independently verifiable.

### 6.1 Application Initialization

- **AC-001**: A clean checkout with the approved Node.js version installs successfully from the committed lockfile without rewriting it.
- **AC-002**: The documented development command starts the application locally, and the foundation shell renders without uncaught runtime errors.
- **AC-003**: The production build completes and emits static assets without a backend, API, database, CMS, or external runtime service.
- **AC-004**: The stack is React 19, strict TypeScript, Vite, and Tailwind CSS 4, with no additional application framework.
- **AC-005**: `package.json`, `package-lock.json`, and `.nvmrc` exist at the repository root and are internally consistent.
- **AC-006**: No router, rendering strategy, SSG tool, i18n library, hosting configuration, analytics, or tracking is present.

### 6.2 Design Tokens

- **AC-007**: Every documented color, typography, spacing, layout, breakpoint, radius, border, shadow, and surface token is represented in the single governed source `app/styles/tokens.css`, with no duplicate global token definitions elsewhere.
- **AC-008**: Each token's evidence status is traceable, and no `Approx.`, `Proposed`, or `Open` item is presented as verified.
- **AC-009**: Foundation components use semantic token references; raw hex colors and arbitrary visual values are absent outside the token source or a documented exception.
- **AC-010**: No Walday, Walplay, or unrelated product palette is introduced.
- **AC-011**: The Inter family token and type scale are present, and font fallback behavior is documented without an unapproved font service or asset.
- **AC-012**: The container, header-height, section-padding, grid-gap, and breakpoint tokens are available and centrally adjustable.
- **AC-013**: The primary teal contrast issue remains documented as Open, and no final text-bearing primary button or conformance claim exists.

### 6.3 Project Structure

- **AC-014**: The application lives at the repository root, with no `frontend/` or `backend/` directories.
- **AC-015**: Only layers with real responsibilities exist; no empty `features`, `entities`, or `widgets` layer is present.
- **AC-016**: Imports flow downward only, `shared` contains no business rules, a path alias exists and is used, and no deep climbing relative import remains; this is verified in review, with 0 automated boundary-enforcement rules relied upon.
- **AC-017**: No placeholder component, fake portfolio section, or invented product page is present.
- **AC-018**: Tests are colocated or mirrored without violating layer boundaries.

### 6.4 Quality Scripts and Local Validation

- **AC-019**: `package.json` exposes `lint`, `format:check`, `typecheck`, `test`, and `build`, plus Husky's `prepare`.
- **AC-020**: Each canonical script invokes a real tool and fails on a corresponding deliberate violation.
- **AC-021**: All five canonical scripts pass in sequence from a clean checkout.
- **AC-022**: `test` runs with coverage and enforces the 80% global threshold; the 90% critical-module target is not falsely enforced.
- **AC-023**: The test suite fails on unexpected console warnings, console errors, or unhandled rejections.
- **AC-024**: The pre-commit, commit-msg, and pre-push hooks execute their configured checks without bypass.
- **AC-025**: Actual local validation results are recorded in the Pull Request description; unavailable or skipped checks are stated as such.

### 6.5 CI/CD Compatibility

- **AC-026**: CI application detection reports `present=true` when the application exists and requires `package-lock.json` and `.nvmrc`.
- **AC-027**: The CI application job executes install, lint, format check, typecheck, test, and build; it does not skip after scaffolding.
- **AC-028**: Any failing canonical check fails CI with a non-zero result.
- **AC-029**: Branch-name validation, commit-message validation, and PR source validation remain unchanged and operational.
- **AC-030**: No new workflow, deployment job, preview environment, or additional CI gate is introduced.

### 6.6 Accessibility Foundation

- **AC-031**: The foundation shell exposes exactly one `main` landmark and exactly one H1, with no header, navigation, or footer landmark rendered.
- **AC-032**: The document language is set and matches the default English experience. Rendered foundation copy comes from the typed English resource; the static `index.html` `<title>` is the only documented exception and contains only the confirmed Walfolio name.
- **AC-033**: Every interactive element is keyboard reachable in a logical order, has a meaningful accessible name, and has no keyboard trap.
- **AC-034**: The shared styling layer defines a visible focus-visible treatment that is not clipped or obscured, ready for the first focusable component; the shell exposes no focus stop, and that absence is recorded rather than treated as verified focus behavior.
- **AC-035**: The foundation shell renders no navigation, so no bypass mechanism is required yet; the first change that adds repeated navigation MUST add one that targets the main content.
- **AC-036**: Decorative elements are hidden from assistive technology; meaningful images have alternative text when present.
- **AC-037**: Reduced-motion preference is respected.
- **AC-038**: Every interactive target meets the 44 × 44 px minimum; the foundation shell renders no interactive target, which is verified as absent rather than assumed compliant.
- **AC-039**: No information is conveyed by color alone.
- **AC-040**: No WCAG 2.2 AA or formal conformance claim is made; the unresolved teal contrast remains open.
- **AC-041**: axe-core assertions execute in the Vitest suite, and manual keyboard and focus verification is recorded.

### 6.7 Responsive Foundation

- **AC-042**: No horizontal overflow occurs at 375 px, 768 px, 1024 px, 1280 px, or 1440 px.
- **AC-043**: The layout uses the proposed mobile, tablet, and desktop breakpoints and fluid gutters rather than fixed desktop widths.
- **AC-044**: The foundation provides the breakpoint and gutter tokens required for four-to-two-to-one reflow. No card/content grid or split layout exists in the foundation, so the reflow itself is not exercised here and is accepted in the first section specification that introduces it.
- **AC-045**: No fixed card or content heights prevent text expansion. The foundation renders no card or content block, so this is verified as absent for the shell and binds the first component that introduces one.
- **AC-046**: Tablet and mobile behavior is documented as Proposed, not Verified.
- **AC-047**: The 1440 px container behavior is consistent with the documented reference approximation and is not claimed as final fidelity.

### 6.8 Governance and No Regression

- **AC-048**: No dependency is added without a documented justification and approval fit.
- **AC-049**: No deferred decision is silently resolved; every unresolved item remains in Section 9 or the governing Open Items Register.
- **AC-050**: The constitution, Product Overview, design documents, and `AGENTS.md` are unchanged.
- **AC-051**: `docs/ci.md` reflects the scaffolded state accurately, and developer setup documentation matches the real commands.
- **AC-052**: No portfolio content, invented claim, lorem ipsum, placeholder marketing copy, or fake finished feature is present.
- **AC-053**: No secret, tracking script, analytics integration, or unauthorized external service is present.
- **AC-054**: The delivered change contains no unrelated files or opportunistic refactors.

## 7. Assumptions

- **A-001**: npm is the package manager because the existing CI contract uses `npm ci` and `package-lock.json`. This is a repository constraint, not a new technology decision.
- **A-002**: The owner approved Node.js 26 LTS on 2026-11-28 in `docs/decisions/D-001-nodejs-version.md`; the specification records that approval rather than selecting a version itself.
- **A-003**: The foundation renders exactly one minimal, honest shell page using only confirmed brand text: a `main` landmark with a single H1 bearing the Walfolio name. It includes no header, navigation, footer, or interactive control, is not portfolio content, and does not simulate missing sections.
- **A-004**: No approved brand, portrait, icon, font-file, or decorative assets exist. The foundation omits or clearly marks unavailable assets and does not fabricate them.
- **A-005**: The design-system token values remain the source of truth during implementation. If a token must change, the design-system document is updated first and the change remains provisional until approved.
- **A-006**: English is the default interface language. Spanish depth and language switching remain deferred, but text externalization is established now.
- **A-007**: The 375 px, 768 px, 1024 px, 1280 px, and 1440 px widths are proposed validation widths. Only 1440 px has a desktop reference; the others are adaptation checks.
- **A-008**: The 80% global coverage threshold is ratified by this foundation. The 90% critical-module target remains proposed until critical modules are identified.
- **A-009**: Automated accessibility tooling uses axe-core inside the Vitest suite, documented as development-only tooling. Semantic role and accessible-name assertions plus manual keyboard and focus verification remain part of the baseline and are not replaced by the automated engine.
- **A-010**: The foundation is not a published release. Final routes, final SEO metadata, structured data, sitemap, canonical URLs, and language alternates remain blocked by the deferred rendering decision.
- **A-011**: Existing CI workflows are authoritative and are not redesigned by this specification. The foundation adapts the application to them, not the reverse.
- **A-012**: No visual fidelity claim is made for Airfolio sections, because they are outside this foundation.
- **A-013**: Mobile-first CSS is a proposed implementation strategy for the foundation. It is not derived from the desktop-only reference; the design documents propose breakpoints and fluid layouts without prescribing a cascade order.

## 8. Key Entities

This foundation introduces no product data entities. It introduces three governance concepts used by later specifications:

- **Design Token**: a named visual value with a documented category, value, and evidence status.
- **Quality Gate**: a canonical command that must produce a real pass or fail result.
- **Owner Decision**: an unresolved choice that blocks a specific part of the implementation until approved.

## 9. Decisions Requiring Owner Approval

Open decisions in this table block the affected part of implementation and MUST NOT be resolved by assumption. They do not block writing this specification. D-001 was resolved by the owner on 2026-11-28 (Node.js 26 LTS), and D-007 was resolved by the 2026-11-28 clarification (axe-core); both are retained in the table for traceability only.

| ID | Decision | Why it is unresolved | What it blocks | Handling until approved |
| --- | --- | --- | --- | --- |
| D-001 | Node.js version and exact LTS line | Resolved 2026-11-28: the owner approved Node.js 26 LTS in `docs/decisions/D-001-nodejs-version.md`, resolving constitution DEF-17 | Nothing remains blocked; `.nvmrc` must pin `26` when scaffolding begins | Pin `26` in `.nvmrc`, generate the lockfile on Node.js 26, and install Node.js 26 locally before the first scaffold command |
| D-002 | Rendering strategy | Constitution DEF-01 defers it until SEO evaluation | Final routes, final metadata, published page behavior | Build only a development shell; do not encode rendering |
| D-003 | Router | Constitution DEF-14 defers it | Navigation architecture and page routing | No router or route configuration |
| D-004 | i18n library and Spanish depth | Constitution DEF-15 and OD-01 defer them | Translation implementation and language switcher | Externalize English text only; no i18n dependency |
| D-005 | Inter font assets and licensing | OI-13 leaves assets open | Final typography fidelity and font hosting | Use a documented fallback; no unapproved asset or service |
| D-006 | Teal primary button contrast | OI-15 / OD-06 remain open | Final text-bearing primary action | Keep the token and concern documented; do not finalize the action |
| D-007 | Automated accessibility tooling | Resolved 2026-11-28: axe-core in Vitest is approved as documented development-only tooling under Principle XIII | Nothing remains blocked; assertions are part of the `test` script | Implement axe-core assertions together with manual keyboard and focus verification |
| D-008 | Critical modules and 90% coverage | Constitution DEF-18 leaves the module list proposed | Enforcing the 90% critical threshold | Enforce 80% global only; do not invent critical modules |
| D-009 | Final section order and composition | OD-05 remains open | Any portfolio section implementation | Foundation only; no sections |

## 10. Governance Findings: Contradictions and Missing Decisions

1. **Deferred Node.js version versus required `.nvmrc`.** The constitution deferred the Node.js version, while the existing CI fails when `package.json` exists without `.nvmrc`. Resolution: the owner approved Node.js 26 LTS on 2026-11-28 (D-001), so scaffolding may pin `26` and create the lockfile together once Node.js 26 is installed locally.
2. **Deferred rendering strategy versus application initialization.** The constitution prohibits assuming a client-only SPA, while Vite initialization produces a client-rendered development build. Resolution: the foundation may use Vite for development and building, but must not add a router, route-based metadata, prerendering, or a claim about production rendering. D-002 remains open.
3. **Required i18n readiness versus deferred i18n library.** The constitution requires externalized user-facing text, but the library is deferred. Resolution: the foundation establishes structured English resources and keeps components free of hardcoded copy; it does not add a library or a language switcher.
4. **Token implementation versus unresolved values.** The design system contains `Approx.`, `Proposed`, and `Open` values, including the primary teal contrast. Resolution: provisional values are implemented centrally as provisional, and the contrast-dependent primary action is not finalized.
5. **Inter is verified as the family, but font assets are open.** Resolution: the family token is implemented with a documented fallback; no unapproved font file, service, or dependency is introduced.
6. **Coverage targets versus unidentified critical modules.** The 80% global target can be ratified now; the 90% critical target cannot. Resolution: only 80% is enforced, and the critical-module list remains proposed.
7. **Design fidelity expectations versus the absence of sections.** The foundation cannot validate section fidelity because no sections exist. Resolution: the foundation validates token availability, token governance, and shell behavior only; visual fidelity validation belongs to later section specifications.
8. **Existing `docs/ci.md` describes an unscaffolded application.** Initialization makes that statement stale. Resolution: update `docs/ci.md` to the real state without changing governance documents.
9. **The pre-commit hook fails when `package.json` is absent.** Initialization activates the hook path. Resolution: the delivered state must include dependencies, lockfile, and `.nvmrc` together, and the existing hook files must remain functional.
10. **The foundation must be reviewable without selecting deferred technology.** Resolution: Section 9 records every blocking decision, and the acceptance criteria require that none is silently resolved.
11. **User Story 3 promised lint-enforced boundaries while Principle IV defers automated boundary enforcement.** Resolution: path-alias and layer compliance are verified in review; no boundary-enforcement rule, plugin, or tool is added (FR-016, AC-016).
12. **The foundation shell was optional in FR-012 but required by the user stories and acceptance criteria.** Resolution: the foundation renders exactly one shell page — a single `main` landmark and one H1, with no header, navigation, footer, or interactive control; the skip-link and target-size criteria bind the first change that introduces navigation or controls.
13. **Automated accessibility assertions were conditional on approved tooling.** Resolution: axe-core is approved as documented development-only tooling, so AC-041 is now a binary gate instead of a conditional one.
14. **The static document title cannot come from the TypeScript translation resource before bootstrap.** Resolution: `index.html` keeps a single minimal `<title>` with the confirmed Walfolio name as the one documented metadata exception; all other rendered copy comes from `src/shared/i18n/en.ts`, and the title moves with D-002.
15. **Grid reflow requirements had no grid to exercise them.** Resolution: the foundation delivers breakpoint and gutter tokens only; four-to-two-to-one reflow and split stacking are acceptance criteria of the first later section specification that introduces a grid or split layout.

## 11. Dependencies

- **Authoritative documents**: `.specify/memory/constitution.md`, `docs/product-overview.md`, `docs/design/design-reference.md`, `docs/design/design-system.md`, `docs/design/component-inventory.md`, and `docs/design/implementation-decisions.md`.
- **Repository constraints**: `AGENTS.md`, `.github/workflows/ci.yml`, `.github/workflows/pr-source-validation.yml`, `docs/ci.md`, `.husky/*`, `.lintstagedrc.json`, and `commitlint.config.cjs`.
- **Approved development-only tooling**: `axe-core` for automated accessibility assertions, approved on 2026-11-28 (D-007) and subject to the documented dependency justification in FR-043.
- **Owner inputs**: Node.js 26 LTS approval (D-001, resolved 2026-11-28), font asset decision (D-005), and any later resolution of the decisions in Section 9.
- **Future feature specifications**: all portfolio sections, Wal product pages, routing, rendering, SEO, and i18n implementation depend on this foundation and on the resolution of the relevant owner decisions.

## 12. Out of Scope

- Portfolio sections and all Airfolio-derived section implementations.
- Walday and Walplay product pages.
- Final routes, rendering strategy, SSG, sitemap, canonical URLs, structured data, and final SEO copy.
- Router, i18n library, language switcher, and Spanish content.
- Backend, API, database, CMS, authentication, contact form, analytics, tracking, and external data.
- Deployment, hosting, previews, security headers, branch protection, `main` creation, and repository settings.
- Brand assets, portraits, product screenshots, icons, decorative artwork, and font files.
- Visual fidelity validation of sections that do not exist.
- Any new visual identity, Wal product palette, or commercial template element.

## 13. Review and Next-Phase Readiness

A clarification pass ran on 2026-11-28 and recorded its answers in the Clarifications section. It fixed the foundation shell composition, made boundary compliance explicitly review-verified, established the single token source location, resolved D-007 by approving axe-core as development-only tooling, recorded the static document title as the only text-externalization exception, and scoped grid reflow acceptance to the first section specification that introduces a grid. The owner separately resolved D-001 on 2026-11-28 by approving Node.js 26 LTS (`docs/decisions/D-001-nodejs-version.md`); scaffolding may begin once Node.js 26 is installed locally and implementation is authorized.

The specification and plan are ready for implementation now that D-001 is resolved as Node.js 26 LTS. The remaining prerequisites are installing Node.js 26 locally and obtaining explicit authorization to scaffold. The plan's Constitution Check references principles by number and name and records D-001 as resolved by the separate owner decision.

The foundation is complete for review when every acceptance criterion in Section 6 is either satisfied or explicitly marked as blocked by a named owner decision. A blocked criterion is not a pass, and a skipped CI application job is not evidence that the quality gates ran.
