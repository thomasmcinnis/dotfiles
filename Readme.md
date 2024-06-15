# Instructions

Make sure you only run this on a fresh machine otherwise you might overwrite
existing configs

## Install MacOS dev tools (git, clang etc)

```bash
xcode-select --install
```

## Clone this repo into a new .dotfiles directory

```bash
git clone https://github.com/thomasmcinnis/dotfiles.git ~/.dotfiles
```

## Run the setup script

This will install homebrew and required packages found in `Brewfile`

```bash
cd ~/.dotfiles; source setup.sh
```
