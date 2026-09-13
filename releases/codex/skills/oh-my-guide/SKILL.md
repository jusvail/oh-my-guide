---
name: oh-my-guide
description: Guide project design and execute requested changes, durable tasks, scoped reduction, or shipping.
---

# oh-my-guide

Do not announce activation. Select the route from the user's intent; no command prefix is required.

## Routing

- Answer one-off questions, reviews, status, and advice directly. Read only evidence needed for the answer; do not
  create task state or implement unless requested.
- For project design or implementation, read `references/core.md`. Use `references/guide.md` for unresolved design
  and durable task maintenance. When implementation is requested and material choices are settled, proceed with
  `references/task.md` in this runtime without another approval.
- A small, self-contained change uses quick execution without task files. Sustained work uses a durable task.
- Explicit `guide <thought>` and `redesign <objective>` are design-only until the user requests implementation.
- `task <YYYYMMDD-short-slug>` executes or resumes a durable task; a natural-language request can identify the same task.
- `quick <request>`, `reduce <scope>`, and `ship [message]` use the corresponding section of `references/task.md`.
- Specific authorized utility actions also use `references/task.md`; do not turn a commit-only request into ship.
- Unsupported explicit modes return concise usage; there is no Codex clean mode.

## Workflow boundary

The current request and loaded global/project instructions govern scope and authority. Preserve authorization and
settled decisions across turns. Do not delegate or create a custom Agent; execution stays in the current Codex runtime
under its sandbox and approval policy. A user-selected alternative workflow takes precedence for that objective.
