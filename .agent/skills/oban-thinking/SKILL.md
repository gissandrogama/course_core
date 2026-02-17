---
name: oban-thinking
description: Apply when adding background jobs, async processing, scheduled tasks, retries, email sending, cron, unique jobs, batch processing, or when the user mentions Oban, Oban Pro, workflows, job queues, cascades, grafting, job args, or troubleshooting job failures.
---

# Oban Thinking

**Resumo (pt-BR):** Job args são JSON—atoms viram strings no perform. Deixar erros subirem (let it crash) para retry e logging. Oban Pro: context de cascade preserva atoms; use graft para esperar sub-workflows; recorded: true para valores entre steps.

Paradigm shifts for Oban job processing. These insights prevent common bugs and guide proper patterns.

## The Iron Law: JSON Serialization (Oban non-Pro)

```
JOB ARGS ARE JSON. ATOMS BECOME STRINGS.
```

In `perform/1`, use string keys: `%{"user_id" => user_id}`. Creating jobs with atom keys is fine; processing must use string keys.

## Error Handling: Let It Crash

Don't catch errors in Oban jobs. Let them bubble up for automatic logging, retries, and visibility in Oban Web. Only catch when you need custom retry logic or permanent failure: `{:cancel, reason}`, `{:snooze, seconds}`.

## Snoozing for Polling

Use `{:snooze, seconds}` for polling external state instead of manual retry logic.

## Simple Job Chaining

For A → B → C, have each job enqueue the next. Don't reach for Oban Pro Workflows for linear chains.

## Unique Jobs

Use `unique: [period: 60]` or `unique: [period: 300, keys: [:user_id]]`. Uniqueness is checked on insert, not execution.

## High Throughput: Chunking

Chunk work into batches (e.g. BatchWorker with list of IDs) rather than one job per item. Use bulk inserts without uniqueness for maximum throughput.

---

## Oban Pro: Cascade Context

Cascade context preserves atoms—use atom keys in context and in cascade steps. Dot notation works.

## When to Use Workflows

Use for: complex dependency graphs, fan-out/fan-in, recorded values across steps, conditional branching. Don't use for simple A → B → C chains.

## Graft vs add_workflow

- **add_workflow:** Inserts jobs; sub-workflow completion does not block deps; output not accessible
- **add_graft:** Waits for sub-workflow to complete; output available via recorded values

Use `add_graft` when parent must wait for sub-workflow and use its output. Final job of grafted workflow must use `recorded: true` for values to be available to dependent steps.

## Dynamic Workflow Appending

Use `Workflow.append/2` to add jobs to a running workflow. Cannot override context or add deps to already-running jobs.

## Fan-Out/Fan-In with Batches

Use Batch callbacks: wrap workflows in a shared batch_id, then `Batch.add_callback(:completed, CompletionWorker)`.

## Testing Workflows

Don't use inline testing mode; use `run_workflow/1` for integration tests. Workflows need database interaction.

---

## Red Flags - STOP and Reconsider

**Non-Pro:** Pattern matching on atom keys in perform/1; catching all errors and returning `{:ok, _}`; one job per item when processing millions.

**Pro:** Using add_workflow when you need to wait for completion; not using recorded: true when you need output from grafted workflows; using Workflows for simple linear chains.

**Any of these? Re-read the serialization rules and graft vs add_workflow.**
