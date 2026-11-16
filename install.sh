#!/usr/bin/env bash

set -euo pipefail

if ! command -v chezmoi >/dev/null 2>&1; then
  printf 'chezmoi is required. Install it first: https://www.chezmoi.io/install/\n' >&2
  exit 1
fi

dotfiles_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source_dir="$dotfiles_dir/chezmoi"

if [[ ! -d "$source_dir" ]]; then
  printf 'chezmoi source directory not found: %s\n' "$source_dir" >&2
  exit 1
fi

chezmoi init --source "$source_dir"
chezmoi diff

printf '\nReview the diff, then run: chezmoi apply\n'
