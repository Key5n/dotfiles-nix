---
description: Work based on a specification inside a new worktree (infer when omitted)
argument-hint: [SPEC=<path>]
---

Work (e.g., implement a function or fix a bug) based on a specification inside a new worktree.
If $SPEC is not provided, infer the specification file created in this repo (e.g., by `plan.md`).
Follow the task below for further detail.

Prerequisites:

- Ensure the repo lives under `main/` and preserves the `REPOSITORY-NAME/WORKTREE-NAME` structure.
- If $SPEC is empty, infer it by selecting the most recently modified Markdown file whose top-level title is "Speficication" or "Specification".

Tasks:

1. Determine the specification file path: use $SPEC if provided; otherwise use the inferred file.
2. Create a new worktree directory in a parent directory by the `git worktree` subcommand.
   - Make the name of the directory concise.
   - Make the branch name the same as the directory name while prefixed in the conventional commits way like `feature/`, `fix/`, and etc.
3. Change the current directory to the worktree path.
4. Work based on the specification file.
   - Keep the implementation minimal and aligned with existing project style.

Outputs should include:

- The path of the new worktree
- The name of the branch you created
- The specification file path you used
