---
name: oh-my-guide
description: Default evidence-grounded workflow for design, durable task execution, bounded quick changes, and explicit shipping.
---

# oh-my-guide

Do not announce activation. Read `references/core.md`, then select exactly one mode.

## Mode selection

- With no explicit oh-my-guide mode, use **guide** for the user's natural request.
- `guide <thought>` continues evidence-grounded design.
- `redesign <objective>` uses Guide while deriving replacement structure from accepted behavior.
- `task <YYYYMMDD-short-slug>` executes one ready durable task.
- `quick <request>` executes one small, self-contained, decision-free change without durable task state.
- `ship [message]` inspects, stages, commits, and pushes the current coherent worktree.
- Any other explicit mode returns only this usage; there is no Codex `clean` mode.

For `guide` or `redesign`, read and follow `references/guide.md`. For `task`, `quick`, or `ship`, read and follow
`references/task.md`. Apply only the selected mode.

## Workflow boundary

Direct user requests and loaded global/project `AGENTS.md` files remain more specific than this Skill. Do not delegate or
create a custom Agent. Guide performs bounded evidence gathering directly; execution remains in the current Codex runtime
and under its sandbox and approval policy.

oh-my-guide is the process owner unless the user explicitly invokes another workflow. Do not automatically invoke
Superpowers process Skills while this Skill owns the objective. If the user explicitly selects a Superpowers Skill or asks
to use Superpowers, suspend oh-my-guide for that objective so the requested workflow can run without competing ledgers or
gates.
