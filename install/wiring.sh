#!/usr/bin/env bash

source "${DOTFILES_DIR}/lib/dotfiles.sh"

config_banner "configuring zsh"

zdotdir="${HOME}/.config/zsh"
zdotdir_line="export ZDOTDIR=\"${zdotdir}\""
mise_ceiling_path_line="export MISE_CEILING_PATHS=\"${DOTFILES_DIR}\""

mkdir -p "${zdotdir}"
touch ~/.zshenv

if ! grep -qxF "$zdotdir_line" ~/.zshenv 2>/dev/null; then
  printf '%s\n' "$zdotdir_line" >> ~/.zshenv
fi

if ! grep -qxF "$mise_ceiling_path_line" ~/.zshenv 2>/dev/null; then
  printf '%s\n' "$mise_ceiling_path_line" >> ~/.zshenv
fi

rm -f ~/.zshrc ~/.zprofile ~/.zlogin ~/.zlogout
if [ -d ~/.config/nvim ] && [ ! -L ~/.config/nvim ]; then
  mv ~/.config/nvim ~/.config/nvim.bak
fi

if ! is_installed stow; then
  echo "ERROR: stow not installed. Should be installed via Homebrew."
  exit 1
fi

config_banner "config symlinks"

cd "${DOTFILES_DIR}"
stow -R .

echo "wiring configuration complete!"
