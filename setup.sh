#!/bin/bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$REPO_DIR/dotfiles"

echo "🚀 Setting up dotfiles from $REPO_DIR..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to symlink or copy file
setup_file() {
    local src="$1"
    local dest="$2"
    local use_symlink="${3:-true}"
    
    if [ ! -f "$src" ]; then
        echo -e "${YELLOW}⚠ Source not found: $src${NC}"
        return 1
    fi
    
    # Create backup if destination exists
    if [ -f "$dest" ]; then
        local backup="$dest.backup.$(date +%s)"
        echo -e "${YELLOW}Backing up existing file to: $backup${NC}"
        cp "$dest" "$backup"
    fi
    
    if [ "$use_symlink" = true ]; then
        mkdir -p "$(dirname "$dest")"
        ln -sf "$src" "$dest"
        echo -e "${GREEN}✓ Symlinked: $dest -> $src${NC}"
    else
        mkdir -p "$(dirname "$dest")"
        cp "$src" "$dest"
        echo -e "${GREEN}✓ Copied: $src -> $dest${NC}"
    fi
}

# Bash setup
echo -e "\n${BLUE}Setting up Bash...${NC}"
setup_file "$DOTFILES_DIR/bash/.bashrc" "$HOME/.bashrc"
setup_file "$DOTFILES_DIR/bash/.bash_aliases" "$HOME/.bash_aliases"

# Fish setup (if fish is installed)
if command -v fish &> /dev/null; then
    echo -e "\n${BLUE}Setting up Fish shell...${NC}"
    fish_config="$HOME/.config/fish/conf.d"
    mkdir -p "$fish_config"
    
    # Setup config and aliases
    setup_file "$DOTFILES_DIR/fish/config.fish" "$HOME/.config/fish/config.fish"
    setup_file "$DOTFILES_DIR/fish/aliases.fish" "$fish_config/aliases.fish"
    echo -e "${GREEN}✓ Aliases symlinked to: $fish_config/aliases.fish${NC}"
else
    echo -e "${YELLOW}⚠ Fish shell not installed, skipping Fish setup${NC}"
fi

# Git setup
if command -v git &> /dev/null; then
    echo -e "\n${BLUE}Setting up Git...${NC}"
    if [ -f "$DOTFILES_DIR/git/.gitconfig" ]; then
        echo -e "${YELLOW}ℹ Git config found. To apply it:${NC}"
        echo "  Option 1 (merge with existing): git config --global include.path $DOTFILES_DIR/git/.gitconfig"
        echo "  Option 2 (replace): cp $DOTFILES_DIR/git/.gitconfig ~/.gitconfig"
        echo "  (Review the file first, especially the [user] section)"
    fi
else
    echo -e "${YELLOW}⚠ Git not installed, skipping Git setup${NC}"
fi

echo -e "\n${GREEN}✅ Setup complete!${NC}"
echo -e "${BLUE}Tips:${NC}"
echo "  • To reload bash: source ~/.bashrc"
echo "  • To reload fish: exec fish"
echo "  • Backups of existing files are kept with .backup.TIMESTAMP suffix"
echo "  • To undo symlinks: rm ~/.bashrc (will restore symlink if needed)"
