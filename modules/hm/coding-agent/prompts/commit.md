---
description: Commit the current worktree changes
argument-hint: [MESSAGE="<Commit message>"]
---

Commit the current worktree changes.
If commit message ($MESSAGE) is provided, use it; otherwise craft a concise commit message.

Requirements:

- Stage every file with `git add -A`.
- If there are no changes to commit, say so and stop.
- If commit failed because of linting or formatting in "pre-commit", fix errors then commit.
- Follow the repo's commit style: concise, imperative subject, scope when helpful, no trailing period.
- Prefer Conventional Commit prefixes (e.g., feat, fix, chore, docs, refactor, test, perf, ci, build) when they fit.
- Keep the subject line under 72 characters.

Outputs should include:

- The commit message used.
- The list of files committed.
