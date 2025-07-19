#!/usr/bin/env bash

# Utility functions for dotfiles scripts

# Check if running in WSL
is_wsl() {
  if grep -q "microsoft" /proc/version &>/dev/null; then
    return 0
  else
    return 1
  fi
}

# Print colorized output
print_info() {
  echo -e "\e[34m[INFO]\e[0m $1"
}

print_success() {
  echo -e "\e[32m[SUCCESS]\e[0m $1"
}

print_warning() {
  echo -e "\e[33m[WARNING]\e[0m $1"
}

print_error() {
  echo -e "\e[31m[ERROR]\e[0m $1"
}

# Check if a command exists
command_exists() {
  command -v "$1" &>/dev/null
}

# Create directory if it doesn't exist
ensure_dir() {
  if [[ ! -d "$1" ]]; then
    mkdir -p "$1"
  fi
}

# Backup a file
backup_file() {
  local file="$1"
  local backup_dir="$2"
  
  if [[ -e "$file" && ! -L "$file" ]]; then
    ensure_dir "$backup_dir"
    print_info "Backing up $file to $backup_dir/"
    cp -R "$file" "$backup_dir/"
  fi
}

# Log a message to a file
log_message() {
  local message="$1"
  local log_file="${2:-$(dirname "$0")/../logs/dotfiles.log}"
  
  ensure_dir "$(dirname "$log_file")"
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $message" >> "$log_file"
}