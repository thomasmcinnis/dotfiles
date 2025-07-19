#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

# Source utility functions if they exist
if [[ -f "./scripts/utils.sh" ]]; then
  source ./scripts/utils.sh
fi

# Check if running as root
if [[ $EUID -eq 0 ]]; then
  echo "This script should not be run as root"
  exit 1
fi

# Parse arguments
MODE="interactive"
if [[ $# -gt 0 ]]; then
  MODE="$1"
fi

# Make sure scripts are executable
chmod +x ./scripts/*.sh
# Make bin scripts executable if the directory exists
if [[ -d "./bin" ]]; then
  chmod +x ./bin/*
fi

case "$MODE" in
  full)
    echo "🚀 Running full installation..."
    ./scripts/bootstrap.sh
    ./scripts/packages.sh
    ./scripts/dotfiles.sh
    ;;
  dotfiles)
    echo "🔗 Symlinking dotfiles only..."
    ./scripts/dotfiles.sh
    ;;
  update)
    echo "🔄 Updating everything..."
    ./scripts/update.sh
    ;;
  clean)
    echo "🧹 Cleaning caches & orphans..."
    ./scripts/clean.sh
    ;;
  nuke)
    echo "💣 Nuclear option selected..."
    read -p "⚠️  This will remove everything installed by these scripts. Are you sure? (y/N) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      ./scripts/nuke.sh
    else
      echo "Operation canceled."
    fi
    ;;
  *)
    echo "📋 Dotfiles Manager"
    echo
    echo "Usage: $0 [full|dotfiles|update|clean|nuke]"
    echo
    echo "  full      - Full installation (bootstrap, packages, dotfiles)"
    echo "  dotfiles  - Only symlink dotfiles"
    echo "  update    - Update packages and configs"
    echo "  clean     - Clean package caches and orphaned packages"
    echo "  nuke      - Remove everything installed by these scripts"
    echo
    echo "Running in interactive mode..."
    
    PS3="Select an option: "
    options=("Full Installation" "Symlink Dotfiles" "Update Everything" "Clean System" "Nuclear Option" "Exit")
    select opt in "${options[@]}"; do
      case $opt in
        "Full Installation")
          ./scripts/bootstrap.sh
          ./scripts/packages.sh
          ./scripts/dotfiles.sh
          break
          ;;
        "Symlink Dotfiles")
          ./scripts/dotfiles.sh
          break
          ;;
        "Update Everything")
          ./scripts/update.sh
          break
          ;;
        "Clean System")
          ./scripts/clean.sh
          break
          ;;
        "Nuclear Option")
          read -p "⚠️  This will remove everything installed by these scripts. Are you sure? (y/N) " -n 1 -r
          echo
          if [[ $REPLY =~ ^[Yy]$ ]]; then
            ./scripts/nuke.sh
          else
            echo "Operation canceled."
          fi
          break
          ;;
        "Exit")
          echo "Exiting..."
          exit 0
          ;;
        *) 
          echo "Invalid option $REPLY"
          ;;
      esac
    done
    ;;
esac

echo "✅ Done!"
