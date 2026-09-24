# oh-my-guide

A project-independent workflow for Claude Code and Codex. Guide actively turns project thoughts into continuously updated,
instruction-aware tasks; execution completes an explicitly confirmed ready task. Natural language is sufficient.

## Request routing

- Pure general-knowledge questions and read-only lookups receive direct answers without task writes.
- Any distinct project design, change, investigation, or direction objective enters Guide and creates or updates a task;
  initial implementation wording does not bypass design ownership.
- Guide asks one highest-impact material product/design question at a time and updates the task before advancing. Agents
  decide ordinary coding details from applicable instructions, repository evidence, and engineering judgment.
- A ready task executes after its task command or an unambiguous natural-language instruction naming that task. Vague
  assent does not authorize implementation. Explicit quick/task/reduce/utility modes retain their stated direct authority.
- Specific utility requests authorize only their named effects: a commit request does not imply a push.

At a new objective, context loss, or scope/instruction change, Guide and execution read applicable loaded/repository
instructions and the project instruction index plus affected topics when present. They reuse unchanged instructions,
apply instruction priority, and never ask the user to restate an available rule. Only unresolved material product,
architecture, scope, compatibility, or user-visible tradeoffs require a user decision.

## Durable work

`.tasks/` is the only durable ledger, shared by both runtimes. Create a task as soon as a distinct project design, change,
investigation, or direction objective appears, not only when cross-session recovery becomes necessary. Pure general
knowledge, read-only lookups, and explicit quick work are the bounded exceptions. There are no execution locks, runtime
owners, checkpoints, or handoff records.

A task at `.tasks/open/YYYYMMDD-short-slug.md` records Goal, Acceptance, Design, Scope, Execution slices, Current state,
Validation, and concise Decisions. Status is designing, ready, active, or blocked; queue is independently current or
deferred. Terminal tasks move to `.tasks/archive/YYYY-MM/`.

Apply every material discussion change to the affected task in the same turn before asking the next question. Replace
superseded operative text and keep Current state as a recovery summary, not a transcript. Refresh the index when a displayed
entry changes. Context and instruction saves still require an explicit request; reading status alone does not rewrite it.

Mark a task ready only when acceptance, material design, scope, slices, and validation are executable without guessing a
user-owned choice. Guide then presents `/task <id>` in Claude Code or `$oh-my-guide task <id>` in Codex; that command or a
clear instruction to execute the identified ready task is the single confirmation handoff.

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
objective GUI checks using applicable platform instructions and verified targets. Missing GUI access blocks only the
corresponding evidence. Complete independent work, report the exact manual flow, and leave an existing task active only
if required evidence or explicitly requested subjective acceptance remains pending. Do not poll for user review or claim
that a build proves GUI equivalence.

## Claude Code

The release contains eight personal Skills and one marked block in the global `CLAUDE.md`. It adds no Agent, plugin,
hook, output style, or settings change.

- The `CLAUDE.md` block routes project objectives into Guide without a command and carries the engineering preferences.
  It omits rules Claude Code already enforces, such as commit authority and scratch-file placement.
- `guide` is the only workflow Skill Claude invokes on its own. It runs in the main conversation, writes only `.tasks/`
  while designing, and states that it relies on asking, so auto mode does not turn user-owned choices into assumptions.
- `/redesign`, `/task`, `/quick`, `/reduce`, and `/ship` are user-only (`disable-model-invocation`), so Claude cannot start
  execution by itself. `/ship` pre-approves only `git add -A`, `git commit`, and `git push`.
- `debugging` and `ast-grep` load when their descriptions match the work.

Commands:

- `/guide <thought>`, `/redesign <objective>` — design only, continuously maintaining the task.
- `/task <task-id>` — execute or resume a ready task. A task file is the whole contract, so `/clear` followed by
  `/task <task-id>` executes it in a fresh context.
- `/quick <request>` — execute a small change.
- `/reduce <scope>` — perform scoped reduction.
- `/ship [message]` — stage all current changes, commit, and push.

Claude Code's `cleanupPeriodDays` setting handles old transcripts. The text is written for current Claude models: each
rule is stated once with its reason, and Claude Code's built-in behavior is not restated.

## Codex

The release contains one Skill, `oh-my-guide`, and no custom Agent, plugin, or slash command. Installation adds a marked
global instruction block that silently routes natural project requests into Guide. Pure general knowledge and read-only
lookups remain direct; project objectives create and continuously update tasks. Confirmed ready-task implementation
proceeds in the current runtime.

Explicit `$oh-my-guide guide`, `redesign`, `task`, `quick`, `reduce`, and `ship` remain optional shortcuts with the same
semantics as above. Skill instructions operate under Codex's sandbox and approval policy.

The Codex instructions target GPT-5.6 Sol and GPT-6 Astra without selecting a model; Codex uses the user's runtime choice.
Static package checks and installation checks establish structure and packaging, not model behavior or prompt efficacy.

## Install

Validate both release sources without installation:

```bash
bash scripts/install.sh --check
```

Install the Claude Code release globally:

```bash
bash scripts/install.sh --claude
```

Claude Code installation writes the Skills into `${CLAUDE_CONFIG_DIR:-$HOME/.claude}/skills/`, records them in
`.oh-my-guide-manifest` there, and places one marked block at the start of `CLAUDE.md` in the same directory. It refuses to
replace a same-named Skill it does not own, removes Skills it owned that the release no longer ships, and preserves other
Skills, content outside the block, settings, and plugins.

Install the Codex release:

```bash
bash scripts/install.sh --codex
```

Codex installation updates only `$HOME/.agents/skills/oh-my-guide`, its manifest, and one marked block at the start of the
active global `${CODEX_HOME:-$HOME/.codex}/AGENTS.override.md` or `AGENTS.md`. It preserves content outside that block,
Codex configuration, plugins, and project instructions.

Editing this source repository does not update active installs; rerun the target after changes. Use project-local
destinations for isolated installation checks:

```bash
OH_MY_GUIDE_CLAUDE_DIR="$PWD/.tmp/claude" bash scripts/install.sh --claude
OH_MY_GUIDE_CODEX_SKILLS_DIR="$PWD/.tmp/agents/skills" \
OH_MY_GUIDE_CODEX_DIR="$PWD/.tmp/codex" \
bash scripts/install.sh --codex
```

Start a new session of the selected application after installation.
