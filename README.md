# Dotfiles

My personal setup scripts for Mac machines. Clone the repo, run one command, and you're done.

## Supported Systems

macOS Tahoe 26.4.1 or later.

> The scripts haven't been tested on older versions but might work there too.

## Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/Kur4g1n/dotfiles.git
```

### 2. Start the Installation Script

```bash
./install.sh
```

Stow will create dotfile symlinks in `~/.config`.

> [!NOTE]
> The script assumes that the dotfiles folder is located at `~/dotfiles`. This can be changed by setting the `DOTFILES_DIR` environment variable.

## What Gets Installed

- Homebrew (if missing)
- GNU Stow
- mise
- CLI tools from `Brewfile`
- Apps from `Brewfile`
- Zsh config

### Tools Managed by mise

Language runtimes and package managers are handled by [mise](https://mise.jdx.dev/) instead of Homebrew for easier version management:

- Node.js
- Python
- Go
- Rust

After symlinks are created, global defaults live in `~/.config/mise/config.toml`. Override them per project with `.mise.toml`.

## Updating

Pull the latest changes:

```bash
git pull
```

Update configs and packages:

```bash
stow .      # Update symlinks
brew bundle # Update brew packages
```
