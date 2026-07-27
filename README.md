# codexrc

Portable Codex customization for personal use across machines.

This repository stores only durable Codex behavior:

- `AGENTS.md` for global instructions.
- `bin/` for narrowly scoped helper commands used by those instructions.
- `skills/` for custom reusable Codex skills.
- `install.sh` for linking this repo into `~/.codex`.

It intentionally does not store Codex auth, logs, sessions, runtime state, caches,
marketplace data, project trust entries, or machine-specific config.

## Vim Integration

Codex checks intended edit targets for unsaved Vim changes with
`bin/vim-check-modified`. This integration requires Vim compiled with the
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

To make Vim reload files changed by Codex without a manual `:e`, also add:

```vim
set autoread

augroup external_file_reload
  autocmd!
  autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * checktime
augroup END
```

The helper accepts one or more intended edit targets:

```sh
~/codexrc/bin/vim-check-modified path/to/file another/file
```

It exits with status 1 and prints any target files that have unsaved Vim
changes. It exits successfully when the targets are unmodified or no matching
Vim server is running. A query failure returns status 2, and incorrect usage
returns status 64. Set `VIM_SERVERNAME` to use a server name other than `VIM`.
The client command must run in an environment that can access the same Vim
client-server endpoint; sandboxed Codex sessions may require approval for the
helper to connect.

## Install

Clone the repository to `~/codexrc`, then run the installer:

```sh
git clone git@github.com:TravorLZH/codexrc.git ~/codexrc
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
