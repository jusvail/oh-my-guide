---
name: browser
description: Use when an accepted task needs one bounded browser interaction path to verify web behavior or capture web evidence.
---

# Browser

Use this Skill only when a concrete accepted task requires real browser interaction. Prefer ordinary web fetches for
read-only page content; use this Skill when navigation, interaction, rendered state, or a screenshot is the acceptance
evidence.

## Establish the path

Before opening a browser, name one target URL, one bounded acceptance path, its expected final state, and any action with
an external effect. Do not browse speculatively, explore unrelated routes, log in, upload, submit data, or trigger an
external side effect unless the accepted task explicitly requires that exact action.

Check that `agent-browser` is already available. If it is unavailable, report browser validation blocked; do not install
it, start a service, or substitute an authenticated or persistent browser.

## Isolated operation

Use one unique ephemeral session and operate it directly:

```bash
mkdir -p .tmp
agent-browser --session <task-run> open <url>
agent-browser --session <task-run> snapshot -i
agent-browser --session <task-run> click @<current-ref>
agent-browser --session <task-run> wait --url <expected-pattern>
agent-browser --session <task-run> screenshot .tmp/<task-run>-final.png
agent-browser --session <task-run> close
```

- Use the current accessibility snapshot and its semantic `@` reference for every interaction. Refresh the snapshot after
  navigation or a material DOM change; do not guess selectors or coordinates.
- Use a semantic wait for the declared expected state rather than arbitrary delays.
- Create project-root `.tmp/` before capture and keep every screenshot or browser artifact there. Remove temporary
  evidence after reporting unless the user explicitly requests retention.
- Close the session on success, failure, or blockage and report the cleanup result.

## Exclusions

Do not use `agent-browser install`, `--profile`, `--session-name`, `state save/load`, cookie or storage commands,
`--cdp`, extensions, cloud providers, stealth behavior, proxy bypass, or a user browser session. This Skill never creates
persistent browser state or a background service.

If the path cannot be completed with the declared target and current semantic evidence, stop and report the last verified
state. Do not widen the task or retry through another interaction channel.
