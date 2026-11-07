#!/usr/bin/env sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
claude_home=${CLAUDE_CONFIG_DIR:-"$HOME/.claude"}
dest="$claude_home/settings.json"
backup_dir="$claude_home/backups/$(date +%Y%m%d-%H%M%S)"

vim_check_modified="$repo_dir/bin/vim-check-modified"
vim_checktime="$repo_dir/bin/vim-checktime"

if ! command -v jq >/dev/null 2>&1; then
  printf 'error: jq is required to merge %s\n' "$dest" >&2
  exit 1
fi

mkdir -p "$claude_home"
[ -e "$dest" ] || printf '{}' >"$dest"

rules=$(cat <<EOF
[
  "Bash(ps -C vim -C gvim -C nvim -C latexmk -C pdflatex -o pid=,ppid=,args=)",
  "Bash(pgrep -a -x vim)",
  "Bash(vim --serverlist)",
  "Bash($vim_check_modified:*)",
  "Bash($vim_checktime)"
]
EOF
)

tmp=${TMPDIR:-/tmp}/codexrc.claude-settings.$$
trap 'rm -f "$tmp"' EXIT HUP INT TERM

if ! jq --argjson new "$rules" \
  '.permissions.allow = ((.permissions.allow // []) + ($new - (.permissions.allow // [])))' \
  "$dest" >"$tmp"; then
  printf 'error: failed to update %s (invalid JSON?)\n' "$dest" >&2
  exit 1
fi

if cmp -s "$tmp" "$dest"; then
  printf 'ok: %s already up to date\n' "$dest"
  exit 0
fi

mkdir -p "$backup_dir"
cp "$dest" "$backup_dir/settings.json"
printf 'backup: %s -> %s/\n' "$dest" "$backup_dir"

mv "$tmp" "$dest"
trap - EXIT HUP INT TERM
printf 'write: %s\n' "$dest"
printf 'done: restart Claude Code for permission changes to take effect\n'
