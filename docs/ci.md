# Continuous Integration

Walfolio's CI is defined in `.github/workflows/`. It reuses the proven Walplay
architecture, adapted to a single application at the repository root.

## Current state

The application is **not scaffolded**. There is no root `package.json`,
`package-lock.json`, `.nvmrc`, application code, or selected Node.js version.

Therefore:

- Branch-name validation runs and is real.
- Conventional Commits validation runs and is real.
- Application detection runs and verifies repository state.
- Application checks are **skipped** until the application exists.
- A skipped application job is not evidence that lint, format, typecheck, tests, or build ran.

## Workflows

| Workflow | Trigger | Purpose |
| --- | --- | --- |
| `ci.yml` | Push to `develop` or `main`; PRs to those branches; manual dispatch | Branch naming, commit messages, application detection, application checks |
| `pr-source-validation.yml` | PRs targeting `main` | Requires the PR to come from `develop` in the same repository |

Both workflows declare `permissions: contents: read`. `ci.yml` uses concurrency grouped by
workflow and Git ref with `cancel-in-progress: true`, so a superseded run for the same ref is
cancelled. Checkout uses `fetch-depth: 0` and `persist-credentials: false`.

There are no path filters. Every push or pull request to `develop` or `main` runs the workflow,
including documentation-only changes.

## `ci.yml` jobs

### Branch name validation

Runs for every invocation. It uses `github.head_ref` for pull requests and `github.ref_name`
otherwise.

| Kind | Accepted format |
| --- | --- |
| Specification branch | `feat/NNN-slug`, `docs/NNN-slug`, `fix/NNN-slug` |
| Non-specification branch | `chore/slug`, `refactor/slug` |

`NNN` is exactly three digits. `slug` is lowercase alphanumeric segments separated by single
hyphens. Uppercase letters, underscores, spaces, empty segments, repeated or trailing hyphens,
missing prefixes, and unsupported prefixes fail the job.

`develop` and `main` are exempt from topic-branch naming, both for pushes and for a
`develop` → `main` pull request. This prevents the release PR from failing the branch-name gate.

The job validates format only. It does not verify that `specs/NNN-slug` exists or that the slug
matches a specification folder.

### Commit message validation

Runs for every invocation. It checks the Conventional Commits header of non-merge commits in
the relevant range:

- Pull request: `base.sha..head.sha`.
- Push: `before..after`, or the pushed commit when `before` is all zeros.
- Manual dispatch: the current `HEAD` commit.

The approved form is `type(scope): description`. The allowed types are `feat`, `fix`,
`refactor`, `test`, `docs`, `style`, `perf`, `build`, `ci`, and `chore`. Subjects must not exceed
100 characters or end with a period. Merge commits are ignored.

CI currently uses `scripts/ci/validate-commit-messages.sh`, a dependency-free validator, because
the application toolchain and its dependencies are not installed. Once the toolchain exists, CI
can be upgraded to run commitlint over the same range; until then, the shell validator is the
authoritative CI check. Local commit hooks use commitlint with the same type list.

### Detect application

Runs for every invocation and produces `present=true` or `present=false`.

- `present=true` only when the root `package.json` exists.
- When `package.json` exists, `package-lock.json` and `.nvmrc` are required. A missing file fails
  the job.
- If `package.json` is absent, the job also checks the base revision. If `package.json` existed
  there and was removed, the job fails instead of silently skipping checks.
- If the base commit cannot be resolved, the job fails.
- When `package.json` is absent and did not exist at the base revision, the job logs that the
  application is not scaffolded and outputs `present=false`.

### Application checks

Runs only when `needs.detect.outputs.present == 'true'`. When the application is absent, this job
is skipped and does not claim that any check ran.

Steps, in order:

1. `npm ci` from the committed lockfile.
2. `npm run lint`
3. `npm run format:check`
4. `npm run typecheck`
5. `npm run test`
6. `npm run build`

Node.js is read from `.nvmrc`, and the npm cache is keyed to `package-lock.json`. Any failing
step fails the job. The job has a 30-minute timeout.

## `pr-source-validation.yml`

Runs on pull requests targeting `main`. It requires:

- `github.head_ref` to be `develop`.
- The head repository to be the same repository as the base.

Any other source branch or fork fails. `main` does not exist in Walfolio yet; this workflow will
only apply after the branch is created as part of the approved branch-model implementation.

## Application scaffolding requirements

