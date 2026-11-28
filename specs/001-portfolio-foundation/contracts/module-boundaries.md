# Contract: Module Boundaries

**Feature**: `001-portfolio-foundation` | **Type**: Architecture/review contract

Per Constitution Principle IV and spec FR-016, boundaries are verified in review. No boundary
lint rule, plugin, or tool is added by this foundation.

## Layers present

| Layer | Exists | Responsibility | Allowed imports |
| --- | --- | --- | --- |
| `app` | yes | Composition root, bootstrap, global configuration, providers | `pages`, `shared` |
| `pages` | yes | Page-level composition; one shell page | `shared` (and `features` later) |
| `features` | no | User interactions/use cases — introduced only with real behavior | `entities`, `shared` |
| `entities` | no | Domain model — introduced only with a real model | `shared` |
| `widgets` | no | Repeated composition — introduced only when justified | `features`, `entities`, `shared` |
| `shared` | yes | Reusable primitives, utilities, config, infrastructure adapters, i18n resource | `shared` only |

**Absent layers are intentional** (FR-010). Creating an empty `features`, `entities`, or `widgets`
directory is a defect.

## Import direction

```text
app → pages → features → entities → shared
```

- Imports flow downward only; no lower layer imports a higher layer.
- Slices at the same layer communicate through their public API (`index.ts`), not internal files.
- `shared` contains no business rules and no page-specific composition.
- Cross-layer imports use `@/…`; deep relative imports that climb directories (`../../..`) are
  prohibited.
- `src/test/` is test infrastructure, not a layer; it may be imported only by test files.
- Tests are colocated with their subject or mirrored without violating layer direction.

## Path alias

| Consumer | Configuration |
| --- | --- |
| TypeScript | `paths: { "@/*": ["./src/*"] }` in `tsconfig.app.json` |
| Vite | `resolve.alias: { "@": fileURLToPath(new URL("./src", import.meta.url)) }` (an absolute filesystem path, not the literal `"/src"`) |
| Vitest | merges `vite.config.ts` via `mergeConfig` (or repeats the same absolute alias), because a separate `vitest.config.ts` does not inherit Vite aliases automatically |

## Review checklist (manual, per change)

- [ ] New file placed in the layer that owns its responsibility.
- [ ] No empty layer, folder, or placeholder file created.
- [ ] Every import points downward or within `shared`.
- [ ] Cross-slice access uses the slice's public API.
- [ ] No climbing relative import; alias used.
- [ ] `shared` addition is generic, not page- or feature-specific.
- [ ] No business rule in a presentational component.
- [ ] Arrow-function syntax, explicit props, single responsibility.
- [ ] No speculative abstraction for imagined future needs.

## Verification

This contract is satisfied by review only. A temporary cross-boundary probe may be used during
validation to confirm review catches violations; it must be removed and never committed.
