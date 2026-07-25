# codexrc

Portable Codex customization for personal use across machines.

This repository stores only durable Codex behavior:

- `AGENTS.md` for global instructions.
- `skills/` for custom reusable Codex skills.
- `install.sh` for linking this repo into `~/.codex`.

It intentionally does not store Codex auth, logs, sessions, runtime state, caches,
marketplace data, project trust entries, or machine-specific config.

## Install

Clone the repository, then run the installer:

```sh
git clone git@github.com:TravorLZH/codexrc.git ~/codexrc
cd ~/codexrc
./install.sh
```

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
