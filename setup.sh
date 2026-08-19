#!/bin/bash

# Define your dotfiles directory
DOTFILES_DIR="$HOME/.dotfiles"

# Safely back up existing .zshrc if it exists
if [ -f "$HOME/.zshrc" ]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.backup"
    echo "Backed up existing .zshrc"
fi

# Create symlink for the main .zshrc
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
echo "Linked .zshrc successfully!"