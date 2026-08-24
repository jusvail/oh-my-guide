---
name: ast-grep
description: Use when an accepted task needs AST-aware code search or a deterministic structural rewrite rather than text search or symbol navigation.
---

# AST-Grep

Use AST-Grep when the question depends on source syntax shape: a function declaration, call, import, class, control-flow
form, or another parsed construct. Use `rg` for strings, comments, filenames, and regular-expression text search; use LSP
for definitions, references, and symbol meaning.

## Availability and scope

Use an already installed `ast-grep` executable. If it is unavailable, report the structural search or rewrite blocked; do
not install a package, add a helper script, or substitute a text rewrite. Keep the query and paths inside the accepted
task scope.

Patterns are code, not regular expressions. Use `$NAME` for one captured node and `$$$` for a sequence of nodes. Quote
patterns in the shell so its `$` characters are preserved.

## Search and rewrite

Search before changing anything:

```bash
ast-grep run --pattern '<code-shaped pattern>' --lang <language> <path>
```

For a rewrite, preview the exact matches first. Inspect the affected paths and the proposed replacement before applying:

```bash
ast-grep run --pattern '<pattern>' --rewrite '<replacement>' --lang <language> --json=compact <path>
ast-grep run --pattern '<pattern>' --rewrite '<replacement>' --lang <language> --update-all <path>
```

`--json` is preview evidence, not a write. Use `--update-all` only after the preview is correct. Then inspect the real
diff and run the accepted validation. If the pattern does not parse, finds an unexpected scope, or cannot express the
desired transformation precisely, stop rather than applying a broader rewrite.

Do not create reusable rules, codemod infrastructure, or project configuration unless the accepted task explicitly asks
for them.
