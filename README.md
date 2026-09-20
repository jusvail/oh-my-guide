# oh-my-guide

A project-independent workflow for OpenCode and Codex. Guide actively turns project thoughts into continuously updated,
instruction-aware tasks; execution completes an explicitly confirmed ready task. Natural language is sufficient.

## Request routing

- Pure general-knowledge questions and read-only task/status lookups receive direct answers without task writes.
- Any distinct project design, change, investigation, or direction objective enters Guide and creates or updates a task;
  initial implementation wording does not bypass design ownership.
- Guide asks one highest-impact material product/design question at a time and updates the task before advancing. Agents
  decide ordinary coding details from applicable instructions, repository evidence, and engineering judgment.
- A ready task executes after its task command or an unambiguous natural-language instruction naming that task. Vague
  assent does not authorize implementation. Explicit quick/task/reduce/utility modes retain their stated direct authority.
- Specific utility requests authorize only their named effects: a commit request does not imply a push.

At a new objective, context loss, or scope/instruction change, Guide and Task read applicable loaded/repository instructions
and the project instruction index plus affected topics when present. They reuse unchanged instructions, apply instruction
priority, and never ask the user to restate an available rule. Only unresolved material product, architecture, scope,
compatibility, or user-visible tradeoffs require a user decision.

## Durable work

`.tasks/` is the only durable ledger. Create a task as soon as a distinct project design, change, investigation, or
direction objective appears, not only when cross-session recovery becomes necessary. Pure general knowledge, read-only
status, and explicit quick work are the bounded exceptions. There are no execution locks, runtime owners, checkpoints, or
handoff records.

A task at `.tasks/open/YYYYMMDD-short-slug.md` records Goal, Acceptance, Design, Scope, Execution slices, Current state,
Validation, and concise Decisions. Status is designing, ready, active, or blocked; queue is independently current or
deferred. Terminal tasks move to `.tasks/archive/YYYY-MM/`.

Apply every material discussion change to the affected task in the same turn before asking the next question. Replace
superseded operative text and keep Current state as a recovery summary, not a transcript. Refresh the index when a displayed
entry changes. Context and instruction saves still require an explicit request; reading status alone does not rewrite it.

Mark a task ready only when acceptance, material design, scope, slices, and validation are executable without guessing a
user-owned choice. Guide then presents `/task <id>` or `$oh-my-guide task <id>`; that command or a clear instruction to
execute the identified ready task is the single confirmation handoff.

## Bounded execution and validation

Read applicable instructions before decisions and affected edits, reuse unchanged context, and check affected worktree
changes. Do not require full repository inventories or instruction rescans for every message.

Prefer verified reuse and local simplification. Mandated components are binding. Ordinary changes do not require a
reduction-method checklist. Tests and optional work follow the accepted task and project instructions.

When a new feature crosses meaningful boundaries or carries solution-changing integration risk, its first execution slice
is the thinnest retained production-intent path from a real input through actual owners to an observable result. The task
states the risk proved and breadth deferred; execution validates that boundary before expanding it. Local low-risk changes
do not acquire this tracer-slice ritual, and a disposable spike remains separate.

Explicit reduce authorizes internal architecture redesign within its scope while preserving required behavior,
public/data contracts, lifecycle semantics, integrations, and mandated components. State acceptance and coverage before
editing. Use tracing, omission experiments, or failure reduction only when useful. Stop after that coverage and acceptance
are satisfied and introduced regressions are resolved; additional opportunities become suggestions unless broader
exploration was requested. Report real coverage and verification limits without claiming global minimality.

Run proportional checks, expanding or repeating them only for changes, failures, or unresolved concerns. Perform available
objective GUI checks using applicable platform instructions and verified targets. Recovery addresses actual failures;
missing cosmetic indicators or a retry quota do not justify repeated restarts. Equivalent available tools may be used
when they preserve target identity, isolation, and required evidence.

Missing GUI access blocks only the corresponding evidence. Complete independent work, report the exact manual flow, and
leave an existing task active only if required evidence or explicitly requested subjective acceptance remains pending.
Do not poll for user review or claim that a build proves GUI equivalence.

## OpenCode

The release has three Agents:

- **Guide** owns user dialogue, instruction-aware design, and continuous task maintenance. It gathers routine evidence
  directly and calls Task only after the ready task is explicitly confirmed; it never edits product code itself.
- **Scout** returns one bounded evidence result when the value of delegated external, visual, build, or feasibility
  work justifies it.
- **Task** executes the authorized scope. It supports both direct use and invocation by Guide (`mode: all`);
  Guide's task permission allows only Scout and Task.

Default project work remains in Guide until the task handoff. Explicit utility commands remain available:

- `/guide <thought>`, `/redesign <objective>` — design only and continuously maintain the task.
- `/task <task-id>` — execute or resume a durable task.
- `/quick <request>` — execute a small change.
- `/reduce <scope>` — perform scoped reduction.
- `/ship [message]` — stage all current changes, commit, and push.
- `/clean [all]` — remove stale OpenCode Sessions, or every Session except the current one.

The mode and task permission configuration follow [OpenCode's agent configuration](https://opencode.ai/docs/agents/#mode).
Package defaults live in `preferences/core.md`; installed `preferences/user.md` remains user-owned. Browser, Debugging,
Git, and AST-Grep are available for concrete matching needs. Debugging continues when new evidence supports another
hypothesis; unavailable tools allow equivalent existing capabilities without weakening isolation or structural evidence.

## Codex

The release contains one Skill, `oh-my-guide`, and no custom Agent, plugin, slash command, or Scout runtime.
Installation adds a marked global instruction block that silently routes natural project requests into Guide. Pure general
knowledge and read-only status remain direct; project objectives create and continuously update tasks. Confirmed ready-task
implementation proceeds in the current runtime.

Explicit `$oh-my-guide guide`, `redesign`, `task`, `quick`, `reduce`, and `ship` remain optional shortcuts with the same
semantics as above. There is no Codex Session-cleaning mode. Skill instructions operate under Codex's sandbox and approval
policy; they cannot enforce OpenCode's per-Agent permissions.

The instructions target GPT-5.6 Sol and GPT-6 Astra without selecting a model. Codex uses the user's runtime choice;
the OpenCode recommended profile retains its existing settings. Static package checks and installation checks establish
structure and packaging, not model behavior or prompt efficacy.

## Install

Validate both release sources without installation:

```bash
bash scripts/install.sh --check
```

Install OpenCode additively into `~/.config/opencode`:

```bash
bash scripts/install.sh
```

Default installation updates only manifest-owned files and preserves unrelated Agents, commands, Skills, preferences,
plugins, instructions, and configuration. Explicit `bash scripts/install.sh --takeover` retains its replacement behavior.

Install only the Codex release:

```bash
bash scripts/install.sh --codex
```

Codex installation updates only `$HOME/.agents/skills/oh-my-guide`, its manifest, and one marked block at the start of the
active global `${CODEX_HOME:-$HOME/.codex}/AGENTS.override.md` or `AGENTS.md`. It preserves content outside that block,
Codex configuration, plugins, and project instructions. Editing this source repository does not update active installs.

Use project-local destinations for isolated installation checks:

```bash
OH_MY_GUIDE_OPENCODE_DIR="$PWD/.tmp/opencode" bash scripts/install.sh
OH_MY_GUIDE_CODEX_SKILLS_DIR="$PWD/.tmp/agents/skills" \
OH_MY_GUIDE_CODEX_DIR="$PWD/.tmp/codex" \
bash scripts/install.sh --codex
```

Restart the selected application after installation.
