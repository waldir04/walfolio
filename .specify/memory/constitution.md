# Walfolio Constitution

This document defines **how** Walfolio is engineered. Product scope and business requirements
are defined in `docs/product-overview.md`; visual reference, tokens, component analysis, and
adaptation decisions are defined under `docs/design/`. Feature behavior belongs in `specs/*`.

Walfolio is a personal developer portfolio: a responsive presentation surface with a homepage
and individual Wal product pages. It is not a commercial product site and, in the MVP, it has
no backend, custom API, CMS, or authentication.

**Authority**

- The Product Overview governs **what** the product is and **why**.
- The design documents govern **visual reference, tokens, components, and adaptation decisions**.
- This constitution governs **engineering standards** and the outcomes they require.
- Feature specifications govern **per-feature behavior** and acceptance criteria.

**Decision discipline**

- Only statements marked `Confirmed` in product documentation, `Verified` in design
  documentation, or explicitly approved by the owner may become mandatory engineering rules.
- `Proposed`, `Approx.`, and `Open` decisions remain provisional. They MUST NOT be silently
  hardened into principles, gates, or final values.
- Requirements that conflict with this constitution or the product documents MUST be identified
  explicitly rather than reinterpreted.
- This constitution defines obligations and outcomes. Exact compiler, linter, formatter, test,
  and CI settings belong in their configuration files. Agent procedures belong in `AGENTS.md`.

## Core Principles

### I. Clean Code, Simplicity, and Maintainability (NON-NEGOTIABLE)

The codebase MUST prioritize readability, clarity, and maintainability.

- Apply single responsibility, meaningful names, and self-documenting code.
- Keep business rules, presentation, state, and content access separated by responsibility.
- Prefer the simplest solution that satisfies a current requirement.
- Do not introduce speculative abstractions, empty layers, or structure for imagined future
  needs.
- Split units by responsibility rather than by line count; a unit MUST remain reviewable in one
  pass.
- Avoid duplicated logic, unnecessary coupling, and premature optimization.
- Comments explain decisions, constraints, or non-obvious behavior, never what the code already
  expresses.

Rationale: Walfolio's own implementation is part of its evidence of engineering quality.

### II. Strict TypeScript and Type Safety (NON-NEGOTIABLE)

TypeScript MUST be used throughout the application with strict type checking enabled.

- Unsafe typing is prohibited. The use of `any`, whether explicit or implicit, is not allowed.
- Prefer `unknown` and safe narrowing when a value is genuinely unknown.
- Type assertions and non-null assertions are permitted only at validated boundaries and MUST be
  justified in writing.
- Compiler suppressions MUST describe the expected error and are limited to genuine third-party
  typing defects. They MUST NOT be used to silence the compiler.
- Public contracts, component props, and module boundaries MUST be explicitly typed.
- Exact compiler flags belong in `tsconfig`; this principle defines the required strictness and
  safety outcomes.

### III. Design Fidelity and Token Governance (NON-NEGOTIABLE)

The Airfolio reference is the visual source of truth, adapted only through documented decisions.

- Implementation MUST match the reference at Verified desktop breakpoints and the approved
  responsive adaptations. Deviations MUST be documented and reviewed.
- `docs/design/design-system.md` is the single source of truth for design tokens. Other
  documents reference token names rather than restating values.
- Only token values marked `Verified` or explicitly approved by the owner are final
  implementation requirements. `Approx.`, `Proposed`, and `Open` values remain provisional.
- Components MUST consume semantic tokens. Arbitrary visual values that bypass the design system
  are prohibited.
- A justified technical exception is permitted when documented and reviewed. Raw values are not
  banned in every context by default; bypassing the system without justification is.
- Token changes MUST update `design-system.md` first.

### IV. FSD-Lite Architecture and Module Boundaries (NON-NEGOTIABLE)

The frontend MUST use a reduced Feature-Sliced Design structure sized to the product.

- Required layers are `app`, `pages`, `features`, and `shared`. `entities` and `widgets` MAY be
  introduced only when a real domain model or repeated composition justifies them.
