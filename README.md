# oh-my-guide

A project-independent, evidence-grounded workflow for OpenCode and Codex. Guide owns intent and design; durable tasks
separate accepted architecture from execution.

## Shared workflow

- **Guide** owns the user conversation, evidence synthesis, solution architecture, project knowledge, and durable task
  contract. It does not edit product code.
- **Task execution** adopts an accepted contract, edits its complete scope, and validates the final worktree without
  inventing material product decisions.
- `.tasks/` is the only cross-session ledger. There are no execution locks, Session owners, checkpoints, handoff states,
  or paused tasks.

Each independently executable objective uses `.tasks/open/YYYYMMDD-short-slug.md` with Goal, Acceptance, Design, Scope,
Execution slices, Current state, Validation, and concise Decisions. Status is `designing`, `ready`, `active`, or `blocked`;
queue is independently `current` or `deferred`. Terminal tasks move to `.tasks/archive/YYYY-MM/`.

## OpenCode

The OpenCode release remains built around three Agents:

- **Guide** performs routine inspection directly and invokes the bounded **Scout** only for material external, visual,
  build, or feasibility evidence whose value justifies delegation.
- **Scout** returns evidence without owning design, implementation, or user dialogue.
- **Task** is the execution engine for accepted work and explicit utility commands.

Commands remain unchanged:

- `/guide <thought>` and `/redesign <objective>` — continue design.
- `/task <task-id>` — execute an accepted durable task.
- `/quick <request>` — execute one small, self-contained change.
- `/ship [message]` — inspect, stage, commit, and push.
- `/clean [all]` — remove stale OpenCode Sessions or every Session except the current one.

OpenCode package defaults live in `preferences/core.md`; the installed `preferences/user.md` remains user-owned. Its four
on-demand Skills are Browser, Debugging, Git, and AST-Grep.

## Codex

The Codex release contains one Skill, `oh-my-guide`, and no custom Agent, plugin, slash command, or Scout runtime.
Installation adds a marked block to the active global Codex instruction file so every fresh conversation silently starts
in Guide. The user enters only the natural request—no Skill prefix, bootstrap prompt, or activation message is required.

Explicit modes are available when Guide has made work executable:

- `$oh-my-guide redesign <objective>` — derive replacement structure from accepted behavior.
- `$oh-my-guide task <task-id>` — accept and execute one durable task.
- `$oh-my-guide quick <request>` — execute one bounded decision-free change.
- `$oh-my-guide ship [message]` — inspect, stage, commit, and push.

Codex Skills cannot enforce OpenCode-style per-Agent tool permissions, so Guide-versus-execution separation is an
instruction contract under Codex's sandbox and approval policy. Codex has no oh-my-guide Session-cleaning mode.

### Superpowers compatibility

Superpowers does not need to be uninstalled. Default Guide owns process selection, preventing automatic Superpowers
brainstorming, planning, TDD, worktree, subagent, review, and branch-finishing workflows from creating a competing process
for the same objective. Explicitly invoking a Superpowers Skill or asking to use Superpowers suspends oh-my-guide for that
objective, so the plugin remains available without either package modifying the other.

## Install

Validate both release sources without installation:

```bash
bash scripts/install.sh --check
```

Install OpenCode additively into `~/.config/opencode`:

```bash
bash scripts/install.sh
```

Default OpenCode installation updates only manifest-owned files and preserves unrelated Agents, commands, Skills,
scripts, Preferences, plugins, instructions, and `opencode.json`. Explicit takeover keeps its existing behavior:

```bash
bash scripts/install.sh --takeover
```

Install only the Codex release:

```bash
bash scripts/install.sh --codex
```

Codex installation updates only `$HOME/.agents/skills/oh-my-guide`, its package manifest, and one marked block at the
start of the active global `${CODEX_HOME:-$HOME/.codex}/AGENTS.override.md` or `AGENTS.md`. It preserves all content outside
that block and never edits Codex configuration, plugins, project instructions, or Superpowers files.

Use project-local destinations for isolated installation checks:

```bash
OH_MY_GUIDE_OPENCODE_DIR="$PWD/.tmp/opencode" bash scripts/install.sh
OH_MY_GUIDE_CODEX_SKILLS_DIR="$PWD/.tmp/agents/skills" \
OH_MY_GUIDE_CODEX_DIR="$PWD/.tmp/codex" \
bash scripts/install.sh --codex
```

Restart the selected application after installation.
