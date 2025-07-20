# Dotfiles and installer

## Prerequisites

Before using this installer on a new machine:

1. **Install essential packages**:
   ```bash
   sudo pacman -S git openssh base-devel
   ```

2. **Set up SSH keys**:
   ```bash
   # Generate SSH key
   ssh-keygen -t ed25519 -C "email@email.com"

   # Start the ssh-agent and add key
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519

   # Copy public key to add to GitHub/GitLab
   cat ~/.ssh/id_ed25519.pub
   ```

3. **Add SSH key to GitHub/GitLab** through their web interface

4. **Clone this repository**

## Installation

Run the installer:
```bash
./install.sh
```

This will:
- Install system packages defined in `packages.txt`
- Set up NVM and Node.js
- Install global npm packages from `packages-npm.txt`
- Configure ZSH with plugins and theme
- Symlink configuration files to appropriate locations

## Adding New Packages

### System Packages
To add new system packages:
```bash
echo "package-name" >> packages.txt
./install.sh
```

### NPM Packages
To add new global NPM packages:
```bash
echo "package-name" >> packages-npm.txt
./install.sh
```

## Configuration Files

- Config files are organized in `./config/{app-name}/`
- All files are symlinked to `~/.config/{app-name}/`
- ZSH configuration is redirected from `~/.zshenv` to `~/.config/zsh/`

## Maintenance

After making changes to any configuration re-run `./install.sh` and push a commit.

