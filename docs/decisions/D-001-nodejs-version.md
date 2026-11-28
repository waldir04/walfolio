# D-001: Node.js Version

| Field | Value |
| --- | --- |
| Status | Approved |
| Date | 2026-11-28 |
| Owner | Walfolio owner |
| Related | Constitution Principle XIII, DEF-17; `specs/001-portfolio-foundation/spec.md` D-001 |

## Context

The constitution deferred the Node.js version until an explicit owner decision. The repository
had no `.nvmrc`, `package.json`, or lockfile, and CI requires all three to exist together before
the application job can run. The foundation specification therefore could not select a version as
a side effect of scaffolding.

## Decision

Approve **Node.js 26 LTS** for the Walfolio toolchain.

- `.nvmrc` will pin the approved major line as `26`.
- Major and patch updates within Node.js 26 are routine maintenance under Principle XIII.
- Changing the approved major line requires a new documented owner decision.

## Rationale

- Node.js 26 became Active LTS on 2026-10-28 and is supported through 2029-04-30.
- Vite 8.4.0 declares `engines.node` as `^20.19.0 || >=22.12.0`, so Node.js 26 is supported.
- GitHub Actions `ubuntu-latest` supports the Node.js 26 LTS line through `actions/setup-node`.
- The alternatives were Node.js 24 (maintenance LTS, available locally) and Node.js 22 (extended
  support). Node.js 26 is the current Active LTS and gives the longest useful support window for a
  new application.

## Consequences

- Before scaffolding, install Node.js 26 locally (`nvm install 26`) because the current local
  runtime is Node.js 24.
- Generate `package-lock.json` with npm on Node.js 26.
- CI reads `.nvmrc` and will run the application checks on Node.js 26.
- Re-check the selected Vite, Tailwind CSS, Vitest, jsdom, and ESLint versions against Node.js 26
  when the scaffold is created. A future dependency that does not support Node.js 26 requires a
  new owner decision, not an untracked version change.
- This decision resolves DEF-17 and the spec's D-001 blocker. It does not by itself scaffold the
  application or create `.nvmrc`.
