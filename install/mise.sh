#!/usr/bin/env bash

source "${DOTFILES_DIR}/lib/dotfiles.sh"

if ! is_installed mise; then
  echo "ERROR: mise not installed. Should be installed via Homebrew."
  exit 1
fi

installing_banner "language runtimes"

export MISE_IGNORED_CONFIG_PATHS="${DOTFILES_DIR}/mise/config.toml"

mise install -C "$HOME"

# Nvim dependencies
mise exec -C "$HOME" -- pipx install pynvim
mise exec -C "$HOME" -- env NPM_CONFIG_LOGLEVEL=silent npm install -g @mermaid-js/mermaid-cli >/dev/null

echo "wiring configuration complete!"
