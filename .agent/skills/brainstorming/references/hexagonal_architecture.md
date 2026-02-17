# Hexagonal Architecture Patterns

When brainstorming for new features or architectural changes, consider these core layers and design principles:

## Architectural Layers

1.  **Domain Layer (Core Logic)**
    *   **Domain Models/Entities**: Pure data structures representing business concepts.
    *   **Value Objects**: Immutable objects representing descriptive aspects of the domain.
    *   **Domain Services**: Contain business logic that doesn't naturally fit into a single entity.
    *   **Business Rules**: Encapsulated logic and validations independent of external systems.

2.  **Application Layer (Use Cases)**
    *   **Application Services/Use Cases**: Orchestrate the workflow of a specific business operation.
    *   **Ports (Input/Output Interfaces)**: Definitions of how the application interacts with the outside world.
    *   **DTOs (Data Transfer Objects)**: Input/Output data structures for the application layer.

3.  **Infrastructure/Adapter Layer**
    *   **Inbound Adapters (Drivers)**: Implementations that trigger use cases (e.g., REST Controllers, CLI, Message Queue Listeners).
    *   **Outbound Adapters (Driven)**: Implementations of output ports (e.g., Persistence/DB, External APIs, Email Services).
    *   **ACL (Anti-Corruption Layer)**: Translates external models to internal domain models to prevent leakage of external schemas.

## Core Design Principles

*   **Dependency Rule**: Dependencies always point inwards. The Domain layer must depend on nothing.
*   **Separation of Concerns**: Each layer has a specific responsibility.
*   **Immutability**: Prefer immutable data structures for business logic to avoid hidden side effects.
*   **Encapsulation**: Hide internal implementation details and expose only necessary interfaces.
*   **Error Handling**: Use consistent patterns for handling operational vs. domain errors.

## Integration Strategies

*   **Persistence**: Isolate database-specific logic behind repository interfaces.
*   **Messaging**: Use event-driven patterns for asynchronous communication between services.
*   **External APIs**: Wrap third-party integrations in clear interfaces and use ACLs.
*   **Background Jobs**: Delegate long-running tasks to an asynchronous processing layer.
