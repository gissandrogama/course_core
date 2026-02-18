# Atomic Task Examples for Kotlin/Hexagonal

When breaking down tasks, use these examples as a guide for "atomic" granularity.

## Domain Layer
- **Bad**: "Create domain model and logic."
- **Good**: "Create `ScheduledPix` data class in `domain/model`."
- **Good**: "Add `validateAmount()` logic to `ScheduledPix` with unit tests."
- **Good**: "Create `SchedulingStatus` Enum in `domain/enums`."

## Application Layer
- **Bad**: "Implement scheduling service."
- **Good**: "Define `SchedulePixUseCase` port in `application/port/in`."
- **Good**: "Create `SchedulePixService` stub and its corresponding test class."
- **Good**: "Implement `SchedulePixService.execute()` with mock persistence port."

## Adapter Layer
- **Bad**: "Create REST endpoint and JPA repository."
- **Good**: "Create `PixSchedulingEntity` and `PixSchedulingJpaRepository`."
- **Good**: "Implement `PixSchedulingPersistenceAdapter` mapping `Domain` to `Entity`."
- **Good**: "Create `PixSchedulingController` with `@PostMapping` and DTOs."

## Testing & Docs
- **Good**: "Create `PixSchedulingBuilder` in `src/test/kotlin/.../builder/domain/model`."
- **Good**: "Add Swagger annotations to `PixSchedulingRequest` in Portuguese BR."
