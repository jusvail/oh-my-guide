---
name: debugging
description: Use when a bug, build failure, runtime exception, unexpected behavior, or validation failure must be diagnosed before changing the implementation.
---

# Debugging

Find the root cause before proposing a fix. A symptom-level change is not a diagnosis.

## Establish the failure

1. Read the complete error, warning, stack trace, and affected runtime state.
2. Reproduce the symptom with exact steps. If it is not reproducible, collect the missing evidence instead of guessing.
3. Inspect the relevant current diff, configuration, environment, and recent changes.

## Locate the source

1. Trace the symptom's data, calls, resources, or state backward to the owner that introduced it.
2. Find the closest working implementation in the current repository and compare only material differences.
3. For a multi-component path, observe the input, output, configuration, and state at each boundary before choosing a fix.

## Test one hypothesis

State one specific hypothesis: `X is the root cause because Y`. Use the cheapest observation or reversible prototype that
changes one variable and can confirm or reject it. If it fails, discard that direction and return to the evidence; do not
stack another workaround on it.

## Correct and validate

Fix the real owner within the accepted scope, then rerun the original observation and the proportional final-worktree
verification required by the engineering preference contract. After one evidence-based repair and rerun still leaves the
same failure, stop and report the observed facts, failed assumption, and remaining gap.

Do not require TDD, agent-authored product tests, monitoring, retries, compatibility, or defensive work unless the current
request, accepted contract, or concrete in-scope failure requires it.
