# Oban Thinking

Paradigm shifts for Oban.

## The Iron Law: JSON Serialization
Job args are JSON. Atoms become Strings. Pattern match on `"user_id"` not `:user_id` in `perform/1`.

## Error Handling: Let It Crash
Don't catch errors in Oban jobs. Let them bubble up for automatic logging, retries, and visibility in the dashboard. Return `{:error, reason}` or crash.

## Snoozing
Use `{:snooze, seconds}` for polling external state instead of manual retry logic.

## Oban Pro: Cascade Context
Preserves atoms! Atom keys still work in cascade context.

## Oban Pro: Workflows & Grafting
- Use `add_graft` instead of `add_workflow` if you need the parent to wait for completion.
- Final jobs must use `recorded: true` for output to be available to dependent steps.

## High Throughput
Chunk work into batches (one job per 100 items) rather than one job per record to avoid DB strain.
