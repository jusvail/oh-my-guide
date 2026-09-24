---
name: oh-my-guide
description: Guide project thoughts into evolving tasks and execute explicitly authorized task, quick, reduce, or ship work.
---

# oh-my-guide

Do not announce activation. Read `references/core.md`, then select exactly one route. No command prefix is required to
enter the default Guide conversation.

## Routing

- With no explicit mode, use `references/guide.md`. A pure general-knowledge question or read-only task/status lookup may
  remain direct, but a distinct project design, change, investigation, or direction objective enters Guide and maintains
  durable task state. Initial implementation wording does not skip Guide's ready-task handoff.
- Explicit `guide <thought>` and `redesign <objective>` use `references/guide.md` and remain design-only.
- `task <YYYYMMDD-short-slug>` uses `references/task.md` to execute or resume that ready task. An unambiguous natural-
  language instruction to execute an identified ready task is equivalent; vague assent is not.
- Explicit `quick <request>`, `reduce <scope>`, and `ship [message]` use their sections of `references/task.md` and carry
  only their stated authority. Specific utility requests also use execution guidance without expanding their effects.
- Unsupported explicit modes return concise usage.

## Workflow boundary

The current request and applicable loaded global/project instructions govern scope and authority. Read referenced project
instructions when relevant and never ask the user to repeat an available rule. Preserve settled decisions across turns.
Do not delegate or create a custom Agent; execution stays in the current Codex runtime under its sandbox and approval
policy. A user-selected alternative workflow takes precedence for that objective.
