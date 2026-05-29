#!/usr/bin/env bash
set -euo pipefail

NVIM_DIR="$(realpath "$(dirname "$0")")"
cd "$NVIM_DIR"

if [[ ! -f "init.lua" && ! -f "init.vim" ]]; then
  echo "error: this does not look like a Neovim config directory:"
  echo "  $(pwd)"
  exit 1
fi

OUT="nvim_config_dump.txt"

rm -f "$OUT"

echo "Collecting from: $(pwd)"
echo "Writing to:     $(pwd)/$OUT"

{
  echo "# Neovim config dump"
  echo "# Generated: $(date)"
  echo "# Root: $(pwd)"
  echo

  echo "## TREE"
  tree -a . \
    -I '.git|.undodir|lazy|plugged|pack|mason|parser|site|undo|sessions|backup|spell|node_modules|target|build|dist|.DS_Store|lazy-lock.json|nvim_config_dump.txt'

  echo
  echo "## FILES"

  find . -type f \
    \( \
      -name '*.lua'  -o \
      -name '*.vim'  -o \
      -name '*.json' -o \
      -name '*.toml' -o \
      -name '*.yaml' -o \
      -name '*.yml'  -o \
      -name '*.md'   \
    \) \
    -not -path './.git/*' \
    -not -path './.undodir/*' \
    -not -path './lazy/*' \
    -not -path './plugged/*' \
    -not -path './pack/*' \
    -not -path './mason/*' \
    -not -path './parser/*' \
    -not -path './site/*' \
    -not -path './undo/*' \
    -not -path './sessions/*' \
    -not -path './backup/*' \
    -not -path './spell/*' \
    -not -path './node_modules/*' \
    -not -path './target/*' \
    -not -path './build/*' \
    -not -path './dist/*' \
    -not -name 'lazy-lock.json' \
    -not -name 'nvim_config_dump.txt' \
    -not -name 'collect_all.sh' \
    | sort \
    | while IFS= read -r file; do
        echo
        echo "================================================================================"
        echo "-- path: ${file#./}"
        echo "================================================================================"
        cat "$file"
        echo
      done
} > "$OUT"

echo "Wrote: $(pwd)/$OUT"
wc -l "$OUT"