The following are required before application checks can run. They are **not** created yet.

### Node.js version

A Node.js version MUST be selected and pinned in a root `.nvmrc`. Do not assume Walplay's
version. The detection job fails if `package.json` exists without `.nvmrc`.

### Lockfile

`package-lock.json` MUST be committed before `npm ci` can run.

### Scripts

The root `package.json` MUST expose the canonical contract:

```text
lint, format:check, typecheck, test, build
```

It also needs `"prepare": "husky"` for hook installation. `test` MUST run the suite with coverage
once the coverage configuration is in place. Do not create scripts that only echo success.

### Tooling dependencies

The approved tooling requires, at minimum:

- `eslint`, `prettier`, `typescript`
- `vitest`, `@vitest/coverage-v8`, `jsdom`
- `@testing-library/react`, `@testing-library/jest-dom`, `@testing-library/user-event`
- `husky`, `lint-staged`
- `@commitlint/cli`, `@commitlint/config-conventional`

ESLint and Prettier configuration files must also be created with the application; the staged
lint and format commands depend on them. Application dependencies are separate. Versions and the
lockfile must be selected and committed together. These dependencies are not installed by this
change.

## Local development

Until the application exists, only the branch and commit checks are available locally.

```bash
# Topic branch, for example
git checkout -b chore/ci-infrastructure

# Validate the current commit message shape
EVENT_NAME=workflow_dispatch bash scripts/ci/validate-commit-messages.sh
```

Once the application is scaffolded and Node.js is selected:

```bash
nvm use
npm ci
npm run lint
npm run format:check
npm run typecheck
npm run test
npm run build
```

The same commands are the pre-push gate and the CI application gate.

## Git hooks

Hook files exist under `.husky/`:

| Hook | Action |
| --- | --- |
| `pre-commit` | Runs lint-staged on staged files |
| `commit-msg` | Runs commitlint on the commit message |
| `pre-push` | Runs `lint`, `format:check`, `typecheck`, `test`, `build` |

`lint-staged` is configured in `.lintstagedrc.json`: Prettier formats supported files and ESLint
runs on staged JavaScript/TypeScript files with `--max-warnings 0`.

Commitlint is configured in `commitlint.config.cjs`. It extends
`@commitlint/config-conventional` and overrides `type-enum` to the types approved by the
constitution.

The hooks are inert until the root `package.json`, Husky, and the tooling dependencies are
installed. They must not be bypassed with `--no-verify` unless the user explicitly authorizes it.
If a hook fails, fix the cause and create a new commit.

## Required GitHub repository settings

These settings are **not** applied by this change and cannot be configured from a workflow file.
A repository administrator applies them in GitHub.

Recommended:

1. Enable Actions with read-only default workflow permissions.
2. Protect `develop` and `main` with a pull request requirement.
3. Require the `Branch name validation` and `Commit message validation` checks.
4. Require `Application checks` only after the application is scaffolded and `package.json`
   exists. Until then, the job is skipped and must not be treated as proof of quality.
5. Enable “Require branches to be up to date before merging.”
6. Consider blocking administrator bypass.
7. Create `main` and verify that `develop` and the release branch share a usable Git history
   before enforcing the `develop` → `main` flow.

Do not configure branch protection through external APIs as part of feature work.

## Current branch state

- `develop` exists locally and on `origin`.
- `chore/initial-project-documentation` exists locally and on `origin`.
- Local `develop` and `chore/initial-project-documentation` share the base commit `d2aa921`.
- `origin/develop` contains a merge commit for the initial documentation branch.
- `main` does not exist yet.

## Limitations and deferred work

- No deployment or preview workflow exists. Hosting is deferred.
- No release workflow exists.
- No backend job or backend configuration exists; the MVP has no backend.
- Application checks cannot run until `package.json`, a lockfile, `.nvmrc`, dependencies, and the
  canonical scripts exist.
- Coverage thresholds are not configured yet. The initial 80% global and proposed 90% critical
  targets are ratified with Vitest and CI configuration, not asserted by this document.
- CI commit validation is dependency-free until the toolchain exists; commitlint remains the local
  hook and can be added to CI later over the same commit range.
- Actions are referenced by major version tag (`actions/checkout@v4`,
  `actions/setup-node@v4`). Pin them to commit SHAs if the repository requires immutable action
  references.
- PR source validation depends on `main` existing and on the approved branch model being
  implemented.
