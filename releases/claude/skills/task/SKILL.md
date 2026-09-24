---
name: task
description: Execute one ready task from `.tasks/open/` by ID.
disable-model-invocation: true
argument-hint: "<task-id>"
---

# Execute a task

Task ID: $ARGUMENTS

Running `/task` is the user's go-ahead for this task: its accepted edits, validation, and task-file updates, with no
further approval round. It does not cover commit, push, publish, or global install; those need their own request.

## Start

1. Read `.tasks/open/<task-id>.md`. Without an ID, proceed only when exactly one open task is ready or active and name
   it; if several fit, ask which. If the file is missing or the task is archived, report that instead of recreating or
   rerunning it.
2. A `designing` task is not executable yet: say what is still open and continue with the `guide` skill. For `ready`,
   `active`, or `blocked`, confirm that recorded blockers and dependencies are really resolved.
3. Set the task `active` and refresh `.tasks/index.md`. Read the instructions that govern the affected paths and check
   the worktree for changes you need to account for before editing.

## Execute

- Work through the execution slices in order. A tracer slice comes first: build its path from a real input through the
  actual owners to an observable result, validate the boundary it exists to prove without mocking that boundary away,
  then add the deferred breadth on top of it.
- Local implementation choices are yours. Keep the task's recorded decisions and any components the project mandates.
- If a user-owned choice surfaces that the task does not settle, stop the work that depends on it, record the question
  in the task with status `designing` or `blocked`, and ask it the way Guide does. Keep going on independent work.
- Update `Execution slices` and `Current state` at batch boundaries rather than after every edit, so compaction or
  `/clear` can resume from the file.

## Finish

1. Review the full diff for scope creep, unnecessary structure, and duplicated state, and fix regressions you
   introduced.
2. Map every acceptance condition to evidence from the final worktree. Re-run checks only where code changed or a
   concern remains.
3. When everything is verified, set `completed`, move the file to `.tasks/archive/YYYY-MM/`, and refresh the index.
4. If explicitly required subjective review or evidence you cannot obtain remains, keep the task `active`, record the
   pending condition, report the exact manual flow, and end the turn instead of waiting.
