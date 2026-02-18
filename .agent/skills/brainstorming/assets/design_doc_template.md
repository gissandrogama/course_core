# Design Document: [Feature Name]

## 1. Understanding Summary
*   **What**: [Concise description of what is being built]
*   **Why**: [Business or technical motivation]
*   **Who**: [Primary users or systems interacting with this]
*   **Key Constraints**: [List of important constraints]
*   **Explicit Non-Goals**: [What we are NOT doing]

## 2. Assumptions
*   [Assumption 1]
*   [Assumption 2]

## 3. Decision Log
| Decision | Alternatives Considered | Why Chosen |
| :--- | :--- | :--- |
| [Decision 1] | [Alt A, Alt B] | [Reasoning] |

## 4. Final Design

### Architecture & Components
[Describe how this fits into the Hexagonal Architecture]

### Data Flow
[Describe the path from Adapter In to Domain to Adapter Out]

### Error Handling
[How exceptions are handled and mapped to HTTP/Kafka]

### Edge Cases
[Unusual scenarios and their resolution]

## 5. Testing Strategy
*   **Unit Tests**: [Key domain/service logic to test]
*   **Integration Tests**: [Adapter/Persistence integration]
*   **Mocking**: [What builders/mocks are needed]
