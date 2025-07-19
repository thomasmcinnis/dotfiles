# Enable Powerlevel11k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# --------------------------------------------------------------------------
# Path Configuration
# --------------------------------------------------------------------------

# Set PATH based on operating system
case "$(uname 2>/dev/null)" in
  Darwin*)
    # macOS paths
    export PATH="$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:/usr/local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/bin:/usr/sbin:$PATH"
    ;;
  Linux*)
    # Linux paths
    export PATH="$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin:/usr/local/bin:/usr/bin:/usr/sbin:/snap/bin:$PATH"
    # WSL-specific paths
    if grep -q "microsoft" /proc/version &>/dev/null; then
      export PATH="$PATH:/mnt/c/Windows/System32:/mnt/c/Windows/System32/WindowsPowerShell/v1.0"
    fi
    ;;
esac


# --------------------------------------------------------------------------
# HISTORY
# --------------------------------------------------------------------------
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_all_dups  # Don't store duplicated commands
setopt hist_save_no_dups     # Don't save duplicated commands
setopt share_history         # Share history between sessions


# --------------------------------------------------------------------------
# COMPLETION
# --------------------------------------------------------------------------
zstyle :compinstall ~/.zshrc
autoload -Uz compinit
compinit

# Completion options
zstyle ':completion:*' menu select                  # Menu-like completion selection
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Case insensitive completion
zstyle ':completion:*' group-name ''                # Group matches by group names
zstyle ':completion:*' verbose yes                  # Show more info


# --------------------------------------------------------------------------
# ALIASES
# --------------------------------------------------------------------------

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Make ls good
if [[ $(uname) == "Darwin" ]]; then
  # macOS specific aliases
  alias ls="ls -lahG"
else
  # Linux specific aliases
  alias ls="ls -lah --color=auto --group-directories-first"
fi

alias ll='ls -la'
alias la='ls -a'

#tmux with sessionizer
alias ts="tmux-sessionizer"
alias tls="tmux list-sessions"
alias ta="tmux attach"

#cd with fzf
alias sd="cd ~ && cd \$(find * -type d | fzf)"

# Quick edit
alias zshrc="$EDITOR ~/.zshrc"
alias reload="source ~/.zshrc"

# --------------------------------------------------------------------------
# OPTIONS
# --------------------------------------------------------------------------
setopt autocd               # if only dir path entered cd there by default
setopt nobeep               # no bells
setopt histignorealldups	# if cmd duplicated don't add to hist
setopt extended_glob        # Extended globbing
setopt no_case_glob         # Case insensitive globbing
setopt numeric_glob_sort    # Sort filenames numerically when relevant
setopt interactive_comments # Allow comments in interactive mode

# --------------------------------------------------------------------------
# KEY BINDINGS
# --------------------------------------------------------------------------
# Emacs keybindings
bindkey -e
bindkey -s ^f "tmux-sessionizer\n"

# Useful keybindings
bindkey '^[[H' beginning-of-line                    # Home key
bindkey '^[[F' end-of-line                          # End key
bindkey '^[[3~' delete-char                         # Delete key
bindkey '^[[A' history-search-backward              # Up arrow
bindkey '^[[B' history-search-forward               # Down arrow

# --------------------------------------------------------------------------
# Editor Configuration
# --------------------------------------------------------------------------

# Try to use nvim, fallback to vim
if command -v nvim >/dev/null 2>&1; then
    export EDITOR="nvim"
    export VISUAL="nvim"
    export GIT_EDITOR="nvim"
    alias vim="nvim"
    alias vi="nvim"
else
    export EDITOR="vim"
    export VISUAL="vim"
    export GIT_EDITOR="vim"
fi

# --------------------------------------------------------------------------
# Node Version Manager
# --------------------------------------------------------------------------
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# --------------------------------------------------------------------------
# PLUGINS
# --------------------------------------------------------------------------

# Set plugin directory to look in .config/zsh/plugins
PLUGIN_DIR="$HOME/.config/zsh/plugins"

# Source plugins if they exist
[ -f "$PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && \
  source "$PLUGIN_DIR/zsh-autosuggestions/zsh-autosuggestions.zsh"

[ -f "$PLUGIN_DIR/powerlevel10k/powerlevel10k.zsh-theme" ] && \
  source "$PLUGIN_DIR/powerlevel10k/powerlevel10k.zsh-theme"

[ -f "$PLUGIN_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh" ] && \
  source "$PLUGIN_DIR/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"

# --------------------------------------------------------------------------
# Powerlevel10k
# --------------------------------------------------------------------------
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
[ -f ~/.p10k.zsh ] && source ~/.p10k.zsh

# --------------------------------------------------------------------------
# Local configuration
# --------------------------------------------------------------------------
# Load a local zshrc if it exists for machine-specific settings
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

