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
# System Packages
# --------------------------------------------------------------------------
if ! command_exists yay; then
  print_info "Installing yay..."
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
fi

print_info "Updating package database..."
yay -Sy || {
  print_info "Failed"
  exit 1
}

print_info "Installing system packages..."
yay -S --needed --noconfirm $(cat packages.txt) || {
  print_info "Failed to install packages"
  exit 1
}
print_success "System packages ready"

# --------------------------------------------------------------------------
# Runtimes Setup with ASDF
# --------------------------------------------------------------------------
print_info "Setting up required tools"
# Add nodeJS
asdf plugin add nodejs
asdf install nodejs lts && asdf set -u nodejs lts
print_success "Node.js ready"
# Add Java
# asdf plugin add java
# asdf install java openjdk-25 && asdf set -u java openjdk-25
# print_success "Java ready"

# --------------------------------------------------------------------------
# NPM Global Packages
# --------------------------------------------------------------------------
print_info "Installing global npm packages"
npm install -g $(cat packages-npm.txt) --no-fund
print_success "Global npm packages ready"

# --------------------------------------------------------------------------
# Install Clojure 
# --------------------------------------------------------------------------
# print_info "Installing Clojure"
# curl -L -O https://github.com/clojure/brew-install/releases/latest/download/linux-install.sh && \
# chmod +x linux-install.sh && \
# ./linux-install.sh --prefix $HOME/.local/
# rm ./linux-install.sh
# rm -rf ~/.config/clojure
# git clone git@github.com:practicalli/clojure-cli-config.git ~/.config/clojure
# print_success "Clojure ready"

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
# ZSH
# --------------------------------------------------------------------------
print_info "Setting up ZSH"
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

cat > "$HOME/.zshenv" << 'EOF'
# Set XDG_CONFIG_HOME for clean management of configuration files
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:=$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:=$HOME/.cache}"
export ZDOTDIR="${ZDOTDIR:=$XDG_CONFIG_HOME/zsh}"
EOF
print_success "ZSH environment setup complete"

print_success "Installation complete!"
