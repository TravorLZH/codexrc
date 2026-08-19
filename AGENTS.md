# Git commit messages

When creating, suggesting, revising, or evaluating a Git commit message, use the `write-commit-message` skill.

# Chinese typography

Do not insert spaces between English names and adjacent Chinese characters. Likewise, do not insert spaces between surrounding text and the `$` delimiters of inline equations.

# Codex customization source of truth

This machine keeps global Codex customizations in `~/codexrc`.

When creating, editing, or reviewing global Codex instructions or custom skills, modify the files in `~/codexrc` directly:

- Edit `~/codexrc/AGENTS.md` for global Codex instructions.
- Edit `~/codexrc/skills/<skill-name>/` for custom skills.
- Do not edit generated Codex state, auth, logs, sessions, caches, or plugin runtime files for customization changes.

Before editing global Codex instructions or custom skills, check whether `~/codexrc` has uncommitted changes or is behind `origin/master`. Do not pull, rebase, or overwrite local changes unless the user asks.

# Vim buffer safety

These Vim helper requirements apply only to text files. Do not run either helper when editing only non-text files.

Run `vim-check-modified` and `vim-checktime` as standalone shell commands, separate from editing commands and other helper commands. Do not combine them with `&&`, `;`, pipes, command substitutions, or grouped commands, so command-specific execution permissions can match reliably.

Before editing existing text files, run `~/codexrc/bin/vim-check-modified <file>...` with every intended existing text target file as an argument.

- Exit status 0 means no target file has unsaved changes, or no Vim executable or server is available; proceed.
- Exit status 1 means one or more target files has unsaved changes in Vim. Do not edit those files. Report the paths printed by the helper and wait for the user to save or discard the changes.
- Exit status 2 means the helper could not verify the target files. Read its error message, correct any invalid target path, and rerun the check. If sandboxing caused the failure, rerun it with the required escalation. Do not edit the target files until the check succeeds.
- Exit status 64 means the helper was called incorrectly; fix the invocation before editing.

Run the check again before a later edit if the set of intended target files changes.

After editing text files successfully, run `~/codexrc/bin/vim-checktime` so all listed Vim servers immediately check for external changes. Run it once after each coherent batch of text-file edits. Exit status 0 means every listed server completed the check or no refresh was needed because Vim or its servers were unavailable. Exit status 2 means the refresh failed; read the helper's error message and retry with the required escalation if sandboxing caused the failure. If a Vim server cannot be queried after retrying, report the failure to the user.

# LaTeX compilation

If Vim is running, assume VimTeX is the active LaTeX compiler: inspect its existing output, log, and quickfix information instead of starting a separate `latexmk` process. Only run `latexmk` independently when Vim is not running or the user explicitly requests it; in that case, enable SyncTeX with `-synctex=1` and, after a successful build, verify that the corresponding nonempty `.synctex.gz` file was produced.
