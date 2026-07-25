# Git commit messages

When creating, suggesting, revising, or evaluating a Git commit message, use the `write-commit-message` skill.

# Codex customization source of truth

This machine keeps global Codex customizations in `~/codexrc`.

When creating, editing, or reviewing global Codex instructions or custom skills, modify the files in `~/codexrc` directly:

- Edit `~/codexrc/AGENTS.md` for global Codex instructions.
- Edit `~/codexrc/skills/<skill-name>/` for custom skills.
- Do not edit generated Codex state, auth, logs, sessions, caches, or plugin runtime files for customization changes.
