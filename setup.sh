#!/bin/bash

# Dotfiles setup script for new machines

set -e

echo "Starting dotfiles setup..."

# Check if we're on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "Error: This script is designed for macOS only"
    exit 1
fi

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    echo "Homebrew already installed"
fi

# Install GNU Stow
if ! command -v stow &> /dev/null; then
    echo "Installing GNU Stow..."
    brew install stow
else
    echo "GNU Stow already installed"
fi

# Backup existing dotfiles
echo "Backing up existing dotfiles..."
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Files to backup
files_to_backup=(
    "$HOME/.zshrc"
    "$HOME/.p10k.zsh"
    "$HOME/.bash_profile"
    "$HOME/.tmux.conf"
    "$HOME/.gitconfig"
    "$HOME/.aerospace.toml"
)

for file in "${files_to_backup[@]}"; do
    if [ -f "$file" ]; then
        cp "$file" "$BACKUP_DIR/"
        echo "  Backed up: $file"
    fi
done

# Backup config directories
config_dirs=(
    "$HOME/.config/nvim"
    "$HOME/.config/kitty"
    "$HOME/.config/sketchybar"
    "$HOME/.config/borders"
)

for dir in "${config_dirs[@]}"; do
    if [ -d "$dir" ]; then
        cp -r "$dir" "$BACKUP_DIR/"
        echo "  Backed up: $dir"
    fi
done

echo "Backup created at: $BACKUP_DIR"

# Stow all packages
echo "Creating symlinks with Stow..."
cd "$HOME/dotfiles"

packages=(zsh nvim kitty sketchybar tmux git borders aerospace)

for package in "${packages[@]}"; do
    if [ -d "$package" ]; then
        echo "  Stowing $package..."
        stow -v "$package"
    fi
done

echo "All dotfiles stowed"

# Install Oh My Zsh if not installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed"
fi

# Install Powerlevel10k
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
else
    echo "Powerlevel10k already installed"
fi

# Install zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
else
    echo "zsh-syntax-highlighting already installed"
fi

# Install zsh-autosuggestions
if [ ! -d "$HOME/.zsh/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions..."
    mkdir -p "$HOME/.zsh"
    git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
else
    echo "zsh-autosuggestions already installed"
fi

# Install UV (Python package manager)
if ! command -v uv &> /dev/null; then
    echo "Installing UV..."
    brew install uv
else
    echo "UV already installed"
fi

echo ""
echo "Setup complete"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal"
echo "  2. If p10k configuration wizard appears, configure your prompt"
echo ""
