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

print_success "Packages installation completed successfully"
print_info "Run ./scripts/dotfiles.sh next to set up your configuration files"
