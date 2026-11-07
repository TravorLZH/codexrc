#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
claude_home=${CLAUDE_CONFIG_DIR:-"$HOME/.claude"}
backup_dir="$claude_home/backups/$(date +%Y%m%d-%H%M%S)"

link_item() {
  src=$1
  dest=$2

  mkdir -p "$(dirname -- "$dest")"

  if [ -e "$dest" ] || [ -L "$dest" ]; then
    current=$(readlink "$dest" 2>/dev/null || true)
    if [ "$current" = "$src" ]; then
      printf 'ok: %s already linked\n' "$dest"
      return
    fi

    mkdir -p "$backup_dir"
    mv "$dest" "$backup_dir/"
    printf 'backup: %s -> %s/\n' "$dest" "$backup_dir"
  fi

  ln -s "$src" "$dest"
  printf 'link: %s -> %s\n' "$dest" "$src"
}

mkdir -p "$claude_home/skills"

link_item "$repo_dir/AGENTS.md" "$claude_home/CLAUDE.md"

for skill_dir in "$repo_dir"/skills/*; do
  [ -d "$skill_dir" ] || continue
  skill_name=$(basename -- "$skill_dir")
  link_item "$skill_dir" "$claude_home/skills/$skill_name"
done

printf 'done: installed Claude Code customization into %s\n' "$claude_home"
