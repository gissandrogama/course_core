---
description: Flow for executing a task.
---

- Ask the user for the issue, story, and card number.
- Ask if the project is on GitHub or GitLab.
- Search using the configured MCP that has access.
- After reading the content of the story, card, or issue:
- Create a plan to implement the task.
- Create a branch with `<chore/fix/feature/refactor>/issue-<number>/issue-title`.
- Create a commit for each phase of the plan executed.
- Use the available skills for the necessary steps.
- After finishing writing the code, do a code review.
- After the code review, the user will push to the remote branch.
- Give the user the option to push if they want.