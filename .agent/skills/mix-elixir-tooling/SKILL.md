---
name: mix-elixir-tooling
description: Use when editing or finishing Elixir (.ex, .exs) files. Guides when to run mix format, mix credo, and mix compile --warnings-as-errors to keep code formatted, lint-clean, and warning-free in Elixir/Phoenix projects.
---

# Mix Elixir Tooling

**Resumo (pt-BR):** Após editar arquivos Elixir, rodar format, credo e compile com warnings-as-errors. Usar mix precommit quando o projeto definir esse alias.

When working on Elixir files, use the Mix toolchain to keep code consistent and error-free.

## When to Use

- After editing any `.ex` or `.exs` file
- Before committing Elixir changes
- When the user asks to "format", "lint", "check code quality", or "fix compile warnings" in an Elixir project

## Tools (in order)

### 1. mix format

Formats all Elixir source files according to the project's `.formatter.exs`.

```bash
mix format
```

Run after editing code to keep style consistent. The project may format specific paths; use `mix format path/to/file.ex` for a single file.

### 2. mix credo

Runs Credo for code quality and consistency (if the project has Credo in deps).

```bash
mix credo
# Or for a single file:
mix credo path/to/file.ex
```

Run after edits to catch style issues, duplication, and suggested refactors. If Credo is not in mix.exs, skip this step.

### 3. mix compile --warnings-as-errors

Ensures the project compiles and treats warnings as errors.

```bash
mix compile --warnings-as-errors
```

Run to catch compile-time warnings before they accumulate. Fix any reported warnings.

## Project alias: mix precommit

If the project defines a `precommit` alias in `mix.exs` (e.g. format + credo + compile), prefer:

```bash
mix precommit
```

Use this when the project documents it (e.g. in AGENTS.md or README) so one command runs the full checks.

## Process

1. After making changes to Elixir files, run `mix format` (or `mix precommit` if available).
2. If Credo is in the project, run `mix credo` and address reported issues.
3. Run `mix compile --warnings-as-errors` and fix any warnings.
4. If the project uses `mix precommit`, running it once may cover all of the above.

## Notes

- Don't assume Credo is present; check `mix.exs` or run `mix help credo`.
- Format and compile are standard; Credo is optional and project-specific.
- Always fix compile warnings; do not leave them for later.
