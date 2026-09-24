---
name: guide
description: Default workflow for project work. Use when the user brings a project objective (a feature, change, bug to investigate, refactor, or direction question) to turn it into a durable `.tasks/` task, settle the user-owned decisions one at a time, and hand off a ready task for `/task`. Not for general-knowledge questions or quick lookups.
argument-hint: "[thought]"
---

# Guide

Guide is the design half of the workflow. It takes a rough project thought to a task that can be executed without
guessing anything the user should decide, and keeps that task current as the conversation moves. Execution comes later,
after the user's explicit go-ahead and possibly in a fresh context that sees only the task file, so the task has to stand
on its own.

## Stay in design

While designing, write only under `.tasks/`, plus project instructions or long-term context the user explicitly asks you
to save. Read anything and run read-only commands freely, but leave product source, tests, documentation, the Git index,
and history untouched. Code written before the user's choices are settled turns an open question into sunk cost and
quietly decides it for them.

When a feasibility question needs modified code or a build, experiment on a copy in the session scratchpad or in a
separate git worktree, never in the working tree, and record the result in the task.

## Ground the design in evidence

At a new objective, after compaction or `/clear`, or when the scope moves, read what governs the decision: the loaded
`CLAUDE.md` or `AGENTS.md`, the `docs/instructions/` topics for the affected paths when that index exists, the relevant
code, and `.tasks/index.md` with any related open task. Reuse what is already in context instead of rescanning every
turn. Read history, tests, runtime output, or external sources when they can change the design, and stop once the design
question is answered. Keep verified facts, your interpretation, and open unknowns visibly separate in the task.

Project instructions are binding defaults. When one already answers a question, apply it; never ask the user to restate
a rule that is written down.

## Keep the task current

`.tasks/` is the only durable record of the work. It is what survives compaction, `/clear`, and a switch between Claude
Code and Codex. Create the task as soon as a distinct objective appears, before your first question, instead of waiting
for implementation intent. "Should oh-my-guide adopt tracer bullets?", "exports got slow, find out why", and "add dark
mode" each get a task; "what does `git log -S` do?", "where is the config loaded?", and "what's ready?" get a direct
answer. A request that forbids file changes also forbids task writes.

The first task in a project also creates `.tasks/index.md` and a `.tasks/context.md` holding only a heading;
`context.md` is for long-term project context the user explicitly asks to save, while task facts belong in the task.
Tasks live at `.tasks/open/YYYYMMDD-short-slug.md` and follow the template at `${CLAUDE_SKILL_DIR}/assets/task.md`; the
index lists open tasks by queue and status, and terminal tasks move to `.tasks/archive/YYYY-MM/`.

Update the task in the same turn as any material change to requirements, design, scope, slices, validation, decisions,
or readiness, and before asking the next question, so the file never lags the conversation. Rewrite superseded text in
place; the task is a contract, not a transcript. Keep `Current state` a short recovery summary and `Decisions` a dated
list of material decisions and reversals. Record something as a decision only when the user actually chose it; until then
the task marks it as a proposal or an assumption. Refresh the index when a listed task, status, queue, or dependency
changes. New requirements for the same objective go into its existing task.

Statuses are `designing`, `ready`, `active`, and `blocked`, ending in `completed`, `cancelled`, or `superseded`. `queue`
is separately `current` or `deferred`. Answering a status question from the task files does not rewrite them.

## Decide or ask

Split every open question by owner. Ordinary coding, file, and library choices are yours: make them from the
instructions, the code, and engineering judgment, and record the consequential ones in the design. Product behavior,
architecture, scope, compatibility, and user-visible tradeoffs belong to the user whenever the evidence and instructions
leave them open.

This skill relies on asking. Auto mode's bias toward proceeding on assumptions does not apply to a user-owned choice;
leave it open until the user decides. Ask one question at a time, the one whose answer changes the most, with your
recommendation first and the tradeoff in a sentence. Use AskUserQuestion when the options are discrete. Apply each answer
to the task before asking the next.

## Shape the design

- Trace each required output or effect to the code that owns it today and to representative callers. Prefer wiring,
  reuse, and local simplification; an addition needs a demonstrated gap.
- Resolve whichever of ownership, interfaces, state, persistence, compatibility, sequencing, and validation matter
  here, and skip the rest.
- When a feature crosses meaningful boundaries or carries integration risk that could change the solution, make the
  first execution slice a tracer: the thinnest production-intent path from a real input through the actual owners to an
  observable result. Record the risk it proves and the breadth it defers. It stays in the final code; a throwaway spike
  is a separate tool. Local, low-risk work gets ordinary slices.
- Split the objective into separate tasks only when the parts can be executed independently.

## Hand off

A task is `ready` when its acceptance, design, scope, execution slices, and validation let someone implement it without
guessing a user-owned choice. Open local details and non-blocking assumptions do not hold it back.

When it is ready, set the status, refresh the index, present `/task <task-id>` with a short summary of what execution
will do, and end your turn. This is the user's one checkpoint to review the whole contract before code changes. If the
user instead plainly tells you to execute this ready task, read `${CLAUDE_SKILL_DIR}/../task/SKILL.md` and follow it for
that task. Agreement with the design ("looks good") is not that instruction.

If execution later hits a user-owned choice, the task returns to `designing` and Guide resumes from the task file
without re-asking anything already settled.
