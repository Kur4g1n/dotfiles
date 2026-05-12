# Mise activation.
# Keep this line relatively high as it enables language runtime-related
# commands.
eval "$(mise activate zsh)"

export EDITOR=nvim

export EZA_CONFIG_DIR="${XDG_CONFIG_HOME:-${HOME}/.config}/eza"
export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-${HOME}/.config}/starship/starship.toml"
export LS_COLORS="$(vivid generate catppuccin-macchiato)"
export ZVM_SYSTEM_CLIPBOARD_ENABLED=true

export PATH="${HOME}/.local/bin:${PATH}"
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Fzf Styling
export FZF_DEFAULT_OPTS=" \
--border \
--color=bg+:#363A4F,bg:#24273A,spinner:#F4DBD6,hl:#ED8796 \
--color=fg:#CAD3F5,header:#ED8796,info:#C6A0F6,pointer:#F4DBD6 \
--color=marker:#B7BDF8,fg+:#CAD3F5,prompt:#C6A0F6,hl+:#ED8796 \
--color=selected-bg:#494D64 \
--color=border:#6E738D,label:#CAD3F5"


# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Completion Styling
zstyle ':completion:*' menu no
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
_comp_options+=(globdots)

FZF_TAB_PREVIEW='if [[ $(file -bL --mime-encoding $realpath 2>/dev/null) != binary ]]; then
    bat --color=always --style=numbers --line-range=:100 $realpath
  else
    eza --color=always --icons=always --all -1 --group-directories-first $realpath
  fi'

zstyle ':fzf-tab:complete:cd:*' fzf-preview "$FZF_TAB_PREVIEW"
zstyle ':fzf-tab:complete:z:*' fzf-preview "$FZF_TAB_PREVIEW"
zstyle ':fzf-tab:complete:ls:*' fzf-preview "$FZF_TAB_PREVIEW"
zstyle ':fzf-tab:complete:eza:*' fzf-preview "$FZF_TAB_PREVIEW"
zstyle ':fzf-tab:complete:nvim:*' fzf-preview "$FZF_TAB_PREVIEW"

# Zsh Vi mode config
function zvm_after_init() {
  zvm_bindkey viins '^R' fzf-history-widget
  zvm_bindkey vicmd '/' fzf-history-widget
  zvm_bindkey visual '/' fzf-history-widget
}

# History
HISTFILE=~/.config/zsh_history
SAVEHIST=5000
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# Aliases
alias l="eza -a --icons=auto"
alias ll="eza -lha --icons=auto --git"
alias lt="eza -a --tree --level=2 --icons=auto"

alias cat="bat --paging=never"

alias cl="clear"

alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

# Starship Prompt
zvm_after_init_commands+=('eval "$(starship init zsh)"')

# Extra Completions
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(uv generate-shell-completion zsh)"

# Machine-local overrides
[[ -f "${ZDOTDIR:-${HOME}/.config/zsh}/.zshrc.local" ]] && source "${ZDOTDIR:-${HOME}/.config/zsh}/.zshrc.local"
