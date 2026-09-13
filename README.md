# oh-my-guide

A project-independent workflow for OpenCode and Codex. Guide resolves intent and design; execution completes the
authorized result. Natural-language requests are sufficient. Use durable tasks only when cross-session recovery helps.

## Request routing

- Questions, reviews, status, and advice receive direct answers without implementation or task writes.
- Explicit guide/redesign requests stay design-only until the user requests implementation.
- A clear implementation request proceeds through material design decisions, implementation, and proportional validation
  without a command-prefix requirement or another generic approval.
- Small self-contained changes use quick execution. Sustained objectives use a concise durable task.
- Specific utility requests authorize only their named effects: a commit request does not imply a push.

Routine engineering choices and conflicts settled by instruction priority do not require user decisions. Ask only for
unresolved material choices, incompatible requirements of equal authority, or new authority. Preserve settled choices and
authorization across turns, and continue independent work when one part is blocked.

## Durable work

`.tasks/` is the only cross-session ledger. Use it for sustained objectives, explicit task preservation, and existing
task resumption, not every conversation. There are no execution locks, runtime owners, checkpoints, or handoff records.

A task at `.tasks/open/YYYYMMDD-short-slug.md` records Goal, Acceptance, Design, Scope, Execution slices, Current state,
Validation, and concise Decisions. Status is designing, ready, active, or blocked; queue is independently current or
deferred. Terminal tasks move to `.tasks/archive/YYYY-MM/`.

Merge material changes into one update per turn or execution batch and edit only affected sections. Refresh the index
only when its displayed entries change. Context and instruction saves still require an explicit request; natural language
is sufficient. Read task state when it helps resumption, without rewriting it merely to answer status.

## Bounded execution and validation

Read evidence and instructions relevant to the current question, reuse current context, and check affected worktree
changes before editing. Do not require repository inventories or history checks for every change.

Prefer verified reuse and local simplification. Mandated components are binding. Ordinary changes do not require a
reduction-method checklist. Tests and optional work follow the accepted task and project instructions.

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

- **Guide** owns user dialogue and design. It gathers routine evidence directly and calls Task when implementation or
  a utility is authorized; it never edits product code itself.
- **Scout** returns one bounded evidence result when the value of delegated external, visual, build, or feasibility
  work justifies it.
- **Task** executes the authorized scope. It supports both direct use and invocation by Guide (`mode: all`);
  Guide's task permission allows only Scout and Task.

Guide passes a small change as quick with its scoped request, or sustained work as task with its durable ID, authority,
and evidence anchors. Explicit utility commands remain available:

- `/guide <thought>`, `/redesign <objective>` — design only until implementation is requested.
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
Installation adds a marked global instruction block that routes natural requests silently. One-off answers stay direct;
project work loads the relevant design or execution guidance. Authorized implementation proceeds in the current runtime.

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
