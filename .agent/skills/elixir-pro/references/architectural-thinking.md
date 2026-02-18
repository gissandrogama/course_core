# Elixir Architectural Thinking

Mental shifts required before writing Elixir. These insights contradict conventional OOP patterns.

## The Iron Law: NO PROCESS WITHOUT A RUNTIME REASON

Before creating a GenServer, Agent, or any process, answer YES to at least one:
1. Do I need mutable state persisting across calls?
2. Do I need concurrent execution?
3. Do I need fault isolation?

**All three are NO?** Use plain functions. Modules organize code. Processes manage runtime.

## The Three Decoupled Dimensions

Elixir decouples these building blocks:
- **Behavior**: Modules (functions)
- **State**: Data (structs, maps)
- **Mutability**: Processes (GenServer/Identity)

## "Let It Crash" = "Let It Heal"
Supervisors are designed to START processes. You don't need unbreakable software; you need repairable software.
- Handle expected errors explicitly (`{:ok, _}` / `{:error, _}`).
- Let unexpected errors crash → supervisor restarts.

## Rule of Least Expressiveness
Use the simplest abstraction:
1. Pattern matching
2. Anonymous functions
3. Behaviors
4. Protocols
5. Message passing

## Testing Behavior, Not Implementation
- Test use cases / public API.
- Refactoring should not break tests (unless behavior changed).
- Avoid global state in tests to keep `async: true`. If you need `async: false`, your code is likely coupled to global state.
