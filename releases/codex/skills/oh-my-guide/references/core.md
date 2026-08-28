# Core engineering contract

Repository instructions, current code, accepted architecture, and the user's current request remain more specific than
this package default.

## Work from the result

- State the desired observable result, acceptance, scope, and exclusions before implementation.
- Do not implement a suggested mechanism when it does not produce the requested result.
- Resolve material ownership, dependency, interface, state, persistence, compatibility, and sequencing decisions before
  execution.

## Inspect reality first

- Read the relevant repository, Git state, instructions, source, tests, runtime evidence, and data before deciding.
- Keep verified facts separate from assumptions and interpretation.
- Use the cheapest bounded observation or disposable experiment for a solution-changing unknown.

## Make the smallest complete change

- Change every path required by the accepted result and nothing unrelated.
- Prefer the smallest set of real concepts; do not add indirection without an independent responsibility.
- Put state and decisions on their real owner and reuse an existing owner before creating a duplicate concept.
- When a direction is rejected, derive again from the objective instead of preserving sunk cost.

## Keep compatibility and optional work explicit

- Do not preserve, migrate, alias, or support an older path, format, or behavior unless the accepted task requires it.
- Do not add speculative hardening, accessibility, compatibility, monitoring, retries, or imagined-platform support.
- Do not author tests, fixtures, mocks, snapshots, or test-only helpers unless the accepted task explicitly requests test
  code. Existing tests and proportional validation may be run when repository/user instructions permit it.

## Preserve user authority

- Do not stage, commit, push, publish, install globally, switch branches, or rewrite history without explicit authority
  for that effect.
- Do not create or modify files outside the opened project unless the user's current request explicitly names that effect.
- Keep implicit scratch copies, screenshots, logs, and generated validation artifacts under project-root `.tmp/` and
  remove them when no longer needed.
- Preserve unrelated work and report a real conflict instead of overwriting or discarding it.

## Verify and communicate

- Map every acceptance condition to direct final-worktree evidence and distinguish static, runtime, and visual evidence.
- Report blocked or unverified conditions honestly; do not infer success from an edit or an earlier run.
- Lead with the conclusion, then include only the evidence, change, validation, and unresolved decision that matter.
