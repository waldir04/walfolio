# Walfolio Project Instructions

These instructions govern how agents work in this repository. They do not replace the
constitution. `.specify/memory/constitution.md` remains the authoritative source for engineering
standards, and `docs/product-overview.md` remains the authoritative source for product scope.

## Git Branching Rules

All branches MUST follow `.specify/memory/constitution.md`, Principle XIV.

- Specification branches use `feat/NNN-slug`, `docs/NNN-slug`, or `fix/NNN-slug`.
- Non-specification branches use `chore/slug` or `refactor/slug`.
- Branch names are lowercase kebab-case and describe the change.
- `develop` is the integration branch. `main` is the production branch.
- Do not create `main`, modify branch protection, or change required checks as part of feature
  work. Those are separate implementation tasks.
- Do not rewrite or force-push existing branch histories without explicit authorization.

Spec Kit branch behavior:

- Walfolio currently has no `.specify/extensions.yml` and no `speckit.git.*` commands. Therefore
  `/speckit.specify` creates the specification directory but does not create a Git branch, and
  `GIT_BRANCH_NAME` has no effect until a `before_specify` hook exists.
- When the Spec Kit Git extension is installed and its hook is available, export
  `GIT_BRANCH_NAME="<prefix>/NNN-<slug>"` before invoking `/speckit.specify` or
  `/speckit.git.feature` so the hook uses the exact approved name.
- Without that extension, create the specification branch directly before or alongside the
  specification workflow:
  `git checkout -b <prefix>/NNN-<slug>` for specifications, or
  `git checkout -b <prefix>/<slug>` for non-specification work.

## Git Commit Rules

- Before any commit, review `git status` and `git diff` to identify every pending change.
- Follow the commit conventions and quality gates in `.specify/memory/constitution.md`,
  Principle XIV. Do not redefine them here.
- Stage only files related to the current task. Never include unrelated changes or existing user
  modifications.
- If unrelated or ambiguous changes are present, ask the user before staging or committing.
- Creating a commit requires explicit user authorization. Never create commits automatically.
- Never push unless the user explicitly requests it.
- Do not bypass Git hooks or CI checks. Do not use `--no-verify` or equivalent unless the user
  explicitly authorizes it.
- If a hook or check fails, fix the cause and create a new commit. Do not amend a failed commit
  unless the user explicitly requests it.
- The `/speckit.git.commit` command is not installed in Walfolio. Do not invoke commands that do
  not exist. If the Git extension is installed later, manual invocation MUST work independently
  of any auto-commit configuration, and automatic commits remain prohibited.
- After an authorized commit, prepare a Pull Request description following the Pull Request
  Rules. Reporting the commit hash alone does not complete the requested workflow.

## Pull Request Rules

- The `.github/pull_request_template.md` may not exist yet. Do not assume it does.
- When the template exists, follow its structure. Until then, use this order: Summary, Changes,
  Implementation Details, Testing, Design and Visual Validation, Screenshots, Checklist.
- Analyze the complete diff of the current branch against its target branch. Do not rely only on
  the latest commit.
- Feature branches target `develop`. Once the approved workflow is implemented, `main` receives
  Pull Requests only from `develop`.
- Include the related GitHub Issue and an appropriate closing keyword when applicable.
- Summarize purpose, main changes, and relevant technical decisions.
- Report only checks that were actually executed. Distinguish passed, failed, and not available.
  Never invent test, lint, typecheck, build, or CI results.
- Include screenshots or recordings for UI changes when available. Identify which screens and
  interactions require evidence.
- Use real implementation captures. Never present mockups, design references, or fabricated
  images as evidence of implemented functionality.
- If visual evidence is unavailable, leave a clear placeholder and state what must be captured.
- Do not invent functionality, metrics, content, or implementation details.
- Output the description in Markdown, ready to copy into GitHub.
- Do not create, publish, or submit a Pull Request, and do not push, without explicit user
  authorization.

## Product and Design Context

Before creating or modifying a specification, plan, task list, or implementation, review the
governing documents that apply:

1. `.specify/memory/constitution.md` — engineering principles, architecture, quality gates, and
   technical standards.
2. `docs/product-overview.md` — product vision, MVP scope, business rules, out-of-scope items,
   open decisions, and page structure.
3. `docs/design/design-reference.md` — verified observations and structure of the Airfolio
   reference.
4. `docs/design/design-system.md` — the single source of truth for design tokens.
5. `docs/design/component-inventory.md` — reference component catalog and adaptation guidance.
6. `docs/design/implementation-decisions.md` — Walfolio adaptation decisions, responsive
   proposals, accessibility notes, and the Open Items Register.
7. The relevant specification under `specs/NNN-slug/`, including its plan, tasks, and contracts
   when they exist.

Authority:

- The constitution governs engineering.
- The Product Overview governs product scope and business rules.
- The design documents govern visual fidelity, tokens, components, and adaptation decisions.
- Feature specifications govern per-feature behavior and acceptance criteria.

Repository layout:

- The application lives at the repository root. Do not introduce `frontend/` or `backend/`
  directories.
- Content is authored in the repository and version-controlled. The MVP has no backend, custom
  API, CMS, authentication, or analytics.

Reviewing these documents is part of the Spec Kit workflow, not optional reference work.

## Design Fidelity Rules

- Implement the Airfolio reference faithfully. The exports are in
  `docs/design/references/airfolio/`. Do not introduce an unapproved visual redesign, new visual
  identity, or alternative layout language.