- Empty layers, folders, or files MUST NOT be created to satisfy the architecture.
- Imports MUST flow downward only. A layer MUST NOT import from a layer above it.
- Slices at the same layer MUST communicate through public APIs, not internal files.
- `shared` contains UI primitives, utilities, configuration, and infrastructure adapters; it MUST
  NOT contain business rules or page-specific composition.
- `features` hold user interactions and use cases. `pages` compose features and shared modules.
- `app` holds providers, routing, global configuration, and application composition.
- Deep relative imports that climb directories are prohibited; use the configured path alias.
- Tests MUST be colocated with their subject or mirrored without breaking layer boundaries.

Automated boundary enforcement is not part of the initial gate; compliance is verified in review
until a justified tool is introduced.

### V. Component Design and Function Syntax (NON-NEGOTIABLE)

React components MUST remain small, focused, and explicit.

- Presentational components MUST NOT fetch data or contain business rules. Extract logic into
  hooks or the appropriate feature module.
- Props MUST be explicitly typed. Variant-driven components SHOULD use discriminated unions.
- Prefer composition over configuration-heavy components.
- Keep state as close as possible to where it is used. Avoid indiscriminate global state and deep
  prop drilling.
- Memoization MUST be justified by a demonstrated or reasonably evidenced need.
- Application functions MUST use arrow function syntax for consistency. Readability MUST NOT be
  sacrificed to satisfy the convention. Exact lint rules belong in the linter configuration.
- Forms, if introduced, MUST be controlled, validated, and accessible.

### VI. Accessibility as a Requirement (NON-NEGOTIABLE)

Accessibility is a mandatory engineering concern at specification, design, implementation, and
testing.

- Use semantic HTML, a logical heading hierarchy, landmarks, and one H1 per page.
- All essential functionality MUST be keyboard operable, with a visible and consistent focus
  indicator and a logical focus order.
- Controls MUST have meaningful accessible names. Images MUST have appropriate alternative text;
  decorative elements MUST be ignored by assistive technology.
- Status, errors, loading, and availability MUST NOT rely on color alone.
- Interactive targets MUST meet applicable minimum target sizes.
- Motion MUST respect `prefers-reduced-motion`.
- The document `lang` attribute MUST reflect the active locale.
- Automated accessibility checks are required where applicable, but they MUST NOT be treated as
  sufficient proof. Critical journeys require manual keyboard and focus verification.
- Walfolio MUST NOT claim WCAG 2.2 AA conformance until the formal accessibility target is
  approved (OD-06) and the unresolved design contrast issue (OI-15) is addressed.
- Accessibility defects affecting critical journeys MUST be treated as defects, not polish.

### VII. Internationalization Readiness (NON-NEGOTIABLE)

The architecture MUST support English and Spanish without structural rework.

- English is the default language. Spanish support is prepared from the start.
- All user-facing text MUST be externalized into structured translation resources. Hardcoded
  user-facing copy in components is prohibited.
- Translation keys MUST be descriptive and organized by feature or interface area.
- English is the fallback language. Missing translations MUST degrade predictably.
- Users MUST be able to switch languages without a full application reload when the interface
  exposes a switcher.
- Dates, numbers, and other locale-sensitive values MUST use `Intl` where applicable.
- Document metadata and language alternates MUST reflect the active locale.
- Full Spanish content parity MUST NOT be assumed until the product decision (OD-01) is final.
- The i18n library is not approved by this constitution and remains a deferred decision.

### VIII. Testing, Zero-Warning Policy, and Coverage (NON-NEGOTIABLE)

Testing is part of delivery, not a follow-up activity.

- Use Vitest and React Testing Library for unit and component tests.
- Apply Arrange-Act-Assert and test observable behavior rather than implementation details.
- Cover business rules, critical journeys, navigation, metadata, i18n behavior, and relevant
  edge and boundary states.
- Control time and external dependencies deterministically. Tests MUST NOT perform real network
  calls.
- Accessibility testing MUST be included where applicable.
- A task is not complete without the relevant tests written and passing.

Zero-warning policy:

- Unexpected `console.warn` and `console.error` output and unhandled promise rejections MUST fail
  the test suite.
- Globally disabling console warnings or errors to make tests appear clean is prohibited.
  Expected warnings MAY be asserted when they are part of the behavior under test.
