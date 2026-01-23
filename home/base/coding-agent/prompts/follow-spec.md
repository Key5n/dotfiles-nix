---
description: Work based on a specification inside a new worktree
argument-hint: [SPEC=<paths>]
---

Work (e.g., implement a function or fix a bug) based on a specification ($SPEC) inside a new worktree.
Follow the task below for further detail.

Tasks:

1. Create a directory "origin" and move all files and dirs under the directory while keeping the same directory structure so that it keeps the following directory structure "REPOSITORY-NAME/WORKTREE-NAME"
2. Create a new worktree directory in a parent directory by `worktree` subcommand in git.
   - Make the name of the directory consise.
   - Make the branch name the same as the directory name while prefixed in the conventional commits way like `feature/`, `fix/`, and etc.
3. Change the current directory to the worktree path.
4. Work based on the specification ($SPEC).
   - Keep the implementation minimal and aligned with existing project style.

Outputs should include:

- The path of the new worktree
- The name of the branch you created
