# Git commit messages

When creating, suggesting, revising, or evaluating a Git commit message, use the `write-commit-message` skill.

# Codex customization source of truth

This machine keeps global Codex customizations in `~/codexrc`.

When creating, editing, or reviewing global Codex instructions or custom skills, modify the files in `~/codexrc` directly:

- Edit `~/codexrc/AGENTS.md` for global Codex instructions.
- Edit `~/codexrc/skills/<skill-name>/` for custom skills.
- Do not edit generated Codex state, auth, logs, sessions, caches, or plugin runtime files for customization changes.

Before editing global Codex instructions or custom skills, check whether `~/codexrc` has uncommitted changes or is behind `origin/master`. Do not pull, rebase, or overwrite local changes unless the user asks.

# Vim buffer safety

Before editing existing files, run `~/codexrc/bin/vim-check-modified <file>...` with every intended existing target file as an argument.

- Exit status 0 means none of the target files has unsaved changes in the active Vim server, or no Vim server is running; proceed.
- Exit status 1 means one or more target files has unsaved changes in Vim. Do not edit those files. Report the paths printed by the helper and wait for the user to save or discard the changes.
- Exit status 2 means an active Vim server was found but could not be queried. Do not edit the target files until the check succeeds. If sandboxing blocked access to the server, rerun the helper with the required escalation.
- Exit status 64 means the helper was called incorrectly; fix the invocation before editing.

Run the check again before a later edit if the set of intended target files changes.

# LaTeX compilation

Whenever compiling a LaTeX document with `latexmk`, enable SyncTeX with `-synctex=1`. After a successful build, verify that the corresponding nonempty `.synctex.gz` file was produced.
