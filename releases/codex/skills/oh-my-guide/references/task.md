# Execution modes

Apply exactly the selected `task`, `quick`, or `ship` mode. Do not turn execution into architecture work, delegate, or ask
for permission already granted by the explicit invocation.

Never create or modify a file outside the opened project unless the request explicitly names that external effect. Put
implicit scratch files, logs, screenshots, generated validation artifacts, and temporary copies under project-root
`.tmp/`, then remove them when no longer needed.

## Shared execution rules

- For `task` and `quick`, inspect the repository root, branch, HEAD, worktree, relevant source, loaded `AGENTS.md` files,
  current task/context, and available validation before editing. Preserve unrelated work.
- Implement the accepted result directly. Local syntax is yours; material ownership, API, schema, persistence,
  compatibility, scope, and sequencing are not yours to invent.
- If reality contradicts the accepted design or a material choice is absent, record the exact evidence and stop the task as
  `blocked` rather than guessing.
- Do not author tests, fixtures, mocks, snapshots, or test-only helpers unless the task explicitly requests test code.
- Complete one coherent implementation, inspect the real diff, map every acceptance condition to final evidence, and run
  proportional validation.
- Do not stage, commit, push, install, publish, or rewrite history except in explicit `ship` mode.

## `task`

Input is exactly one task ID shaped `YYYYMMDD-short-slug`.

1. Read `.tasks/open/<task-id>.md`. If absent, report that exact missing contract; if archived, report its terminal state.
2. `designing` is not executable. For `ready`, `active`, or `blocked`, inspect live reality and recheck recorded blockers.
3. Set executable work to `active`; invocation authorizes adopting current work, editing the accepted scope, validation,
   and task-state updates.
4. Respect a dependency only while its result remains a real prerequisite.
5. Update execution slices, current state, validation, and `index.md` after material progress.
6. When every acceptance condition is implemented and directly verified, mark `completed`, move the task to
   `.tasks/archive/YYYY-MM/`, and regenerate the index. Wait only for an explicitly named subjective review condition.

## `quick`

The supplied request authorizes one small, self-contained change. Inspect enough reality to prove there is no material
product or architecture decision. If one exists, make no product edit and report that Guide must design it. Otherwise
implement, self-review, validate, and report without durable task state.

## `ship`

The supplied text is the commit message; infer one concise English message from the current coherent change when blank.
Inspect repository root, branch, status, full and staged diffs, and recent commit style. Account for every dirty path, then
run the bundled `scripts/ship-project.sh` relative to this Skill with the repository root and chosen message.

`ship` explicitly authorizes staging all current changes, committing, and pushing the current branch. Honor hooks; never
amend, force-push, switch branches, discard work, install, release, or invoke a publishing hook. Report the commit and
remaining worktree state, or the exact failure.