- Pending-timer detection is not a universal failure requirement unless a reliable and
  justified implementation is identified.

Coverage:

- 80% global coverage is the initial target. 90% for critical modules is a proposed target
  pending identification of those modules.
- Practical thresholds MUST be ratified when Vitest and the initial CI pipeline are configured.
- Thresholds are enforced by the `test` gate but belong in `vitest.config.ts`.
- Future threshold adjustments require a documented technical decision, not a constitutional
  amendment. Thresholds MUST NOT be lowered merely to make CI pass.
- Coverage indicates completeness, not proof of quality.

### IX. Performance and Media Efficiency

Walfolio MUST load quickly on ordinary connections and devices.

- Avoid unnecessary rendering, computations, and dependencies.
- Apply route-level code splitting and lazy loading where appropriate.
- Review bundle size and dependency impact whenever a dependency is added.
- Images MUST declare dimensions or aspect ratios and use modern formats and responsive sources
  where appropriate. Below-the-fold media MUST be lazy-loaded.
- Fonts MUST use appropriate loading and fallback behavior to minimize layout shift.
- Heavy media and interaction libraries MUST be justified by the approved scope; omitted
  interactions MUST NOT bring their libraries.
- Performance improvements MUST respond to measured or reasonably evidenced bottlenecks.
- Lighthouse or equivalent measurement MUST be performed before release. Numeric performance
  budgets remain deferred until a baseline is approved.
- Analytics is a separate privacy decision and MUST NOT be introduced as a performance tool.

### X. SEO, Metadata, and Semantic Structure

Every published page MUST be indexable and meaningfully described.

- Each page MUST have a meaningful title and description.
- The homepage and each product page MUST expose share metadata and one canonical indexable page
  per published product.
- Document structure MUST be semantic, with a logical heading hierarchy.
- Language alternates MUST be provided when Spanish is implemented.
- SEO copy MUST be accurate and free of keyword stuffing or invented claims.
- The rendering strategy is deferred until the SEO evaluation and architecture decision are
  completed. A client-only SPA MUST NOT be assumed.
- Before final routes and metadata are implemented, the chosen rendering approach MUST
  demonstrate that the required pages are indexable. Rendering details belong in an ADR or
  specification, not in this constitution.

### XI. Honest Content and Product-Status Accuracy (NON-NEGOTIABLE)

Walfolio's content MUST be accurate, current, and honest.

- No capability, release, availability, metric, testimonial, client, or roadmap claim may be
  invented or implied.
- Wal product maturity MUST be stated explicitly and consistently wherever the product appears.
- No screenshots, demos, or copy may imply functionality that does not exist.
- Placeholder marketing copy, lorem ipsum, and temporary assets MUST be clearly marked and
  removed before release.
- Content is authored in the repository and version-controlled. No CMS is introduced in the MVP.
- Product-status wording remains a product decision (OD-04) and MUST NOT be fixed by engineering
  convenience.

### XII. Static Architecture, Privacy, and Security (NON-NEGOTIABLE)

The MVP is a static presentation surface.

- Walfolio MUST NOT introduce a backend, custom API, CMS, or authentication. A backend MUST NOT
  be introduced merely to solve a frontend or content-management concern.
- Any addition to this boundary is a product scope change requiring explicit owner approval, not
  an implementation detail.
- No analytics, tracking, or monetization script is included by default. Measurement remains a
  product decision (OD-09).
- Contact defaults to direct links unless the product scope changes. A form is not implied by the
  current scope (OD-02).
- Secrets, credentials, and sensitive environment values MUST NOT be committed or shipped to the
  client.
- External and untrusted data MUST be validated at the boundary where it is consumed.
- Unsanitized HTML injection is prohibited.
- External links MUST be safe and intentional.
- Security headers, including a Content Security Policy, MUST be configured at the hosting layer
  once hosting is selected.

### XIII. Technology Stack and Dependency Governance (NON-NEGOTIABLE)

The approved initial stack is:

| Area | Approved technology |
| --- | --- |
| UI | React |
| Language | TypeScript |
| Build tool | Vite |
| Styling | Tailwind CSS v4 |

