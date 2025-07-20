#!/usr/bin/env bash

set -euo pipefail

# --------------------------------------------------------------------------
# Configuration Variables
# --------------------------------------------------------------------------
REPO_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# --------------------------------------------------------------------------
# Utility Functions
# --------------------------------------------------------------------------
print_info() {
  echo -e "\e[34m[INFO]\e[0m $1"
}
print_success() {
  echo -e "\e[32m[SUCCESS]\e[0m $1"
}
command_exists() {
  command -v "$1" &>/dev/null
}

symlink() {
  local src="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"
  # Remove existing file/directory or symlink
  if [[ -e "$dest" || -L "$dest" ]]; then
    rm -rf "$dest"
  fi
  # Create symlink
  ln -sf "$src" "$dest"
  print_info "Symlinked $(basename "$src") to $dest"
}

# --------------------------------------------------------------------------
# Package Manager Setup
# --------------------------------------------------------------------------
if ! command_exists yay; then
  print_info "Installing yay (AUR helper)"
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
fi

# Update yay database
print_info "Updating yay database"
yay -Syu --noconfirm

# --------------------------------------------------------------------------
# System Packages
# --------------------------------------------------------------------------
print_info "Installing system packages"
for package in $(cat packages.txt); do
  if ! pacman -Q "$package" &>/dev/null && ! yay -Q "$package" &>/dev/null; then
    print_info "Installing system package: $package"
    yay -S --needed --noconfirm "$package"
  else
    print_info "$package is already installed"
  fi
done

# --------------------------------------------------------------------------
# Node.js Setup
# --------------------------------------------------------------------------
print_info "Setting up NVM and Node.js"
export NVM_DIR="$HOME/.config/nvm"

if [[ ! -d "$NVM_DIR" ]]; then
  print_info "Installing NVM"
  mkdir -p "$NVM_DIR"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
else
  print_info "NVM is already installed at $NVM_DIR"
fi

# Load NVM
set +u
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Install Node LTS if not already installed
if ! command -v node &>/dev/null || ! node -v | grep -q "v[0-9]"; then
  print_info "Installing Node.js LTS version"
  nvm install --lts
  nvm use --lts
else
  print_info "Node.js is already installed: $(node -v)"
fi
set -u

# --------------------------------------------------------------------------
# NPM Global Packages
# --------------------------------------------------------------------------
print_info "Installing global npm packages"
for package in $(cat packages-npm.txt); do
  # Check if package is already installed globally
  if ! npm list -g "$package" --silent &>/dev/null; then
    print_info "Installing npm package: $package"
    npm install -g "$package" --silent
  else
    print_info "Package $package is already installed"
  fi
done

# --------------------------------------------------------------------------
# Shell Configuration
# --------------------------------------------------------------------------
if [[ "$SHELL" != *"zsh"* ]]; then
  print_info "Setting zsh as default shell"
  ZSH_PATH=$(which zsh)
  chsh -s "$ZSH_PATH"
  print_success "Default shell changed to zsh"
  print_info "You'll need to log out and back in for this change to take effect"
fi

# --------------------------------------------------------------------------
# Custom Scripts
# --------------------------------------------------------------------------
print_info "Symlinking custom scripts from bin/ to ~/.local/bin/"
mkdir -p "$HOME/.local/bin"
find ./bin -type f -exec chmod +x {} \; # Ensure all scripts in bin/ are executable
print_info "Made all scripts in bin/ executable"
for script_file in ./bin/*; do
  script_name=$(basename "$script_file")
  symlink "$REPO_ROOT/$script_file" "$HOME/.local/bin/$script_name"
  print_info "Symlinked $script_name to ~/.local/bin/"
done

# --------------------------------------------------------------------------
# Dotfiles Configuration
# --------------------------------------------------------------------------
print_info "Symlinking configuration files"
for dir in ./config/*; do
  dir_name=$(basename "$dir")
  symlink "$REPO_ROOT/$dir" "$HOME/.config/$dir_name"
done

# --------------------------------------------------------------------------
# ZSH Plugins
# --------------------------------------------------------------------------
print_info "Setting up ZSH plugins"
PLUGIN_DIR="$HOME/.local/share/zsh/plugins"
mkdir -p "$PLUGIN_DIR"
declare -A plugins=(
  ["powerlevel10k"]="https://github.com/romkatv/powerlevel10k.git"
  ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions.git"
  ["fast-syntax-highlighting"]="https://github.com/zdharma-continuum/fast-syntax-highlighting.git"
)
for name in "${!plugins[@]}"; do
  if [[ ! -d "$PLUGIN_DIR/$name" ]]; then
    print_info "Installing $name"
    git clone --depth=1 "${plugins[$name]}" "$PLUGIN_DIR/$name"
  else
    print_info "$name is already installed"
  fi
done

# --------------------------------------------------------------------------
# ZSH Environment Setup
# --------------------------------------------------------------------------
print_info "Setting up ZSH to use XDG config paths"
cat > "$HOME/.zshenv" << 'EOF'
export ZDOTDIR="$HOME/.config/zsh"
source "$ZDOTDIR/.zshrc"
EOF
