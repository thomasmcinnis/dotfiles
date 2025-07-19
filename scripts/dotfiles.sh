#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
CONFIG_DIR="$REPO_ROOT/config"
BACKUP_DIR="$REPO_ROOT/backup/$(date +%Y%m%d-%H%M%S)"

# Source utility functions
source "$SCRIPT_DIR/utils.sh"
print_info "Starting dotfiles setup..."
print_info "This script will symlink essential configuration files from $CONFIG_DIR to your home directory"
# Create backup directory
print_info "Creating backup directory at $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Function to symlink a file/directory
symlink() {
  local src="$1"
  local dest="$2"

  # Check if source exists
  if [[ ! -e "$src" ]]; then
    print_warning "Source file/directory doesn't exist: $src"
    print_warning "Skipping..."
    return
  fi

  # Create parent directory if it doesn't exist
  mkdir -p "$(dirname "$dest")"

  # Backup existing file/directory
  if [[ -e "$dest" && ! -L "$dest" ]]; then
    print_info "Backing up $dest to $BACKUP_DIR/"

    # Create the same directory structure in backup folder
    local rel_path="${dest#$HOME/}"
    local backup_path="$BACKUP_DIR/$rel_path"
    mkdir -p "$(dirname "$backup_path")"

    # Copy the file/directory
    cp -R "$dest" "$backup_path"
  fi

  # Remove existing file/directory or symlink
  if [[ -e "$dest" || -L "$dest" ]]; then
    rm -rf "$dest"
  fi

  # Create symlink
  print_info "Symlinking $src to $dest"
  ln -sf "$src" "$dest"
}

# Check if config directory exists
if [[ ! -d "$CONFIG_DIR" ]]; then
  print_warning "Config directory not found: $CONFIG_DIR"
  print_info "Creating config directories..."
  mkdir -p "$CONFIG_DIR/nvim"
  mkdir -p "$CONFIG_DIR/zsh"
  mkdir -p "$CONFIG_DIR/shell"
  mkdir -p "$CONFIG_DIR/tmux"

  # Copy existing .profile if it exists
  if [[ -f "$HOME/.profile" && ! -L "$HOME/.profile" ]]; then
    print_info "Copying existing .profile to the repo"
    cp -p "$HOME/.profile" "$CONFIG_DIR/shell/.profile"
  fi

  # Copy existing .zshrc if it exists
  if [[ -f "$HOME/.zshrc" && ! -L "$HOME/.zshrc" ]]; then
    print_info "Copying existing .zshrc to the repo"
    cp -p "$HOME/.zshrc" "$CONFIG_DIR/zsh/.zshrc"
  elif [[ -f "$HOME/.config/zsh/.zshrc" ]]; then
    print_info "Copying existing .zshrc from .config/zsh/ to the repo"
    cp -p "$HOME/.config/zsh/.zshrc" "$CONFIG_DIR/zsh/.zshrc"
  fi

  # Copy existing tmux.conf if it exists
  if [[ -f "$HOME/.tmux.conf" && ! -L "$HOME/.tmux.conf" ]]; then
    print_info "Copying existing .tmux.conf to the repo"
    cp -p "$HOME/.tmux.conf" "$CONFIG_DIR/tmux/.tmux.conf"
  fi
  exit 0
fi

# Symlink shell profile if it exists
if [[ -f "$CONFIG_DIR/shell/.profile" ]]; then
  print_info "Symlinking .profile"
  symlink "$CONFIG_DIR/shell/.profile" "$HOME/.profile"
fi

# Symlink nvim config if it exists
if [[ -d "$CONFIG_DIR/nvim" ]]; then
  print_info "Symlinking Neovim config"
  symlink "$CONFIG_DIR/nvim" "$HOME/.config/nvim"
fi

# Symlink zsh config if it exists
if [[ -d "$CONFIG_DIR/zsh" ]]; then
  print_info "Symlinking Zsh configs"

  # Symlink individual zsh files
  if [[ -f "$CONFIG_DIR/zsh/.zshrc" ]]; then
    symlink "$CONFIG_DIR/zsh/.zshrc" "$HOME/.zshrc"
  fi

  # Symlink p10k theme file if it exists
  if [[ -f "$CONFIG_DIR/zsh/.p10k.zsh" ]]; then
    symlink "$CONFIG_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
  fi
fi

# Symlink tmux config if it exists
if [[ -d "$CONFIG_DIR/tmux" ]]; then
  print_info "Symlinking Tmux configs"

  if [[ -f "$CONFIG_DIR/tmux/.tmux.conf" ]]; then
    symlink "$CONFIG_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"
  fi
fi

# Symlink bin scripts
if [[ -d "$CONFIG_DIR/bin" ]]; then
  print_info "Symlinking bin scripts"

  # Create bin directory if it doesn't exist
  mkdir -p "$HOME/bin"

  # Symlink tmux-sessionizer
  if [[ -f "$CONFIG_DIR/bin/tmux-sessionizer" ]]; then
    symlink "$CONFIG_DIR/bin/tmux-sessionizer" "$HOME/bin/tmux-sessionizer"
    chmod +x "$HOME/bin/tmux-sessionizer"
    print_info "Made tmux-sessionizer executable"
  fi
fi

# Symlink custom scripts from bin/ to ~/.local/bin/
if [[ -d "$REPO_ROOT/bin" ]]; then
  print_info "Symlinking custom scripts from bin/ to ~/.local/bin/"

  # Create ~/.local/bin directory if it doesn't exist
  mkdir -p "$HOME/.local/bin"

  # Loop through all files in bin/
  for script_file in "$REPO_ROOT/bin/"*; do
    if [[ -f "$script_file" ]]; then
      script_name=$(basename "$script_file")
      symlink "$script_file" "$HOME/.local/bin/$script_name"
      chmod +x "$HOME/.local/bin/$script_name"
      print_info "Made $script_name executable in ~/.local/bin/"
    fi
  done
fi

print_success "✅ All dotfiles have been symlinked successfully"
print_info "You can now use your configuration files"