- Rendering strategy, router, i18n library, SSG tool, and Node.js version are NOT approved by
  this constitution. They remain deferred decisions and MUST be evaluated and documented before
  adoption.
- The stack is closed until amended. A feature specification or plan MUST NOT introduce a
  technology outside the approved stack without an explicit decision.
- A new runtime dependency MUST be justified in writing with its need, alternatives considered,
  bundle and performance impact, license, security posture, and fit with this constitution.
- Prefer platform APIs and existing dependencies over adding new ones.
- Development-only tooling is permitted and MUST be documented.
- Lockfiles MUST be committed. The Node.js version MUST be pinned once selected.
- Major upgrades, replacements, and removals require an amendment. Minor and patch updates
  within an approved major line are routine maintenance.
- Rendering is an architectural decision, not a stack replacement. It is recorded through an ADR
  or specification once the SEO evaluation is complete.

### XIV. Automated Quality Gates, Git Workflow, and Commit Convention (NON-NEGOTIABLE)

The canonical application script contract is:

```text
lint, format:check, typecheck, test, build
```

- These scripts are the canonical entry points; hooks and CI MUST invoke them rather than
  duplicating their logic.
- Pre-commit hooks MUST run fast formatting and linting on staged files.
- Commit messages MUST be validated automatically.
- Pre-push hooks MUST run the full script contract.
- CI MUST run the same checks and MUST include commit message validation.
- Git hooks MUST NOT replace CI. Bypassing hooks or CI is an exceptional, justified action.
- Exact tool versions and rule sets belong in configuration files.

Commit convention: Conventional Commits in the form `type(scope): description`, using
`feat`, `fix`, `refactor`, `test`, `docs`, `style`, `perf`, `build`, `ci`, or `chore`.

Git workflow:

- `develop` is the integration branch and `main` is the production branch.
- All changes MUST arrive through a Pull Request. `main` MUST receive Pull Requests only from
  `develop`.
- Specification branches use `feat/NNN-slug`, `docs/NNN-slug`, or `fix/NNN-slug`. Other branches
  use `chore/slug` or `refactor/slug`. Names are lowercase kebab-case.
- Creating `main`, configuring branch protection, and requiring status checks are implementation
  tasks. Before enforcing the workflow, the repository MUST be verified to have a usable shared
  Git history that supports the intended Pull Request flow.
- Existing branch histories MUST NOT be rewritten or force-pushed without explicit authorization.
- No agent, hook, or tool may create commits, push, open or merge Pull Requests, tag, or publish
  without explicit user authorization. Read-only Git operations are exempt.
- Required quality gates MUST pass before merge.

### XV. Documentation, Decision Records, and Visual Validation

Documentation and validation are part of the engineering standard.

- Developer-facing documentation and technical artifacts MUST be written in English.
- Durable architectural decisions MUST be recorded as ADRs, including scope and rationale.
- Documentation MUST stay aligned with the implementation. Setup, configuration, and workflow
  changes require documentation updates.
- Plans MUST include a Constitution Check that references principles by number and name.
- Visual validation MUST compare the rendered result against the Verified reference at desktop
  and against the approved responsive proposals for tablet and mobile.
- UI changes MUST include screenshots or recordings when available. Fabricated or mockup evidence
  is prohibited.
- Unavoidable visual deviations caused by missing assets or accessibility fixes MUST be documented
  and reviewed.
- AI-generated code MUST meet the same quality, security, testing, and review standards as
  manually written code.

## Additional Constraints and Technology Standards

### Approved and Deferred Technology Decisions

| Technology or area | Status | Notes |
| --- | --- | --- |
| React | Approved | UI library |
| TypeScript | Approved | Application language |
| Vite | Approved | Build tool |
| Tailwind CSS v4 | Approved | Styling |
| Vitest and React Testing Library | Approved | Testing approach |
| ESLint and Prettier | Approved | Quality tooling |
| Husky, lint-staged, commitlint | Approved | Git tooling |
| Rendering strategy | Deferred | SSG, prerendering, or another approach must be evaluated |
| Router | Deferred | Not selected |
| i18n library | Deferred | Not selected |
| SSG tool | Deferred | Not selected |
| Node.js version | Deferred | Not selected; pin once chosen |
| Hosting, deployment, previews | Deferred | Not selected |

