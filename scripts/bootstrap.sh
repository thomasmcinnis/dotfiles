#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source utility functions
source "$SCRIPT_DIR/utils.sh"

print_info "Starting bootstrap process..."
print_info "This script will set up the basic environment"

# Check if running in WSL
if is_wsl; then
  print_info "Running in WSL environment"
else
  print_info "Running in native Linux environment"
fi

# Check for pacman and update system
if command_exists pacman; then
  print_info "Updating pacman database"
  sudo pacman -Syu --noconfirm
else
  print_error "This script requires pacman. Are you running Arch Linux?"
  exit 1
fi

# Install base development packages
print_info "Installing base development packages"
sudo pacman -S --needed --noconfirm base-devel git yay

# Update yay database
print_info "Updating yay database"
yay -Syu --noconfirm

# Check for WSL-specific optimizations
if is_wsl; then
  print_info "Setting up WSL-specific configurations"

  # Add WSL specific optimizations to .wslconfig if it doesn't exist
  if [[ ! -f "$HOME/.wslconfig" ]]; then
    print_info "Creating WSL configuration file"
    cat > "$HOME/.wslconfig" << EOL
[wsl2]
memory=8GB
processors=4
swap=2GB
localhostForwarding=true
EOL
    print_success "Created .wslconfig file"
  fi
fi

print_success "Bootstrap process completed successfully"
print_info "Run ./scripts/packages.sh next to install development packages"
