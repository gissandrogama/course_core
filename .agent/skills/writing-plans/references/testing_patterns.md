# Testing Patterns for Open Finance Service

When writing plans, follow these testing patterns consistent with the project's architecture:

## Unit Tests
- **Domain Layer**: Test rich domain logic in `src/test/kotlin/.../domain/model`. Use plain JUnit 5/MockK.
- **Application Layer**: Test services in `src/test/kotlin/.../application/service`. Mock outbound ports and domain entities.
- **Mappers**: Ensure conversion logic between layers is tested.

## Integration Tests
- **Persistence**: Use `@DataJpaTest` or similar to test repository adapters.
- **REST**: Use `MockMvc` standalone setup for controllers (see project's existing tests for the pattern).
- **Messaging**: Test Kafka producer/consumer logic with `@EmbeddedKafka` or Testcontainers if available.

## Builders
Always use the `builder` pattern located in `src/test/kotlin/.../builder` to create test data. If a builder doesn't exist for a new entity, the plan MUST include creating it.

## Execution Commands
- Run a specific test: `./mvnw test -Dtest=ClassName#methodName`
- Run all tests: `./mvnw test`
