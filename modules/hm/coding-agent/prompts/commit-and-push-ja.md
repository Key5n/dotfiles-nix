---
description: Commit and push the current worktree changes
argument-hint: [MESSAGE="<Commit message>"]
---

Commit the current worktree changes and push the current branch to the remote.
If commit message ($MESSAGE) is provided, use it; otherwise craft a concise commit message.
Use `git push` with no arguments.

Requirements:

- Stage only the files relevant to the current task; do not include unrelated changes. Do not stage any Markdown file whose name starts with "plan" (e.g., `plan.md`, `plan-foo.md`).
- If there are no changes to commit, say so and stop.
- Follow the repo's commit style: concise, imperative subject, scope when helpful, no trailing period.
- Prefer Conventional Commit prefixes (e.g., feat, fix, chore, docs, refactor, test, perf, ci, build) when they fit.
- Keep the subject line under 72 characters.
- Push with `git push` (no arguments).
- If push fails (e.g., no upstream), explain the error and suggest the next action.

Outputs should include:

- The commit message used.
- The commit hash.
- The list of files committed.
- The branch that was pushed (as reported by git).
