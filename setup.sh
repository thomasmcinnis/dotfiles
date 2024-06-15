#!/usr/bin/env zsh

echo ">>>>>Cloning tmux-plugins/tpm into ~/.tmux/plugins/tpm"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo ">>>>>Installing homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" </dev/null ## /dev/null skips pressing enter for the installation
brew bundle --file=~/.dotfiles/homebrew/.Brewfile

