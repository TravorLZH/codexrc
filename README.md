# codexrc

Portable agent customization for personal use across machines. Written to be
agent-agnostic: `AGENTS.md` and the `SKILL.md` files under `skills/` avoid
naming Codex specifically, so Claude Code picks them up too when this repo is
open as the working directory, the same way it reads any project's `AGENTS.md`
and skills.

This repository stores only durable agent behavior:

- `AGENTS.md` for global instructions.
- `bin/` for narrowly scoped helper commands used by those instructions.
- `skills/` for custom reusable skills, written in the shared `SKILL.md`
  format both Codex and Claude Code understand.
- `install.sh` for linking this repo into `~/.codex`.
- `install-rules.sh` for generating local Codex command approval rules.
- `install-claude.sh` for linking this repo into `~/.claude`.
- `install-claude-rules.sh` for merging local Claude Code command permissions.

It intentionally does not store agent auth, logs, sessions, runtime state,
caches, marketplace data, project trust entries, or machine-specific config.

## Included Skills

### `format-c-code`

Applies personal C conventions for indentation, spacing, braces, naming,
struct declarations, and zero tests when writing, editing, or reviewing C
code. See [`skills/format-c-code/SKILL.md`](skills/format-c-code/SKILL.md)
for the complete rules.

### `format-latex-equations`

Applies consistent mathematical LaTeX conventions when Codex writes, edits,
converts, or reviews equations. It covers inline and display delimiters,
inequalities, differentials, fractions, `\substack` line breaks, and paragraph
wrapping. See
[`skills/format-latex-equations/SKILL.md`](skills/format-latex-equations/SKILL.md)
for the complete rules.

### `write-commit-message`

Drafts and evaluates Git commit messages from the staged diff and recent
history. It uses concise imperative subjects and, for nontrivial changes,
file-oriented body bullets in the repository's established style. See
[`skills/write-commit-message/SKILL.md`](skills/write-commit-message/SKILL.md)
for the complete rules.

## Vim Integration

Codex checks intended edit targets for unsaved Vim changes with
`bin/vim-check-modified` and asks Vim to reload external changes after edits
with `bin/vim-checktime`. This integration requires Vim compiled with the
`+clientserver` feature:

```sh
vim --version | grep +clientserver
```

The Vim instance must register the server name `VIM`. The following `vimrc`
fragment starts that server when possible:

```vim
if empty(v:servername) && exists('*remote_startserver') && index(v:argv, '--not-a-term') < 0
  silent! call remote_startserver('VIM')
endif
```

To allow `checktime` to reload unmodified buffers, also add:

```vim
set autoread
```

Codex calls `bin/vim-checktime` immediately after editing. To detect changes
made by other external programs as well, the following autocommands provide a
fallback whenever Vim regains focus, enters a buffer, or leaves the cursor
idle:

```vim
augroup external_file_reload
  autocmd!
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime
augroup END
```

The helper accepts one or more intended edit targets:

```sh
~/codexrc/bin/vim-check-modified path/to/file another/file
```

After editing, Codex runs:

```sh
~/codexrc/bin/vim-checktime
```

`vim-check-modified` exits with status 1 and prints any target files that have
unsaved Vim changes. Both helpers exit successfully when no matching Vim server
or Vim executable is available. They return status 2 when they cannot list or
query the available servers; `vim-check-modified` also uses status 2 when a
target path cannot be resolved. Incorrect `vim-check-modified` usage returns
status 64. The client commands must run in an environment that can access the
same Vim client-server endpoints; sandboxed Codex sessions may require approval
for the helpers to connect.

## Install (Codex)

Clone the repository to `~/codexrc`, then run the installer:

```sh
git clone https://github.com/TravorLZH/codexrc.git ~/codexrc
cd ~/codexrc
./install.sh
```

The repository path is intentionally fixed at `~/codexrc` so Codex can use that
directory as the source of truth when updating global agents and custom skills.

The installer creates symlinks:

```text
~/.codex/AGENTS.md -> ~/codexrc/AGENTS.md
~/.codex/skills/<skill> -> ~/codexrc/skills/<skill>
```

To install local approval rules for the Vim helper commands, run:

```sh
./install-rules.sh
```

This writes `~/.codex/rules/codexrc.rules` with absolute helper paths resolved
from the current checkout, so the shared repo does not need to hardcode a home
directory.

If an existing target is present, it is moved to:

```text
~/.codex/backups/<timestamp>/
```

## Install (Claude Code)

With the repository cloned to `~/codexrc`, run:

```sh
./install-claude.sh
```

The installer creates symlinks:

```text
~/.claude/CLAUDE.md -> ~/codexrc/AGENTS.md
~/.claude/skills/<skill> -> ~/codexrc/skills/<skill>
```

If an existing target is present, it is moved to:

```text
~/.claude/backups/<timestamp>/
```

To allow the Vim helper commands and the host editor/compiler checks without
a permission prompt, run:

```sh
./install-claude-rules.sh
```

This requires `jq` and merges the required entries into
`permissions.allow` in `~/.claude/settings.json`, preserving the rest of that
file's contents. It backs up the previous `settings.json` to
`~/.claude/backups/<timestamp>/` before writing, and re-running it is a no-op
once the entries are present.

Both scripts honor `CLAUDE_CONFIG_DIR` if it is set, the same way the Codex
installers honor `CODEX_HOME`.

## Update

Pull changes and rerun the installer(s) for whichever agent you use:

```sh
cd ~/codexrc
git pull
./install.sh            # Codex
./install-claude.sh     # Claude Code
```

## Add A Skill

Add a new skill directory under `skills/`:

```text
skills/<skill-name>/SKILL.md
```

Then commit and push the change. On other machines, pull and rerun
`./install.sh`.
