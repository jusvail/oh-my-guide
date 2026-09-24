---
name: debugging
description: Use when a bug, build failure, runtime exception, unexpected behavior, or failing check must be diagnosed before changing the implementation.
---

# Debugging

Find the root cause before changing code. A fix aimed at the symptom leaves the cause in place and usually hides it.

## Establish the failure

1. Read the complete error, warning, stack trace, and affected runtime state.
2. Reproduce the symptom with exact steps. If it does not reproduce, collect the missing evidence instead of guessing.
3. Inspect the relevant current diff, configuration, environment, and recent changes.

## Locate the source

1. Trace the symptom's data, calls, resources, or state backward to the owner that introduced it.
2. Find the closest working implementation in the repository and compare only the material differences.
3. For a multi-component path, observe the input, output, configuration, and state at each boundary before choosing a
   fix.

## Test one hypothesis

State one specific hypothesis: "X is the root cause because Y". Use the cheapest observation or reversible experiment
that changes one variable and can confirm or reject it. If it fails, discard that direction and return to the evidence
instead of stacking a workaround on it.

## Fix and confirm

Fix the real owner within scope, then rerun the original observation and the final-worktree checks the change needs. If
the failure remains, revise the hypothesis with the new evidence and continue. Stop when no useful evidence-gathering
step remains, necessary access or information is missing, or the next step would change scope or need new authority;
report the failed assumption and the remaining gap. Do not repeat the same repair without new evidence.
