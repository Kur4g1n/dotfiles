#!/usr/bin/env bash

source "${DOTFILES_DIR}/lib/dotfiles.sh"

if ! is_installed mise; then
  echo "ERROR: mise not installed. Should be installed via Homebrew."
  exit 1
fi

installing_banner "language runtimes"

mise install -C "$HOME"

# Nvim dependencies
mise exec -C "$HOME" -- pipx install pynvim
mise exec -C "$HOME" -- npm install -g @mermaid-js/mermaid-cli

echo "wiring configuration complete!"
