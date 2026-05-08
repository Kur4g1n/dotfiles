#!/usr/bin/env bash

source "${DOTFILES_DIR}/lib/dotfiles.sh"

if ! is_installed mise; then
  echo "ERROR: mise not installed. Should be installed via Homebrew."
  exit 1
fi

installing_banner "language runtimes"

mise install -C "$HOME"

# Nvim dependencies
export UV_TOOL_BIN_DIR="${HOME}/.local/bin"
export PATH="${UV_TOOL_BIN_DIR}:${PATH}"

mise exec -C "$HOME" uv -- uv tool install --upgrade pynvim
mise exec -C "$HOME" uv -- uv tool install --upgrade hererocks
mise exec -C "$HOME" uv -- uv tool install --upgrade pylatexenc

HEREROCKS_DIR="${HOME}/.local/share/nvim/lazy-rocks/hererocks"
if [[ ! -x "${HEREROCKS_DIR}/bin/luarocks" ]]; then
  mkdir -p "$(dirname "${HEREROCKS_DIR}")"
  hererocks --lua 5.1 --luarocks latest "${HEREROCKS_DIR}"
fi

mise exec -C "$HOME" node@lts -- env NPM_CONFIG_LOGLEVEL=silent npm install -g \
  @mermaid-js/mermaid-cli \
  neovim \
  prettier >/dev/null

echo "language runtimes configuration complete!"
