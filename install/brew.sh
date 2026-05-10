#!/usr/bin/env bash

source "${DOTFILES_DIR}"/lib/dotfiles.sh

if ! is_installed brew; then
  echo "ERROR: Homebrew not installed. Run prereq first."
  exit 1
fi

installing_banner "Homebrew CLI packages"
if [[ -f "${DOTFILES_DIR}/Brewfile" ]]; then
  cd "${DOTFILES_DIR}" || exit
  brew update
  brew bundle --file=Brewfile --upgrade
  cd - || exit
else
  echo "WARNING: No Brewfile found in ${DOTFILES_DIR}"
fi

echo "Homebrew package installation complete!"
