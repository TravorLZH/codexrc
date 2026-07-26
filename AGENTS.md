# Git commit messages

When creating, suggesting, revising, or evaluating a Git commit message, use the `write-commit-message` skill.

# Codex customization source of truth

This machine keeps global Codex customizations in `~/codexrc`.

When creating, editing, or reviewing global Codex instructions or custom skills, modify the files in `~/codexrc` directly:

- Edit `~/codexrc/AGENTS.md` for global Codex instructions.
- Edit `~/codexrc/skills/<skill-name>/` for custom skills.
- Do not edit generated Codex state, auth, logs, sessions, caches, or plugin runtime files for customization changes.

Before editing global Codex instructions or custom skills, check whether `~/codexrc` has uncommitted changes or is behind `origin/master`. Do not pull, rebase, or overwrite local changes unless the user asks.

# LaTeX compilation

Whenever compiling a LaTeX document with `latexmk`, enable SyncTeX with `-synctex=1`. After a successful build, verify that the corresponding nonempty `.synctex.gz` file was produced.
