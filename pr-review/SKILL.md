---
name: pr-review
description: Review a GitHub PR. Flags only real blockers and security issues, in concise conversational text. Use when the user asks to review a PR by number.
---

# PR Review

Fetch the PR with `gh pr view <num> --json files,title,body` and diff with `gh pr diff <num>`.

Review rules:
- Flag ONLY real blockers and security issues
- No 'Insight' preambles, no verbose explanations
- Skip nice-to-haves (password policy, email enumeration, backward-compat speculation)
- Verify each finding by grepping the actual code before flagging
- Output: bullet list of blockers, each <2 sentences

Then ask which to post as inline comments. Draft as plain conversational text, no code blocks.
