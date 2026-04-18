# Dotfiles Guide

This repository helps you maintain consistent shell and tool configurations across all your machines.

## Setup

Run the setup script to install all dotfiles:

```bash
./setup.sh
```

This script will:
- Backup existing files with `.backup.TIMESTAMP` suffix
- Symlink dotfiles to their standard locations
- Handle both bash and fish shells

## Current Dotfiles

### `dotfiles/bash/.bashrc`
Your bash shell configuration with aliases, history settings, and environment variables.

### `dotfiles/fish/config.fish`
Your fish shell configuration with aliases and custom greetings.

### `dotfiles/git/.gitconfig`
Git global configuration (see details below).

---

## Other Dotfiles to Consider

### 🔧 Git Configuration (`.gitconfig`)
**Why add it?** Git config is incredibly powerful for customizing your workflow across all machines.

**Key benefits:**
- **Consistent aliases** across all machines (`git st`, `git visual`, `git amend`)
- **Global settings** that prevent accidents (`pull.rebase = false`, `push.default = simple`)
- **Credential management** (store SSH keys securely)
- **Tool integration** (difftool, mergetool settings)
- **Auto-fetch pruning** to keep remote branches clean
- **Default branch naming** (e.g., `main` instead of `master`)

**Example aliases you could use:**
```
git st              # status
git co              # checkout
git amend           # modify last commit without changing message
git pushf           # force push safely (prevents accidents)
git visual          # pretty log graph
```

### 📝 Text Editor Configs
**Vim/Neovim** (`.vimrc` or `nvim/init.vim`)
- Custom keybindings, plugins, color schemes
- Code indentation preferences
- Faster editing across machines

**VS Code** (`settings.json`, `extensions.json`)
- Consistent editor settings
- Installed extensions list
- Theme and font preferences

### 🔐 SSH Config (`.ssh/config`)
**Why?** Centralize SSH hosts, keys, and connection settings
```bash
Host github.com
    IdentityFile ~/.ssh/github_key
    User git

Host homelab
    HostName 192.168.1.100
    User charles
    IdentityFile ~/.ssh/homelab_key
    Port 22
```

### 🖥️ Terminal/Theme Files
**Starship** (terminal prompt) - `~/.config/starship.toml`
- Custom terminal prompt with git status, language versions
- Fast and minimal

**Alacritty** (terminal emulator) - `~/.config/alacritty/alacritty.yml`
- Terminal colors, font, keybindings

### 📋 System Tools
**tmux** (`~/.tmux.conf`)
- Terminal multiplexer configuration
- Custom keybindings, colors, pane management

**Docker** (`~/.docker/config.json`)
- Docker daemon settings, credentials

**npm** (`.npmrc`)
- npm registry settings, auth tokens, default package manager options

---

## Recommended Expansion

Based on your `.bashrc` (NVM, Docker aliases, SSH startup script), I'd suggest adding:

1. **Git config** - You're already using `git commit -m`, `-status`, so this would be super useful
2. **SSH config** - Centralize your homelab connections
3. **Starship or custom prompt** - Make your terminal more informative
4. **Docker compose** - Keep compose file templates or presets

---

## Tips

✅ **Use symlinks** instead of copies for configurations you update frequently  
✅ **Keep sensitive data out** - Don't commit auth tokens, API keys, or passwords  
✅ **Use `.gitignore_global`** - Set this in `.gitconfig` to exclude files from all repos  
✅ **Test on a new machine** - Before finalizing, set up in a VM to verify everything works  
✅ **Document your setup** - Add comments explaining *why* you set each config

---

## Running Setup

```bash
# Make setup script executable (already done)
chmod +x setup.sh

# Run setup
./setup.sh

# Reload your shell
source ~/.bashrc   # for bash
# or
exec fish          # for fish
```
