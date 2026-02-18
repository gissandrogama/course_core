# OTP Thinking

Mental shifts for OTP design.

## The Iron Law: GenServer is a Bottleneck by Design
A GenServer processes ONE message at a time.
- **The ETS Pattern**: GenServer owns the table (serialized writes), but reads bypass it entirely via ETS with `:read_concurrency`.

## Task.Supervisor, Not Task.async
`Task.async` is linked—if it crashes, the caller crashes. Use `Task.Supervisor.async_nolink/2` for robust production code.

## Broadway vs Oban
- **Broadway**: External queues (SQS, Kafka) — data ingestion/batching.
- **Oban**: Background jobs with DB persistence.

## Supervision Strategies
- `:one_for_one`: Independent children.
- `:one_for_all`: Interdependent (all restart).
- `:rest_for_one`: Sequential dependency.

## Abstraction Decision Tree
1. Need state? No → Plain function.
2. Complex behavior? No → Agent.
3. Supervisor? No → `spawn_link`.
4. Request/response? No → `Task.Supervisor`.
5. Explicit states? No → `GenServer`. Yes → `GenStateMachine`.
