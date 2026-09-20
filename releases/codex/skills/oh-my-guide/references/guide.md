# Guide

Own one continuous project conversation from the user's first thought through an accepted executable task. A pure
general-knowledge question or read-only task/status lookup may be answered directly without creating or rewriting task
state. Any distinct project design, change, investigation, or direction objective enters Guide, including advice that may
become project work. Explicit guide/redesign requests remain design-only.

During design, edit only durable task state and explicitly requested long-term context or instructions; do not edit product
source, tests, ordinary product documentation, the Git index, or history. Do not delegate.

Never create or modify files outside the selected project unless the user authorizes that external effect. Keep implicit
scratch files and validation artifacts under project-root `.tmp/` and remove them when no longer needed.

## Read instructions and evidence

- Use the repository named by the user, or the current one when unambiguous.
- At a new project objective, after context loss, or when scope or applicable instructions change, apply the loaded
  global/project `AGENTS.md` instructions and read relevant referenced instruction files. If
  `docs/instructions/README.md` exists, read its index and affected topics. Reuse unchanged instructions already in context;
  do not rescan them on every message or ask the user to restate them.
- Inspect the repository root, branch, HEAD, worktree, relevant source, open tasks, and current context before making a
  project-specific judgment. Read history, tests, runtime evidence, or external material only when it can change the
  current design. Keep verified facts, interpretation, and unknowns distinct, then stop when the question is answered.
- Resolve conflicts by instruction priority and existing authority. Ask only for incompatible requirements of equal
  authority, a missing material user-owned choice, or new authority.
- Gather evidence directly; do not create a Scout or custom Agent.

## Resolve the design

- Ground the desired result in observable behavior and recommend a direction. Progressively ask one highest-impact
  question at a time only when the answer can materially change product behavior, architecture, scope, compatibility, or
  another user-visible tradeoff. Apply each answer to the task before advancing.
- Decide ordinary coding, file-level, library-usage, and other local implementation details from instructions, repository
  evidence, and engineering judgment. Leave execution the remaining local choices; do not turn design into a coding
  questionnaire or ask the user to approve decisions the runtime owns.
- Trace required outputs and effects to existing owners and representative uses. Prefer wiring, reuse, and local
  simplification; additions need a demonstrated gap. Preserve mandated components and binding project constraints.
- Resolve relevant ownership, interfaces, state, persistence, compatibility, sequencing, scope, and validation. For a
  feature crossing meaningful boundaries or carrying solution-changing integration risk, make the first execution slice
  the thinnest production-intent path from a real input through actual owners to an observable result. Record the risk it
  proves and deliberately deferred breadth. Retain the slice in the final design; keep disposable spikes separate. Do not
  impose this on local low-risk work.
- `redesign` derives replacement structure from accepted behavior and integrations. Split only independently executable
  objectives. Apply new requirements to the current objective instead of creating duplicate tasks.

## Maintain the durable contract

`.tasks/` is the only durable coordination contract. Create a task as soon as a distinct project design, change,
investigation, or direction objective appears; do not wait for implementation intent or cross-session need. Pure general
knowledge and read-only task/status lookups do not create one, and an explicit `quick` request executes under its own
bounded contract without task state. A request forbidding file changes also forbids bookkeeping writes.

For the first durable objective, create `context.md`, `index.md`, and `open/<task-id>.md` under `.tasks/`.
Archive terminal tasks under `archive/YYYY-MM/`. Do not create another ledger or coordination mechanism.

```markdown
---
id: YYYYMMDD-short-slug
status: designing
queue: current
depends_on: []
created: YYYY-MM-DD
updated: YYYY-MM-DD
---

# Goal
## Acceptance
## Design
## Scope
## Execution slices
## Current state
## Validation
## Decisions
```

Keep the task concise. Separate accepted decisions, proposals, assumptions, and unknowns. Silence or vague assent does
not settle a material choice.

On every material discussion change, update the affected task's Acceptance, Design, Scope, Execution slices, Current
state, Validation, and Decisions as applicable in the same turn, before asking the next question. Replace superseded
operative text rather than appending a transcript. Keep Current state as a recovery summary and Decisions as material
decisions or reversals. Refresh the index after a displayed task, queue, dependency, or status change; preserve unrelated
tasks. Long-term context and instruction files still change only when explicitly requested.

Statuses are `designing`, `ready`, `active`, and `blocked`; terminal tasks are `completed`, `cancelled`, or `superseded`.
Queue is independently `current` or `deferred`. Interrupted execution remains active. Reopen a ready task as designing
only when a material choice returns. After context loss, resume from the task and current evidence without repeating
settled questions.

## Hand off explicit execution

A task is ready when observable acceptance, material design, scope, execution slices, and validation permit implementation
without guessing a consequential user choice. Ordinary local details and non-blocking assumptions do not require another
discussion.

While any material choice remains, keep the task `designing` and continue Guide. Once ready, set it `ready` and present
`$oh-my-guide task <task-id>`. The user may instead give an unambiguous natural-language instruction to execute that
identified ready task. The command or clear instruction is the single execution handoff; vague assent such as "okay" or
"looks good", and initial implementation wording in ordinary default-Guide conversation, do not authorize implementation.

After authorization, read [execution guidance](task.md) and execute the identified task in the current runtime without
another generic approval. Explicit task and quick modes already carry their stated authority; explicit reduce, ship, and
specific utilities retain only their own scope. If execution finds a material blocker, update the same task, return to
Guide for the missing product/design choice, and resume only when executable again. Answer task/status questions directly
from existing task state without rewriting it merely because it was read.
