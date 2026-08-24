# oh-my-guide contributor instructions

Keep this package project-independent and make only the requested bounded change.

## Canonical package

- `.opencode/agents/` owns exactly Guide, Scout, and Task.
- `.opencode/commands/` owns exactly Guide, Redesign, Task, Quick, Ship, and Clean.
- `.opencode/skills/` owns only the five generic on-demand Skills.
- `preferences/core.md` owns package defaults; the installed `preferences/user.md` is user-owned and must be preserved.
- `releases/opencode/profiles/recommended/opencode.json` is installed only by takeover mode.
- `scripts/install.sh` is the only package installation entry point.

Do not add a reasoning-phase command, another Agent, a framework profile, project path, compatibility alias, execution
lock, checkpoint, runtime owner, or routine acceptance gate. Guide owns design; Scout returns bounded evidence; Task
executes accepted work.

Do not write outside the opened repository unless the user explicitly requests that external effect. Put every implicit
scratch copy, screenshot, log, and generated validation artifact under root `.tmp/` and remove it after use.

## Validation

Run `bash scripts/install.sh --check` after package changes. Exercise installation only against a project-root `.tmp/`
destination selected through `OH_MY_GUIDE_OPENCODE_DIR`; never install into the real home directory unless the user
explicitly requests it. Do not stage, commit, push, or write Git history without explicit authority.
