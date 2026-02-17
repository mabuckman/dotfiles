#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/nvim"
STAMP="$(date +%s)"

copy_paths=(
  "init.lua"
  "lua"
  "plugin"
  "after"
  "lazy-lock.json"
  "lazyvim.json"
  "stylua.toml"
  ".gitignore"
  "README.md"
  "LICENSE"
)

mkdir -p "$(dirname "${TARGET_DIR}")"

if [[ -e "${TARGET_DIR}" ]]; then
  mv "${TARGET_DIR}" "${TARGET_DIR}.backup.${STAMP}"
fi

mkdir -p "${TARGET_DIR}"

for rel_path in "${copy_paths[@]}"; do
  if [[ -e "${SCRIPT_DIR}/${rel_path}" ]]; then
    cp -a "${SCRIPT_DIR}/${rel_path}" "${TARGET_DIR}/"
  fi
done

if command -v nvim >/dev/null 2>&1; then
  nvim --headless "+Lazy! sync" +qa || true
fi

printf 'Installed to %s\n' "${TARGET_DIR}"
