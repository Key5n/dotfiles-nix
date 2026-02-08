---
description: Create a specification file by asking questions
argument-hint: [EXPLANATION="<Explanation>"]
---

Generate a specification file that will be used as an instruction for LLM Coding Agent from the following brief explanation.

```
$EXPLANATION
```

Your final goal is to create a clear, concise, and well-structured specification with descriptive headings and actionable explanations for each section.
Remeber to ask me clarifying questions about anything ambiguous.

Follow the outline below for the specification, but adapt as needed.

Speficication Requirements

- Title the document "Speficication".
- Output to a file named "plan-<suitable-name>.md", where <suitable-name> is inferred from the explanation.
- Use Markdown headings (#, ##, etc.) for structure.
- Keep the document detailed. 400-800 words is optimal.
- Keep explanations short, direct, and specific to this repository.
- Maintain a professional, instructional tone.

Recommended Sections

- Background.
- Summary of Changes.
  - You should explain this section as clear and precise as possible.
