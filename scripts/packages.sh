#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source utility functions
source "$SCRIPT_DIR/utils.sh"

print_info "Starting packages installation..."
print_info "This script will install development tools and utilities"

# Check if yay is installed
if ! command_exists yay; then
  print_error "yay is not installed. Please run bootstrap.sh first."
  exit 1
fi

# Update package database
print_info "Updating package database"
yay -Syu --noconfirm

# Install common tools
print_info "Installing essential development tools"
PACKAGES=(
  # Core utils
  "fzf"           # Fuzzy finder
  "ripgrep"       # Modern grep
  "bat"           # Cat with wings
  "fd"            # Find alternative
  "eza"           # Modern ls
  "neovim"        # Text editor
  "tmux"          # Terminal multiplexer
  "zsh"           # Shell
  "lazygit"       # Terminal UI for git
  "jq"            # JSON processor
  "htop"          # Process viewer
  "tree"          # Directory tree viewer

  # Development
  "git"           # Version control
  "nodejs"        # Node.js for Vue development
  "npm"           # Node package manager
  "typescript"    # TypeScript compiler
  "racket"        # Racket programming language

  # Network tools
  "curl"          # HTTP client
  "wget"          # File downloader
  "httpie"        # Human-friendly HTTP client
)

# Install packages
for pkg in "${PACKAGES[@]}"; do
  if ! pacman -Q "$pkg" &>/dev/null && ! yay -Q "$pkg" &>/dev/null; then
    print_info "Installing $pkg"
    yay -S --needed --noconfirm "$pkg"
  else
    print_info "$pkg is already installed"
  fi
done

# Install additional Neovim tools
if command_exists nvim; then
  print_info "Setting up Neovim package manager (if not already installed)"
  # Node.js providers for Neovim
  if command_exists npm; then
    print_info "Installing Node.js provider for Neovim"
    npm install --prefix ~/.local neovim
  fi
fi

# Create development directories
print_info "Creating development directories"
mkdir -p "$HOME/work"
mkdir -p "$HOME/personal"
mkdir -p "$HOME/notes"

# Set default shell to zsh if it's not already
if [[ "$SHELL" != *"zsh"* ]]; then
  print_info "Setting zsh as default shell"
  ZSH_PATH=$(which zsh)
  if [[ -n "$ZSH_PATH" ]]; then
    chsh -s "$ZSH_PATH"
    print_success "Default shell changed to zsh"
    print_info "You'll need to log out and back in for this change to take effect"
  else
    print_error "zsh is not installed"
  fi
fi

setup_zsh_plugins() {
  print_info "Setting up ZSH plugins"

  # Create plugins directory if it doesn't exist
  PLUGIN_DIR="$HOME/.config/zsh/plugins"
  mkdir -p "$PLUGIN_DIR"

  # Install Powerlevel10k
  if [[ ! -d "$PLUGIN_DIR/powerlevel10k" ]]; then
    print_info "Installing Powerlevel10k theme"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$PLUGIN_DIR/powerlevel10k"
    print_success "Powerlevel10k installed"
  else
    print_info "Powerlevel10k is already installed"
  fi

  # Install zsh-autosuggestions
  if [[ ! -d "$PLUGIN_DIR/zsh-autosuggestions" ]]; then
    print_info "Installing zsh-autosuggestions"
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git "$PLUGIN_DIR/zsh-autosuggestions"
    print_success "zsh-autosuggestions installed"
  else
    print_info "zsh-autosuggestions is already installed"
  fi

  # Install fast-syntax-highlighting
  if [[ ! -d "$PLUGIN_DIR/fast-syntax-highlighting" ]]; then
    print_info "Installing fast-syntax-highlighting"
    git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$PLUGIN_DIR/fast-syntax-highlighting"
    print_success "fast-syntax-highlighting installed"
  else
    print_info "fast-syntax-highlighting is already installed"
  fi

  # Create a default p10k.zsh if none exists
  if [[ ! -f "$REPO_ROOT/config/zsh/.p10k.zsh" ]]; then
    print_info "You can generate a p10k config by running 'p10k configure'"
    print_info "The generated config will be in ~/.p10k.zsh"
    print_info "You can then copy it to $REPO_ROOT/config/zsh/.p10k.zsh"
  fi
}

# Call the setup function if ZSH is installed
if command_exists zsh; then
  setup_zsh_plugins
fi

print_success "Packages installation completed successfully"
print_info "Run ./scripts/dotfiles.sh next to set up your configuration files"
