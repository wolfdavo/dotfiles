# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a macOS dotfiles repository that manages configuration for zsh, neovim, tmux, ghostty, wezterm, and vim. The setup uses symlinks to connect config files from this repo to their expected locations.

## Installation

```bash
./install.sh
```

The installer prompts for:
- Whether to install apps (xcode CLI tools, Homebrew, Oh My Zsh, Brewfile packages)
- Whether to overwrite existing dotfiles

## Key Commands

**Symlink management:**
```bash
./scripts/symlinks.sh --create              # Create symlinks from symlinks.conf
./scripts/symlinks.sh --delete              # Remove symlinks only
./scripts/symlinks.sh --delete --include-files  # Remove symlinks and actual files
```

**Homebrew packages:**
```bash
brew bundle --file=homebrew/Brewfile
```

## Architecture

### Symlink System
- `symlinks.conf` - Defines source:target pairs for symlinks
- `scripts/symlinks.sh` - Creates/deletes symlinks based on the config
- Format: `$(pwd)/source/path:$HOME/.config/target/path`

### Neovim Configuration
- Uses lazy.nvim as plugin manager
- `nvim/init.lua` - Entry point, loads core modules and plugins
- `nvim/lua/core/` - Base settings (options.lua, keymaps.lua)
- `nvim/lua/plugins/` - Individual plugin configurations (one file per plugin)

### Script Organization
- `scripts/utils.sh` - Shared logging functions (info, success, error, warning)
- `scripts/prerequisites.sh` - Installs xcode CLI, Homebrew, Oh My Zsh
- `scripts/brew-install-custom.sh` - Runs Brewfile bundle
- `scripts/osx-defaults.sh` - macOS system preferences

### Secrets
- `zsh/zshsecret` is gitignored and sourced by zshrc for sensitive environment variables
