#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
codex_home=${CODEX_HOME:-"$HOME/.codex"}
backup_dir="$codex_home/backups/$(date +%Y%m%d-%H%M%S)"

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

mkdir -p "$codex_home/skills"

link_item "$repo_dir/AGENTS.md" "$codex_home/AGENTS.md"

for skill_dir in "$repo_dir"/skills/*; do
  [ -d "$skill_dir" ] || continue
  skill_name=$(basename -- "$skill_dir")
  link_item "$skill_dir" "$codex_home/skills/$skill_name"
done

printf 'done: installed Codex customization into %s\n' "$codex_home"
