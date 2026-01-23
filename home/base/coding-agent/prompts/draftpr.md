---
description: Commit and Open a draft Pull Request
argument-hint: [SPEC=<paths>]
---

Open a draft Pull Request of the current branch.
Follow the outline below for Pull Request, but adapt as needed.

Requirements:

- Look specification file ($SPEC) up for commit message and Pull Request if it is provided.
- Commit the current worktree with a concise title if no commits are done to the current branch.
  - Don't commit specification files.
- Make the title of the pull request the same as the commit message.
- Keep the pull request very detailed to describe the change.
- Maintain a professional tone.
- Write Pull Request in Japanese.

Recommended Sections

- "問題"
  - If "問題" (issues) are more relevant to call rather than issues, change the section name into "Purpose" ("目的").
- "実装内容"
  - You should explain this section as clear and precise as possible.
