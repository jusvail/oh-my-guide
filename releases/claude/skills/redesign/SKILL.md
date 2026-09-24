---
name: redesign
description: Redesign a structure from its accepted behavior inside the Guide conversation.
disable-model-invocation: true
argument-hint: "<objective>"
---

# Redesign

Objective: $ARGUMENTS

Follow the `guide` skill for this objective (invoke it if its instructions are not already loaded), with clean-slate
intent. Keep the accepted observable behavior, integrations, and real constraints. Treat today's types, files, call
graph, abstractions, and ownership split as evidence about the problem, not as the design to preserve. Derive the
coherent replacement, record it in the task together with what it removes, and hand off an executable task as Guide
does. Redesign stays design-only until the user runs `/task`.
