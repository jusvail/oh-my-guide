---
name: ast-grep
description: Use when code search or a deterministic rewrite depends on syntax shape (a declaration, call, import, class, or control-flow form) rather than text or symbol lookup.
---

# AST-Grep

Use AST-Grep when the question depends on parsed source structure. Use `rg` for strings, comments, filenames, and
regular expressions, and symbol navigation for definitions and references.

## Availability

Use an installed `ast-grep` executable. Other programs named `sg` may be unrelated tools, so call `ast-grep` by that
name. If it is missing, use another syntax-aware tool or bounded manual inspection that establishes the same matches and
transformation. Text search can find candidates but does not prove a structural rewrite safe. Installing packages or
creating tooling needs the user's request; if equivalent evidence is out of reach, report that the search or rewrite is
blocked.

Patterns are code, not regular expressions. `$NAME` captures one node and `$$$` a sequence of nodes. Single-quote
patterns in the shell so `$` survives.

## Search and rewrite

Search before changing anything:

```bash
ast-grep run --pattern '<code-shaped pattern>' --lang <language> <path>
```

For a rewrite, preview the exact matches and the replacement, then apply:

```bash
ast-grep run --pattern '<pattern>' --rewrite '<replacement>' --lang <language> --json=compact <path>
ast-grep run --pattern '<pattern>' --rewrite '<replacement>' --lang <language> --update-all <path>
```

`--json` only previews. Apply with `--update-all` once the preview is right, then inspect the real diff and run the
relevant checks. If the pattern does not parse, matches an unexpected scope, or cannot express the transformation
precisely, stop instead of applying a broader rewrite. Reusable rules, codemod infrastructure, and project configuration
are in scope only when the task asks for them.
