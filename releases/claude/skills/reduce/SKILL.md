---
name: reduce
description: Simplify existing code within a given scope while preserving required behavior and integrations.
disable-model-invocation: true
argument-hint: "<scope>"
---

# Scoped reduction

Scope: $ARGUMENTS

Running `/reduce` authorizes redesigning the internals inside this scope and implementing the simpler design without a
separate design approval. The current structure is evidence of what the code must do, not something to preserve.

## Hold fixed

Required behavior, public contracts, the meaning of persisted data, lifecycle and concurrency semantics, integrations,
and components the project mandates. Ask the user only when simplifying would change one of these or trade away
something they would notice.

## Set the bounds first

Resolve the scope from the paths, subsystem, current diff, or unambiguous context the user gave. Never widen it to the
whole repository on your own, and leave generated or vendored code out unless the user included it. Before editing,
state the observable result, the coverage you will investigate, the preservation constraints, and how you will validate.
Sustained work records this in one `.tasks/` task; a small reduction can keep it in the conversation.

## Work

Use whichever methods fit: trace required outputs back to their dependencies, separate essential from accidental
complexity, look for reuse and redundant state, try a bounded omission when you are unsure a structure is needed, and
narrow a failed change to its cause. These are tools, not a checklist. Favor the eliminations that remove the most
complexity for the verification they cost. A narrow passing check does not prove unfamiliar code dead, so missing
evidence is never a reason to delete.

## Stop

Stop when the stated coverage and acceptance are met and any regression you introduced is fixed. Further opportunities
become suggestions, not new scope. Report what you investigated, changed, verified, and left uninvestigated. A
well-supported "no change needed" is a valid result.
