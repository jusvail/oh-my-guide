---
name: computer-use
description: Use when an accepted task requires observing or operating a local graphical application through the Peekaboo CLI.
---

# Computer Use

Use only after task qualification and only when GUI observation is an acceptance condition. Use the installed Peekaboo
CLI directly, but contain every invocation to process-local execution:

```sh
PEEKABOO_NO_REMOTE=1 peekaboo <command>
```

Do not start or use a daemon, Bridge, MCP server, or the agent subcommand. Never omit `PEEKABOO_NO_REMOTE=1`; if its
process-local permissions cannot observe or operate the application, report graphical validation blocked. This Skill
takes priority over debugging when Peekaboo cannot locate, address, or operate the target unless the user explicitly asks
to diagnose the integration.

## Target the exact application and window

Start the real product through its accepted repository entrypoint. For a long-running GUI entrypoint, detach its output so
Peekaboo commands can run normally:

```sh
mkdir -p .tmp
nohup <accepted-product-entrypoint> </dev/null >.tmp/<validation>-app.log 2>&1 &
```

Check process-local permissions and resolve the product application plus its renderable window:

```sh
PEEKABOO_NO_REMOTE=1 peekaboo permissions status --json
PEEKABOO_NO_REMOTE=1 peekaboo app list --json
PEEKABOO_NO_REMOTE=1 peekaboo window list --pid <pid> --json
```

Select the exact product PID and exact window title from the observed results. Never target another application or an
ambiguous window. Every observation and interaction must include that PID and window title.

## Observe and operate sequentially

Run Peekaboo commands one at a time and inspect each result before issuing the next. Do not background, group, pipe, use
`xargs`, or parallelize Peekaboo operations.

Use current semantic state and capture a current screenshot when visual state or coordinates are needed:

```sh
PEEKABOO_NO_REMOTE=1 peekaboo see --pid <pid> --window-title "<exact-window-title>" --tree --no-screenshot --json
PEEKABOO_NO_REMOTE=1 peekaboo see --pid <pid> --window-title "<exact-window-title>" --no-elements --path .tmp/<validation>-initial.png --json
```

Choose the interaction that matches the observed state:

```sh
PEEKABOO_NO_REMOTE=1 peekaboo action AXPress --on <element-id> --snapshot <snapshot-id> --pid <pid> --window-title "<exact-window-title>" --json
PEEKABOO_NO_REMOTE=1 peekaboo set-value <value> --on <element-id> --snapshot <snapshot-id> --pid <pid> --window-title "<exact-window-title>" --json
PEEKABOO_NO_REMOTE=1 peekaboo click --on <element-id> --snapshot <snapshot-id> --pid <pid> --window-title "<exact-window-title>" --json
PEEKABOO_NO_REMOTE=1 peekaboo click "<stable label>" --pid <pid> --window-title "<exact-window-title>" --json
PEEKABOO_NO_REMOTE=1 peekaboo type "<text>" --pid <pid> --window-title "<exact-window-title>" --foreground --json
PEEKABOO_NO_REMOTE=1 peekaboo press <key> --pid <pid> --window-title "<exact-window-title>" --foreground --json
```

For coordinate input, derive `--at` from the current screenshot of the exact target window. Coordinates remain
target-window-relative; never add `--global`:

```sh
PEEKABOO_NO_REMOTE=1 peekaboo click --pid <pid> --window-title "<exact-window-title>" --at <x,y> --json
```

Keep every screenshot, log, and generated validation artifact under project-root `.tmp/`. Record the observed GUI result
or the exact blocked condition, then remove temporary artifacts unless the user explicitly requests retention. Other
validation uses ordinary repository tools.
