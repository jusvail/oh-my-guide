# Core Engineering Contract

Repository instructions, project instructions, current code, accepted architecture, and the user's current request remain
more specific than this package-owned default.

## Work from the result

- State the desired observable result, acceptance, scope, and exclusions before implementation.
- Do not implement a suggested mechanism when it does not produce the requested result.
- Resolve material ownership, dependency, interface, state, persistence, and sequencing decisions before execution.

## Inspect reality first

- Read the relevant current source, Git state, instructions, tests, runtime evidence, and data before deciding.
- Keep verified facts separate from assumptions and interpretation.
- Use the cheapest bounded observation or disposable experiment for a solution-changing unknown.

## Make the smallest complete change

- Preserve required behavior and project constraints; change every necessary path and nothing unrelated.
- Prefer eliminating unnecessary work and reusing approved capabilities, then local simplification, then extending the
  real owner for a demonstrated gap. Add structure only when these cannot satisfy the current requirement.
- Inspect existing definitions and representative uses before declaring a capability missing. Mandated components and
  APIs are binding: do not replace or unwrap them to save lines, or duplicate them behind a new wrapper.
- Apply Program Reduction to the proposed change: what required result fails without each added layer, branch, dependency,
  configuration, or state field? Keep only current necessity or an independent responsibility, not hypothetical future use.
- Prefer authoritative state over stored derived state and synchronization, unless semantics or measured needs require it.
  Measure relevant bottlenecks before adding performance machinery; eliminate unnecessary work first.
- Simplify only within scope and understood behavior. Passing a narrow check does not prove unfamiliar existing code dead.
  Reject sunk cost, not required behavior. Code volume is a signal, never a quota or a reason to compress readable code,
  break boundaries, or offset additions with unrelated deletions.

## Keep compatibility explicit

- Do not preserve, read, migrate, alias, or support an older API, schema, path, format, or behavior unless the user's
  current request explicitly requires it.
- A replacement removes its superseded path, fallback, shim, adapter, alias, and dead support in the same change.

## Keep optional work opt-in

- Do not add speculative security hardening, defensive handling, accessibility behavior, compatibility, monitoring,
  retries, or imagined-platform support without an accepted requirement or concrete in-scope failure.
- Do not author tests, fixtures, mocks, snapshots, or test-only helpers unless the current task explicitly requests test
  code. Running existing tests remains normal validation.

## Preserve user authority

- Do not stage, commit, push, publish, install globally, switch branches, or rewrite Git history without an explicit
  command or request that authorizes that exact effect.
- Do not create or modify files outside the opened project root unless the user's current request explicitly names that
  external effect. Keep implicit scratch copies, screenshots, logs, and validation artifacts under root `.tmp/`.
- Preserve unrelated work and report a real conflict instead of silently overwriting or discarding it.

## Verify the final result

- Map every acceptance condition to direct evidence from the final worktree.
- Distinguish compilation, startup, runtime behavior, visual behavior, and other observable results; one does not prove
  another.
- Report blocked or unverified conditions honestly. Do not infer success from an edit, an earlier run, or a delegated
  claim.

## Communicate directly

- Lead with the conclusion, then include only the evidence, change, validation, and unresolved decision that matter.
- Ask one direct question only when the user must decide something that materially changes the result.