- Use semantic design tokens from `docs/design/design-system.md`. Do not bypass the token system
  with arbitrary values.
- Respect the status of every design decision:
  - `Verified` values and structures are evidence from the reference.
  - `Proposed` values are Walfolio decisions that still require validation.
  - `Approx.` values are estimates, not measurements.
  - `Open` values are undecided and must not be implemented as final.
- Only `Verified` or explicitly owner-approved token values may be treated as final requirements.
- Tablet and mobile layouts are `Proposed`. Do not describe or validate them as verified
  reference designs.
- Do not change tokens, colors, typography, spacing, or component structure without approval.
  Token changes update `design-system.md` first and remain provisional until approved.
- Document unavoidable deviations caused by missing assets, accessibility requirements, or
  technical constraints. Do not hide them.
- Validate desktop against the verified reference and responsive behavior against the approved
  proposals. Do not claim pixel fidelity that has not been checked.
- Capture evidence from the running implementation. Never fabricate screenshots or use design
  references as proof that a UI was implemented.
- Do not publish product visuals that imply functionality that does not exist.

## Modern Web Development Guidelines

- If the environment exposes the Modern Web Guidance skill, use the relevant guidance before
  working on browser APIs, HTML, CSS, responsive layouts, accessibility, UI interactions, or
  frontend performance.
- If the skill is unavailable, continue with the constitution and project documentation. Do not
  claim that external guidance was consulted.
- Prefer native browser capabilities and semantic HTML over unnecessary JavaScript or new
  dependencies.
- Check Baseline browser compatibility before adopting modern platform features.
- Respect the project's browser support requirements and existing architectural decisions.
- Apply progressive enhancement where needed for a reliable experience.
- Avoid experimental or limited-availability APIs unless explicitly justified.
- Do not add dependencies solely because a newer native alternative exists, and do not replace
  existing libraries without an approved reason.
- Apply only guidance relevant to the current task.

## Specification Rules

- All specifications MUST align with the Product Overview, the design documents, and the
  constitution.
- Respect the MVP scope and the explicit out-of-scope list. Do not introduce functionality
  outside the MVP without identifying it as out of scope or requesting clarification.
- Do not silently resolve deferred technology decisions. Rendering strategy, router, i18n
  library, SSG tool, Node.js version, hosting, and deployment remain deferred until documented
  and approved.
- Do not introduce a backend, custom API, CMS, authentication, analytics, tracking, or
  third-party measurement without explicit owner approval. These are outside the current MVP.
- Do not introduce unapproved libraries or tools. The approved stack is React, TypeScript, Vite,
  and Tailwind CSS v4; everything else requires a documented decision.
- Do not invent product features, availability, metrics, testimonials, dates, or roadmap claims.
- Treat conditional sections and open decisions as open. For example, Video Introductions, Life
  Outside Code, contact mechanism, Spanish depth, and accessibility conformance are not approved
  merely because they appear in a document.
- If a requirement is ambiguous or conflicts with the Product Overview, design documentation, or
  constitution, identify the conflict and ask. Do not make an unsupported assumption.
- Feature requirements may refine general requirements but MUST NOT silently contradict them.
- When a significant product or design decision changes, identify which governing document needs
  an update and request approval before changing it.
- Do not edit `docs/product-overview.md`, `docs/design/*`, or the constitution as a side effect of
  feature work.

## Implementation and Validation Rules

- Plans MUST include a Constitution Check that references principles by number and name. Do not
  rename or renumber principles.
- Follow the Spec Kit flow: specification, clarification when needed, plan, tasks, implementation,
  and validation.
- The canonical script contract is `lint`, `format:check`, `typecheck`, `test`, and `build`.
  Do not assume these scripts exist before the application is scaffolded. Do not claim a check
  ran when its script is unavailable.
- When the application exists, run the relevant checks and report their real results. Do not
  report a check as passed if it was skipped, unavailable, or failed.
- Tests MUST follow the constitution: Vitest and React Testing Library, observable behavior,
  meaningful coverage, zero unexpected warnings, and no unhandled rejections.
- Coverage targets are an initial 80% global target and a proposed 90% target for critical
  modules, pending ratification with Vitest and CI configuration. Do not lower them merely to
  make a pipeline pass.
- Include accessibility testing where applicable. Automated checks do not replace manual keyboard
  and focus verification.
- For UI changes, perform visual validation and responsive verification using the approved
  reference and adaptations. Do not treat `Proposed` responsive layouts as verified.
- Verify the site at the supported widths defined by the design documentation, including the
  desktop reference width. Document any width that could not be checked.
- Do not claim WCAG 2.2 AA conformance. The formal target is undecided and the primary button
  contrast issue remains open.
- Record durable architectural decisions as ADRs. Update documentation when architecture,
  behavior, or decisions change, subject to the approval rules above.
- Do not create deployment or preview workflows until hosting is selected. Do not add CI gates
  beyond the approved initial scope without explicit approval.
- Do not install dependencies, modify package configuration, or introduce build tooling unless explicitly required by an approved specification, implementation plan, or infrastructure task.
- Infrastructure tasks explicitly approved by the owner may modify package scripts, development dependencies, Git hooks, and CI configuration when necessary to implement the constitution's quality gates.
- AI-generated work MUST meet the same quality, security, testing, and review standards as
  manually written work.
