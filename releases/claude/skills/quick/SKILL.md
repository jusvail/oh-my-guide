---
name: quick
description: Make one small, self-contained change directly, without task state.
disable-model-invocation: true
argument-hint: "<request>"
---

# Quick change

Request: $ARGUMENTS

Running `/quick` authorizes this change now, without a task file or a design round. Make the local decisions yourself,
review your diff, run proportionate validation, and report the result.

If the work turns out not to be small and self-contained, or it needs a user-owned choice about product behavior,
architecture, scope, or compatibility, stop the part that depends on it and open a task for it with the `guide` skill,
which asks the question. Finish any independent part that is still in scope.
