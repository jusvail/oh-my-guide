# oh-my-guide

A project-independent OpenCode workflow built around one continuous Guide, one bounded Scout, and one execution-focused
Task.

## Architecture

- **Guide** owns the user conversation, evidence synthesis, solution architecture, project knowledge, and the durable
  task contract. It does not edit product code.
- **Scout** is Guide's hidden evidence worker. It reads product repositories and may use a disposable project-root
  `.tmp/` copy for a bounded build, experiment, or feasibility proof; it never owns the design or edits product paths
  outside that scratch root.
- **Task** executes accepted durable tasks and the explicit Quick, Ship, and Clean utility modes. It does not invent a
  missing material product or architecture decision.

Discovery and deeper reasoning happen inside Guide. The user stays in one design conversation until the task is ready.

## Commands

- `/guide <thought>` — continue interactive, evidence-grounded design.
- `/redesign <objective>` — preserve accepted behavior while deriving a replacement structure with the same Guide.
- `/task <task-id>` — start or adopt one accepted durable task.
- `/quick <request>` — execute one small, self-contained change without durable task state.
- `/ship [message]` — inspect, stage all current changes, commit, and push without implicit installation or release.
- `/clean [all]` — remove stale OpenCode Sessions, or every Session except the current one.

Task lists and status, project Context, global user Preferences, and project Instructions are natural-language Guide
capabilities. Writes require explicit words such as “save”, “remember”, “defer”, “cancel”, or “supersede”.

Agents never write outside the opened project unless the user's current request explicitly names that external effect.
All implicit scratch copies, screenshots, logs, and generated validation files live under project-root `.tmp/` so the
same contract works across operating systems.

## Durable tasks

Each independently executable objective uses one `.tasks/open/YYYYMMDD-short-slug.md` file containing Goal, Acceptance,
Design, Scope, Execution slices, Current state, Validation, and concise material Decisions. Status is `designing`,
`ready`, `active`, or `blocked`; queue is independently `current` or `deferred`. Completed, cancelled, and superseded
tasks move to `.tasks/archive/YYYY-MM/`.

There are no execution locks, Session owners, recovery snapshots, handoff states, or paused tasks. A fresh
`/task <task-id>` adopts `ready`, `active`, or `blocked` work from the live repository. Successful objective and validation
completion archives the task automatically unless its contract explicitly requires subjective user review.

Project context lives in `.tasks/context.md`. Project-specific instructions live in `docs/instructions/`. Package-owned
engineering defaults install as `preferences/core.md`; explicit global user corrections live in the separately owned
`preferences/user.md`.

## Skills

Task and Scout can load five generic Skills on demand: Debugging, Browser, Computer Use, Git, and AST-Grep. Optional tool
executables are installed separately by the user.

## Install

Validate without writing outside the repository:

```bash
bash scripts/install.sh --check
```

Install additively into `~/.config/opencode`:

```bash
bash scripts/install.sh
```

Default installation updates only files recorded in the package manifest. It preserves unrelated Agents, commands,
Skills, scripts, Preferences, plugins, instructions, and `opencode.json`. Agent files do not prescribe models, so the
user's current OpenCode model remains authoritative.

Explicit takeover replaces global Agent, command, and Skill directories and writes the recommended model profile:

```bash
bash scripts/install.sh --takeover
```

Takeover still touches only the selected global OpenCode root. It never modifies a project repository and preserves
`preferences/user.md`. Set `OH_MY_GUIDE_OPENCODE_DIR="$PWD/.tmp/opencode"` to validate against a project-local isolated
destination.

Restart OpenCode after installation.
