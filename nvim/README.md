# Portable Neovim Config

This package was generated from:

- Source: /home/matt/.config/nvim
- Generated at: 2026-02-17T20:58:48Z

## Requirements

- Neovim 0.9+ (0.10 recommended)
- git
- curl (for plugin download paths in some environments)
- build tools: make + gcc/clang
- ripgrep (recommended)
- fd (recommended)

## Install

1. Backup existing config if needed:
   mv ~/.config/nvim ~/.config/nvim.backup.<timestamp>
2. Copy this package directory to ~/.config/nvim
3. Launch Neovim once to bootstrap plugins
4. Run :checkhealth

Or run:

./install.sh

## Notes

- This package is distro-agnostic and does not require Omarchy.
- Omarchy theme snapshot included: no