### Design System Authority

`docs/design/design-system.md` is authoritative for token names and definitions. Only `Verified`
or owner-approved token values are final. `Approx.`, `Proposed`, and `Open` values remain
provisional and MUST be validated before being treated as final. New visual patterns not present
in the reference MUST be labeled `Proposed` and justified.

### Static MVP Boundary

The MVP presents content authored in the repository. It does not build or operate a server, a
CMS, or an authentication system. Content, contact links, and product descriptions are part of
the repository. Product pages MUST be extensible through content and templates, not through new
layouts per product.

### Privacy and Contact Defaults

No analytics or tracking is included by default. Contact is link-based by default. These are
approved engineering defaults; they do not close the corresponding product decisions, and the
Product Overview MUST NOT be treated as updated until the owner records the change.

## Development Workflow, Quality Gates, and Definition of Done

### Specification workflow

Before creating or modifying a specification, plan, task list, or application code, the work MUST
review:

1. `docs/product-overview.md` for product scope and business rules.
2. `docs/design/*` for visual reference, tokens, components, and adaptation decisions.
3. This constitution for engineering standards.

The Spec Kit flow is: specification, then plan with an explicit Constitution Check, then tasks,
then implementation, then visual validation. Conflicts between requirements and governing
documents MUST be identified explicitly. Product capabilities MUST NOT be invented in a plan or
amendment.

### Branching and Pull Request policy

- `develop` integrates completed work; `main` is production.
- Pull Requests are mandatory. `main` receives Pull Requests only from `develop`.
- Conventional Commits and branch naming rules apply as defined in Principle XIV.
- Pull Request descriptions MUST summarize purpose, changes, technical decisions, and the checks
  actually executed. Unverified test or build claims are prohibited.
- UI changes MUST identify the screens and interactions that require visual evidence.

### Quality gates

| Stage | Required checks |
| --- | --- |
| Pre-commit | Formatting and linting of staged files |
| Commit message | Conventional Commits validation |
| Pre-push | `lint`, `format:check`, `typecheck`, `test`, `build` |
| CI | The same checks plus commit message validation |
| Merge | Passing required status checks and review |

Branch name validation and Pull Request source validation are part of the reused CI architecture.
Deployment workflows are deferred until hosting is selected.

### Definition of Done

A task is complete only when:

- The implementation complies with this constitution.
- `lint`, `format:check`, `typecheck`, `test`, and `build` pass.
- Relevant tests exist for new logic, critical journeys, and metadata, and they pass.
- No unexpected warnings or unhandled rejections are emitted by tests.
- No unjustified `any`, type assertion, non-null assertion, or compiler suppression was
  introduced.
- User-facing text is externalized and English translation keys are complete.
- Accessibility baseline requirements are met and automated checks pass where applicable.
- Responsive behavior was verified at the supported widths.
- Design fidelity was validated against the reference, or deviations are documented and
  approved.
- Content claims and product-status statements are accurate; no placeholder content remains in a
  release candidate.
- Documentation or an ADR was updated when architecture, behavior, or decisions changed.
- No secret, tracking script, or unauthorized integration was introduced.
- Open product or design decisions were not hardened into implementation requirements.
- CI is green.

### Code review

Reviews MUST verify constitutional compliance, not only functional correctness. Reviewers MUST
check duplication, unnecessary complexity, type safety, boundary validation, test quality,
accessibility, responsive behavior, performance impact, security implications, content accuracy,
and documentation. Exceptions MUST be recorded and justified. Silent deviations are defects.

### Visual validation

Visual validation is a required step for UI work. It compares the rendered result with the
Verified reference at desktop and with the approved responsive proposals. Missing assets,
accessibility corrections, and other unavoidable deviations MUST be documented. Placeholder or
mockup evidence MUST NOT be presented as implemented functionality.

## Governance

This constitution is the authoritative source of Walfolio engineering standards.

