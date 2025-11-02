#!/bin/bash

# Dotfiles sync script
# This script syncs your dotfiles between your system and the repo

set -e

DOTFILES_DIR="$HOME/dotfiles"

# Parse arguments
DIRECTION="${1:-pull}"  # Default to pull

if [[ "$DIRECTION" != "pull" && "$DIRECTION" != "push" ]]; then
    echo "Usage: $0 [pull|push]"
    echo "  pull: Pull changes from repo and restow (default)"
    echo "  push: Copy current configs to repo and commit"
    exit 1
fi

cd "$DOTFILES_DIR"

if [[ "$DIRECTION" == "pull" ]]; then
    echo "Pulling latest changes from GitHub..."

    # Pull latest changes
    git pull origin main || git pull origin master

    echo "Restowing all packages..."

    # Restow all packages
    packages=(zsh nvim kitty sketchybar tmux git borders aerospace)

    for package in "${packages[@]}"; do
        if [ -d "$package" ]; then
            echo "  Restowing $package..."
            # Unstow first to remove old symlinks
            stow -D "$package" 2>/dev/null || true
            # Adopt any conflicting files (backup originals to the repo)
            stow --adopt "$package" 2>/dev/null || true
            # Reset adopted files to match repo
            git reset --hard HEAD
            # Stow again to ensure everything is linked
            stow "$package"
        fi
    done

    echo "Sync complete. Configs are up to date."

elif [[ "$DIRECTION" == "push" ]]; then
    echo "Syncing local configs to repo..."

    # Copy current configs to repo
    echo "  Copying zsh configs..."
    cp ~/.zshrc zsh/.zshrc
    cp ~/.p10k.zsh zsh/.p10k.zsh
    cp ~/.bash_profile zsh/.bash_profile

    echo "  Copying tmux config..."
    cp ~/.tmux.conf tmux/.tmux.conf

    echo "  Copying git config..."
    cp ~/.gitconfig git/.gitconfig

    echo "  Copying aerospace config..."
    cp ~/.aerospace.toml aerospace/.aerospace.toml

    echo "  Copying nvim config..."
    rm -rf nvim/.config/nvim
    mkdir -p nvim/.config
    cp -r ~/.config/nvim nvim/.config/

    echo "  Copying kitty config..."
    rm -rf kitty/.config/kitty
    mkdir -p kitty/.config
    cp -r ~/.config/kitty kitty/.config/

    echo "  Copying sketchybar config..."
    rm -rf sketchybar/.config/sketchybar
    mkdir -p sketchybar/.config
    cp -r ~/.config/sketchybar sketchybar/.config/

    echo "  Copying borders config..."
    rm -rf borders/.config/borders
    mkdir -p borders/.config
    cp -r ~/.config/borders borders/.config/

    # Check if there are changes
    if [[ -z $(git status -s) ]]; then
        echo "No changes to commit"
        exit 0
    fi

    # Show changes
    echo ""
    echo "Changes:"
    git status -s
    echo ""

    # Ask for commit message
    read -p "Enter commit message (or press Enter for default): " commit_msg

    if [[ -z "$commit_msg" ]]; then
        commit_msg="Update dotfiles $(date '+%Y-%m-%d %H:%M')"
    fi

    # Commit and push
    git add .
    git commit -m "$commit_msg"

    read -p "Push to GitHub? (y/n): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        git push origin main || git push origin master
        echo "Changes pushed to GitHub"
    else
        echo "Changes committed locally but not pushed"
    fi
fi

echo ""
echo "Done"
