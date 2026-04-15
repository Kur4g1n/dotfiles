#!/usr/bin/env bash

source "${DOTFILES_DIR}"/lib/dotfiles.sh


if ! xcode-select -p &>/dev/null; then
  installing_banner "Xcode Command Line Tools"
  xcode-select --install
  echo "Please complete the Xcode Command Line Tools installation and re-run this script."
  exit 1
fi

if ! is_installed brew; then
  installing_banner "Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  eval "$(/opt/homebrew/bin/brew shellenv)"

  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "${DOTFILES_DIR}/zsh/.zprofile"
else
  skipping "Homebrew"
fi

# Install Stow
if ! is_installed stow; then
  installing_banner "GNU Stow"
  brew install stow
else
  skipping "GNU Stow"
fi

echo "prerequisites installation complete!"
