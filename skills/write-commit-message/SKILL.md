---
name: write-commit-message
description: Draft or suggest Git commit messages in TravorLZH's established style. Use whenever Codex creates, proposes, revises, or evaluates a Git commit message, including messages for staged changes and Git-generated merges.
---

# Write Git Commit Messages

## Inspect the change

- Inspect the complete staged diff and recent repository history before drafting the message.
- Base the message on the concrete intent and impact of the staged change, not on the process used to make it.
- If nothing is staged, state that clearly instead of inferring a commit message from unstaged changes, unless the user explicitly asks for a message covering those changes.

## Write the message

- Write in English.
- Use a concise, single-line, sentence-case subject beginning with an imperative verb such as `Add`, `Fix`, `Remove`, `Rename`, `Configure`, `Document`, `Clarify`, `Protect`, `Restrict`, `Centralize`, `Share`, or `Stop`.
- Do not use a Conventional Commits prefix such as `feat:`, `fix:`, or `chore:`.
- Do not add a scope prefix, issue number, emoji, trailing period, or AI attribution to the subject.
- Use the subject alone for a trivial or self-explanatory change.
- For a non-trivial change, add a body after the subject.
- When a change is major, architectural, cross-cutting, migration-oriented, or otherwise needs context beyond its file-level details, begin the body with a concise explanatory paragraph. Summarize the commit's intent and user or system impact in one or two sentences; describe the result rather than the implementation process.
- Follow the explanatory paragraph, or the subject when no paragraph is needed, with file-oriented bullet paragraphs in this form:

  `* path/to/file: Describe what changed and, when useful, why.`

- Group closely related changes to the same file in one bullet when practical.
- Separate bullet paragraphs with blank lines.
- Begin body descriptions with imperative verbs and describe behavior, configuration, or documentation impact precisely.
- Preserve the standard `Merge branch 'name'` subject for a Git-generated merge.

## Examples

```text
Fix release cleanup permissions

* DEPLOY.md: Preserve group write permissions, keep cleanup failures from invalidating successful deployments, and document repairing existing releases.
```

```text
Modularize and assemble Gitweb

Separate site-specific behavior from the upstream-derived CGI while preserving a self-contained deployment artifact. Build the runtime CGI from modular sources so development remains testable and production keeps its single-file layout.

* gitweb.perl: Retain the upstream-derived entry point and delegate custom behavior to focused modules.

* build-gitweb: Assemble and validate the deployable CGI.
```

```text
Rename Markdown files to English
```
