# Phoenix Thinking

Mental shifts for Phoenix and LiveView.

## The Iron Law: NO DATABASE QUERIES IN MOUNT
`mount/3` is called TWICE (HTTP + WebSocket). Queries in mount = duplicate queries.
- **mount/3**: Setup only (empty assigns, defaults).
- **handle_params/3**: Data loading (all DB queries).

## Scopes (Phoenix 1.8+)
Authorization context is threaded automatically. Use it to avoid forgetting to scope queries (Broken Access Control).

## External Polling
- **Bad**: LiveView polling external APIs directly.
- **Good**: Single GenServer polls, broadcasts to all via PubSub.

## LiveView Lifecycle Gotchas
- `terminate/2` requires `trap_exit` (which you shouldn't usually do). Use a monitor instead.
- `start_async` with same name: the later one wins.
- `Plug.Upload`: Never trust `content_type`. Validate magic bytes.
- Webhooks: Read raw body BEFORE `Plug.Parsers` consumes it for signature verification.
