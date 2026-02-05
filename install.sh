#!/bin/bash
set -e

DOTFILES="$HOME/dotfiles"

echo "Installing dotfiles..."

# Backup function
backup_if_exists() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then
        echo "  Backing up existing $1 to $1.backup"
        mv "$1" "$1.backup"
    elif [ -L "$1" ]; then
        echo "  Removing existing symlink $1"
        rm "$1"
    fi
}

# Neovim
echo "Setting up Neovim..."
backup_if_exists "$HOME/.config/nvim"
ln -sf "$DOTFILES/nvim" "$HOME/.config/nvim"
echo "  Linked nvim config"

# Zellij
echo "Setting up Zellij..."
backup_if_exists "$HOME/.config/zellij"
ln -sf "$DOTFILES/zellij" "$HOME/.config/zellij"
echo "  Linked zellij config"

# Ghostty (macOS)
echo "Setting up Ghostty..."
GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
mkdir -p "$GHOSTTY_DIR"
backup_if_exists "$GHOSTTY_DIR/config"
ln -sf "$DOTFILES/ghostty/config" "$GHOSTTY_DIR/config"
echo "  Linked ghostty config"

# Zsh
echo "Setting up Zsh..."
backup_if_exists "$HOME/.zshrc"
backup_if_exists "$HOME/.zprofile"
backup_if_exists "$HOME/.zshenv"
ln -sf "$DOTFILES/zsh/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/zsh/zprofile" "$HOME/.zprofile"
ln -sf "$DOTFILES/zsh/zshenv" "$HOME/.zshenv"
echo "  Linked zsh configs"

echo ""
echo "Done! Restart your shell or run 'source ~/.zshrc'"
