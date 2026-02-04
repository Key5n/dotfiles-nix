---
description: Commit the current worktree changes
argument-hint: [MESSAGE="<Commit message>"]
---

Commit the current worktree changes.
If $MESSAGE is provided, use it; otherwise craft a concise commit message.

Requirements:

- Stage only the files relevant to the current task; do not include unrelated changes.
- If there are no changes to commit, say so and stop.
- Follow the repo's commit style: concise, imperative subject, scope when helpful, no trailing period.
- Prefer Conventional Commit prefixes (e.g., feat, fix, chore, docs, refactor, test, perf, ci, build) when they fit.
- Keep the subject line under 72 characters.

Outputs should include:

- The commit message used.
- The commit hash.
- The list of files committed.
