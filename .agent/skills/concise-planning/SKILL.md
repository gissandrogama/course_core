---
name: concise-planning
description: Generates clear, actionable, and atomic execution plans for coding tasks in the open-finance-service. Use to structure implementation plans into atomic action items following TDD and Hexagonal Architecture.
---

# Concise Planning for Open Finance Service

## Goal

Turn architectural designs and requirements into a **single, actionable plan** with atomic steps that strictly follow the **Hexagonal Architecture** and **Kotlin/Spring Boot** patterns.

## Workflow

### 1. Scan Context

- Read existing models in `domain/model`.
- Check `application/port` and `application/service` for similar logic.
- Verify `adapter` patterns (REST, Persistence, Messaging).

### 2. Minimal Interaction

- Ask **at most 1–2 questions** and only if truly blocking.
- Assume standard project patterns for mapping and builders if not specified.

### 3. Generate Plan

Every plan generated must follow this structure to ensure clarity and atomicity:

- **Approach**: 1-3 sentences on the architectural strategy (e.g., "Implement a new Domain Entity and its corresponding Repository Port to handle PIX scheduling").
- **Scope**:
  - **In**: What layers and components are being modified.
  - **Out**: Explicit non-goals or deferred integrations.
- **Action Items**: A list of 6-10 atomic, ordered tasks. Use **Verb-first** language.
- **Validation**: Specific TDD steps for each layer.

## Action Item Guidelines (Atomic Tasks)

- **Atomic**: Each step is a single logical unit (e.g., "Create Domain Value Object" instead of "Implement Domain Layer").
- **TDD-Ready**: Each implementation step should be preceded by a "Verify failure" step.
- **Path-Specific**: Mention exact file paths when possible.

## Plan Template for Open Finance

```markdown
# Plan: [Feature/Task Name]

<Architectural Approach following Hexagonal principles>

## Scope

- **In**: [Layer 1], [Layer 2], [Tests]
- **Out**: [Infrastructure details like Kafka setup, deferred to another task]

## Action Items

[ ] 1. Create [Domain/Value Object] in `src/main/kotlin/.../domain/value/`
[ ] 2. Write failing test for [Service/Use Case] in `src/test/kotlin/.../application/service/`
[ ] 3. Run test and verify FAIL
[ ] 4. Implement minimal logic in [Service]
[ ] 5. Run test and verify PASS
[ ] 6. Create Mapper between [Domain] and [Entity/DTO]
[ ] 7. Update Swagger documentation using @swagger-docs-br
[ ] 8. Commit changes using @semantic-git-commit

## Open Questions

- <Question 1 (max 3)>
```

---

## Integration with writing-plans

When creating detailed plans using the `writing-plans` skill, use `concise-planning` to:
1. Ensure each task is truly **atomic**.
2. Standardize the **Plan Template** structure.
3. Maintain focus on the **Scope** (In/Out).