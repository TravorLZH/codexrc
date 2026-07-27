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

- Exit status 0 means all listed Vim servers were queried successfully and none of the target files has unsaved changes; proceed.
- Exit status 1 means one or more target files has unsaved changes in Vim. Do not edit those files. Report the paths printed by the helper and wait for the user to save or discard the changes.
- Exit status 2 means no Vim executable is available, so there is no Vim state to inspect; proceed.
- Exit status 3 means no Vim servers are running; proceed.
- Exit status 4 means Vim servers could not be listed. Read the helper's error message and do not edit the target files until the check succeeds. If sandboxing caused the failure, rerun the helper with the required escalation.
- Exit status 5 means at least one Vim server was found but a query failed or returned an invalid response. Read the helper's error message and do not edit the target files until the check succeeds. If sandboxing caused the failure, rerun the helper with the required escalation.
- Exit status 6 means a target path could not be resolved. Read the helper's error message, correct the path, and rerun the check before editing.
- Exit status 64 means the helper was called incorrectly; fix the invocation before editing.

Run the check again before a later edit if the set of intended target files changes.

After editing files successfully, run `~/codexrc/bin/vim-checktime` so all listed Vim servers immediately check for external changes. Run it once after each coherent batch of file edits. Exit status 0 means every listed server completed the check. Exit statuses 2 and 3 mean no refresh is needed because Vim is unavailable or no Vim servers are running. Exit statuses 4 and 5 require reading the helper's error message and retrying with the required escalation if sandboxing caused the failure. If a Vim server cannot be queried after retrying, report the failure to the user.

# LaTeX compilation

Whenever compiling a LaTeX document with `latexmk`, enable SyncTeX with `-synctex=1`. After a successful build, verify that the corresponding nonempty `.synctex.gz` file was produced.
