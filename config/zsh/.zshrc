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
# Set zcompdump location outside of the dotfiles repo
export ZSH_COMPDUMP="$HOME/.cache/.zcompdump-$ZSH_VERSION"
autoload -Uz compinit
compinit -d $ZSH_COMPDUMP

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
alias zshrc="$EDITOR ~/.config/zsh/.zshrc"
alias reload="source ~/.config/zsh/.zshrc"

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
bindkey -v # Use vi keybindings
bindkey -s '\C-f' "tmux-sessionizer\n"

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
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# --------------------------------------------------------------------------
# PLUGINS
# --------------------------------------------------------------------------

# Set plugin directory to look in .local/share/zsh/plugins
PLUGIN_DIR="$HOME/.local/share/zsh/plugins"

# Source plugins if they exist
for plugin_file in $(find "$PLUGIN_DIR" -type f \( -name '*.plugin.zsh' -o -name '*.zsh-theme' \)); do
    source "$plugin_file"
done

# Source the p10k theme
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh
[ -f "$HOME/.config/zsh/.p10k.zsh" ] && source "$HOME/.config/zsh/.p10k.zsh"

# Enable instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
