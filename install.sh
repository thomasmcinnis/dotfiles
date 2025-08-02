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
  print_info "Installing yay"
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
fi

print_info "Installing system packages"
yay -S --needed --noconfirm $(cat packages.txt)
print_success "System packages ready"

# --------------------------------------------------------------------------
# Runtimes Setup with ASDF
# --------------------------------------------------------------------------
print_info "Setting up required tools"
asdf plugin add nodejs
asdf install nodejs lts && asdf set -u nodejs lts
print_success "Node.js ready"

# --------------------------------------------------------------------------
# NPM Global Packages
# --------------------------------------------------------------------------
print_info "Installing global npm packages"
npm install -g $(cat packages-npm.txt) --no-fund
print_success "Global npm packages ready"

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
export ZDOTDIR="$HOME/.config/zsh"
EOF
print_success "ZSH environment setup complete"

print_success "Installation complete!"
