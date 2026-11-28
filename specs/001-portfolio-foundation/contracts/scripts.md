# Contract: Canonical Scripts and Hooks

**Feature**: `001-portfolio-foundation` | **Type**: CLI / tooling contract

The canonical script contract is authoritative in the constitution (Principle XIV). This file
binds the foundation to real implementations.

## Required package.json scripts

| Script | Command (implementation) | Tool | Must fail on |
| --- | --- | --- | --- |
| `lint` | `eslint . --max-warnings 0` | ESLint | Any error or warning |
| `format:check` | `prettier --check .` | Prettier | Any unformatted file |
| `typecheck` | `tsc -b --pretty false` with `noEmit: true` in both referenced tsconfigs | TypeScript | Any type error, including in config files; any emitted output |
| `test` | `vitest run --coverage` | Vitest + v8 | Failing test, console noise, unhandled rejection, coverage below 80% |
| `build` | `vite build` | Vite | Any build error |
| `prepare` | `husky` | Husky | Hook installation failure |

Supporting (non-canonical) scripts MAY exist for `dev` (`vite`) and local debugging. They MUST NOT
replace or weaken a canonical script.

**Prohibited**

- Scripts that only echo success, skip a check, or unconditionally exit zero.
- `--passWithNoTests`, disabled coverage, lowered thresholds, or `|| true`.
- Bypassing hooks with `--no-verify` without explicit user authorization.
- Adding or modifying CI workflows, deployment jobs, or gates.

## Exit-code semantics

```text
0   → every check ran and passed
≠0  → the specific gate ran and failed
```

A skipped gate is neither. CI's `detect` job must report `present=true` and the application job
must execute every step; a skipped application job is not a pass.

## Hook alignment

| Hook | Existing behavior (unchanged) | Foundation obligation |
| --- | --- | --- |
| `pre-commit` | `lint-staged`: Prettier write, ESLint `--max-warnings 0` on staged JS/TS | Provide ESLint/Prettier configs so the hook works; `package.json` must exist. `.prettierignore` must keep repo-wide `format:check` from failing on pre-existing out-of-scope documents; extend it narrowly and record the path rather than mass-reformatting or ignoring the check |
| `commit-msg` | `commitlint --edit` with the approved type list | Provide commitlint dependencies; do not change the config |
| `pre-push` | `lint`, `format:check`, `typecheck`, `test`, `build` | Each script must be real and pass |

Existing `.husky/*`, `.lintstagedrc.json`, and `commitlint.config.cjs` MUST NOT be replaced or
weakened. Compatibility-only changes are permitted and must be documented.

## CI alignment

`.github/workflows/ci.yml` is authoritative:

1. `detect` requires `package.json` + `package-lock.json` + `.nvmrc`, else fails.
2. `application` runs `npm ci` then the five scripts in order using `.nvmrc`.
3. Branch-name, commit-message, and PR-source checks are untouched.

The foundation adapts the application to CI, never the reverse.

## Verification

- Run each script independently; confirm a deliberately introduced violation produces a non-zero
  exit. Run the negative probes sequentially and revert each before the next, because every gate
  scans the whole application.
- Confirm disabling a covered test makes `test` fail the 80% threshold, not merely report lower
  coverage.
- Run the pre-push sequence end to end.
- Confirm `npm ci` does not rewrite `package-lock.json`.
- Record actual results in the PR description; mark unavailable or unrun checks as not run.

## Prerequisite

D-001 is resolved as Node.js 26 LTS (`docs/decisions/D-001-nodejs-version.md`). Scripts can be
created once Node.js 26 is installed locally, because `package.json`, `package-lock.json`, and
`.nvmrc` (pinning `26`) must land together.
