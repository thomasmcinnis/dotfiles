# Dotfiles

Bash-based dotfiles management system for Arch Linux (including WSL).

## Directory Structure

```
dotfiles/
├── README.md
├── install.sh              # Main orchestrator script
├── scripts/
│   ├── bootstrap.sh        # Initial setup (yay, basic tools)
│   ├── packages.sh         # Install dev packages & LSPs
│   ├── dotfiles.sh         # Symlink dotfiles
│   ├── update.sh           # Update everything
│   ├── clean.sh            # Clean caches & orphans
│   ├── nuke.sh             # Nuclear option - remove everything
│   └── utils.sh            # Helper functions
├── bin/                    # Custom scripts that get symlinked to ~/.local/bin
├── config/                 # Actual dotfiles get symlinked to ~/.config or ~
└── backup/                 # Store original configs before symlinking
```

## Usage

To use this dotfiles manager:

```bash
# Make the install script executable
chmod +x install.sh

# Run in interactive mode
./install.sh

# Or run specific modes
./install.sh full       # Full installation
./install.sh dotfiles   # Only symlink dotfiles
./install.sh update     # Update everything
./install.sh clean      # Clean caches & orphans
./install.sh nuke       # Remove everything (nuclear option)
```

## Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/dotfiles.git
   cd dotfiles
   ```

2. Import your existing configurations (optional):
   ```bash
   ./scripts/import-configs.sh
   ```

3. Run the install script:
   ```bash
   ./install.sh
   ```

4. Select the desired operation from the interactive menu or pass a command-line argument.

## Customization

Edit the configuration files in the `config/` directory to customize your environment.

## Custom Scripts

Place your custom shell scripts in the `bin/` directory. They will automatically be:

1. Symlinked to `~/.local/bin/` when you run `./scripts/dotfiles.sh` or `./install.sh dotfiles`
2. Made executable
3. Available in your PATH

## What Gets Symlinked

| Source                  | Destination               | Description                  |
|-------------------------|--------------------------|-----------------------------|
| `config/shell/.profile` | `~/.profile`             | Shell login configuration   |
| `config/zsh/.zshrc`     | `~/.zshrc`               | ZSH configuration           |
| `config/zsh/.p10k.zsh`  | `~/.p10k.zsh`            | Powerlevel10k theme config  |
| `config/tmux/.tmux.conf`| `~/.tmux.conf`           | Tmux configuration          |
| `config/nvim/`          | `~/.config/nvim/`        | Neovim configuration        |
| `bin/*`                 | `~/.local/bin/*`         | Custom executable scripts   |
## License

MIT