- All specifications, plans, tasks, and implementation work MUST be consistent with it.
- If an implementation decision conflicts with a principle, the conflict MUST be identified and
  resolved explicitly.
- Exceptions MUST be justified and, when durable, recorded as an ADR.
- New code and changed code MUST comply immediately. Pre-existing gaps MUST be brought into
  compliance when the affected area is touched and MUST NOT be used as precedent.
- Recurring deviations indicate that the constitution or the implementation approach needs an
  explicit amendment, not repeated exceptions.
- A deviation that is not recorded and justified is a defect.
- Reviews MUST verify compliance across architecture, type safety, i18n, accessibility,
  performance, SEO, privacy, testing, and documentation.

### Amendments

1. Propose the change with its rationale and affected principles.
2. Classify the version bump.
3. Check for conflicts with the Product Overview, design documents, and existing specifications.
4. Update affected templates, plans, and specifications that cite changed principles.
5. Record the amendment date in the footer.

### Versioning

- MAJOR: incompatible governance changes, principle removal or redefinition, or renumbering.
- MINOR: new principles, new sections, or materially expanded guidance.
- PATCH: clarifications, corrections, or wording changes that do not alter requirements.
- Coverage threshold adjustments and similar technical tuning are documented decisions, not
  constitutional amendments, unless they change the principle itself.

### Deferred Decisions Register

These decisions remain open. No implementation may treat them as resolved.

| ID | Decision | Current state | Blocks |
| --- | --- | --- | --- |
| DEF-01 | Rendering strategy | Deferred until SEO evaluation and architecture decision | Final routes, metadata, post-build validation |
| DEF-02 | SEO evaluation criteria and tooling | Not defined | DEF-01 |
| DEF-03 | Hosting, deployment, and preview workflows | Not selected | Security headers, deployment automation |
| DEF-04 | Depth of Spanish content (OD-01) | EN/ES architecture approved; parity open | Content acceptance per section |
| DEF-05 | Formal accessibility target (OD-06) | Baseline mandatory; no AA claim permitted | Acceptance criteria and audit |
| DEF-06 | Primary button contrast (OI-15) | Unresolved at approximately 4.1:1 | Final primary button |
| DEF-07 | Contact mechanism (OD-02) | Direct links approved as default | Forms or third-party services |
| DEF-08 | Analytics and measurement (OD-09) | None by default | Tracking and third-party scripts |
| DEF-09 | Final section order and composition (OD-05) | Proposed | Content and visual validation |
| DEF-10 | Walday and Walplay status wording (OD-04) | Open | Product cards and pages |
| DEF-11 | Assets, logo, favicon, and photography (OI-13) | Open | Header, hero, About, release |
| DEF-12 | Public product destinations | Open | Product links |
| DEF-13 | Video introductions and Life Outside Code | Conditional or proposed | Scope and sections |
| DEF-14 | Router selection | Not selected | Navigation architecture |
| DEF-15 | i18n library | Not selected | Translation implementation |
| DEF-16 | SSG tool | Not selected | Rendering implementation |
| DEF-17 | Node.js version | Not selected | Toolchain and CI |
| DEF-18 | Critical modules and final coverage thresholds | Proposed | Vitest and CI configuration |
| DEF-19 | Additional CI gates | Not approved | Lighthouse, link checking, visual regression, E2E, dependency audit |
| DEF-20 | `AGENTS.md` operational content | Deferred by instruction | Agent conduct details |
| DEF-21 | Token calibration for Approx./Proposed values | Open | Final visual fidelity |
| DEF-22 | Creation of `main`, branch protection, and required checks | Implementation task | Enforced PR workflow |
| DEF-23 | Shared Git history verification for the PR flow | Implementation task | Safe enforcement of the branch model |

### Compliance and transition

- Reviews MUST verify constitutional compliance.
- Known gaps MUST be tracked in this document or an ADR until resolved.
- Security, data integrity, and accessibility issues affecting critical journeys take priority
  over cosmetic compliance.
- The constitution MUST preserve decision status: approved rules are enforceable, while
  `Proposed`, `Approx.`, and `Open` items remain provisional.

**Version**: 1.0.1 | **Ratified**: 2026-11-27 | **Last Amended**: 2026-11-27
