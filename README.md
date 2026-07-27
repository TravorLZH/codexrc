# codexrc

Portable Codex customization for personal use across machines.

This repository stores only durable Codex behavior:

- `AGENTS.md` for global instructions.
- `bin/` for narrowly scoped helper commands used by those instructions.
- `skills/` for custom reusable Codex skills.
- `install.sh` for linking this repo into `~/.codex`.

It intentionally does not store Codex auth, logs, sessions, runtime state, caches,
marketplace data, project trust entries, or machine-specific config.

## Included Skills

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
is running and return status 2 when an active server cannot be queried.
Incorrect `vim-check-modified` usage returns status 64. Set `VIM_SERVERNAME` to
use a server name other than `VIM`. The client commands must run in an
environment that can access the same Vim client-server endpoint; sandboxed
Codex sessions may require approval for the helpers to connect.

## Install

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

If an existing target is present, it is moved to:

```text
~/.codex/backups/<timestamp>/
```

## Update

Pull changes and rerun the installer:

```sh
cd ~/codexrc
git pull
./install.sh
```

## Add A Skill

Add a new skill directory under `skills/`:

```text
skills/<skill-name>/SKILL.md
```

Then commit and push the change. On other machines, pull and rerun
`./install.sh`.
