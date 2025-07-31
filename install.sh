#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to backup existing files
backup_file() {
    if [ -e "$1" ]; then
        print_warning "Backing up existing $1 to $1.backup"
        mv "$1" "$1.backup"
    fi
}

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    if [ -e "$target" ] || [ -L "$target" ]; then
        backup_file "$target"
    fi
    
    mkdir -p "$(dirname "$target")"
    ln -sf "$source" "$target"
    print_success "Linked $source -> $target"
}

# Get the directory where this script is located
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_status "Starting dotfiles installation from $DOTFILES_DIR"

# Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    print_status "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    print_success "Homebrew installed"
else
    print_status "Homebrew already installed"
fi

# Install required applications
print_status "Installing required applications..."

# Check if aerospace is installed
if ! command -v aerospace &> /dev/null; then
    print_status "Installing AeroSpace..."
    brew install --cask nikitabobko/tap/aerospace
    print_success "AeroSpace installed"
else
    print_status "AeroSpace already installed"
fi

# Check if sketchybar is installed
if ! command -v sketchybar &> /dev/null; then
    print_status "Installing SketchyBar..."
    brew tap FelixKratz/formulae
    brew install sketchybar
    print_success "SketchyBar installed"
else
    print_status "SketchyBar already installed"
fi

# Check if borders is installed
if ! command -v borders &> /dev/null; then
    print_status "Installing Borders..."
    brew tap FelixKratz/formulae
    brew install borders
    print_success "Borders installed"
else
    print_status "Borders already installed"
fi

# Check if neovim is installed
if ! command -v nvim &> /dev/null; then
    print_status "Installing Neovim..."
    brew install neovim
    print_success "Neovim installed"
else
    print_status "Neovim already installed"
fi

# Install JetBrains Mono Nerd Font (NvChad compatible)
print_status "Installing JetBrains Mono Nerd Font..."
if ! brew list --cask font-jetbrains-mono-nerd-font &> /dev/null; then
    brew tap homebrew/cask-fonts
    brew install --cask font-jetbrains-mono-nerd-font
    print_success "JetBrains Mono Nerd Font installed"
else
    print_status "JetBrains Mono Nerd Font already installed"
fi

# Install NvChad dependencies
print_status "Installing NvChad dependencies..."

# Install ripgrep for Telescope
if ! command -v rg &> /dev/null; then
    brew install ripgrep
    print_success "ripgrep installed"
else
    print_status "ripgrep already installed"
fi

# Install make (usually pre-installed on macOS with Xcode CLI tools)
if ! command -v make &> /dev/null; then
    print_status "Installing Xcode Command Line Tools (required for make/gcc)..."
    xcode-select --install
    print_success "Xcode Command Line Tools installed"
else
    print_status "make already available"
fi

# Install Oh-My-Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    print_status "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_success "Oh-My-Zsh installed"
else
    print_status "Oh-My-Zsh already installed"
fi

# Install Powerlevel10k theme
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
    print_status "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
    print_success "Powerlevel10k theme installed"
else
    print_status "Powerlevel10k theme already installed"
fi

# Install uv (Python package manager)
if ! command -v uv &> /dev/null; then
    print_status "Installing uv Python manager..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
    print_success "uv installed"
else
    print_status "uv already installed"
fi

# Install NvChad
print_status "Installing NvChad..."
backup_file "$HOME/.config/nvim"
backup_file "$HOME/.local/share/nvim"
backup_file "$HOME/.local/state/nvim"
backup_file "$HOME/.cache/nvim"

git clone https://github.com/NvChad/starter ~/.config/nvim

# Remove .git folder as recommended by NvChad docs
rm -rf ~/.config/nvim/.git

print_success "NvChad installed"
print_status "⚠️  Remember to run ':MasonInstallAll' after first Neovim launch"

# Create symlinks for configurations
print_status "Creating configuration symlinks..."

# AeroSpace
create_symlink "$DOTFILES_DIR/aerospace/.aerospace.toml" "$HOME/.aerospace.toml"

# NvChad is already installed, copy custom configs if they exist
if [ -d "$DOTFILES_DIR/config/nvim/lua/custom" ]; then
    print_status "Copying custom NvChad configurations..."
    cp -r "$DOTFILES_DIR/config/nvim/lua/custom" "$HOME/.config/nvim/lua/"
    print_success "Custom NvChad configs copied"
fi

# SketchyBar
create_symlink "$DOTFILES_DIR/config/sketchybar" "$HOME/.config/sketchybar"

# Borders
create_symlink "$DOTFILES_DIR/config/borders" "$HOME/.config/borders"

# Git (if exists)
if [ -d "$DOTFILES_DIR/config/git" ]; then
    create_symlink "$DOTFILES_DIR/config/git" "$HOME/.config/git"
fi

# Shell configurations
create_symlink "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/shell/.bash_profile" "$HOME/.bash_profile"

# Start services
print_status "Starting services..."

# Start SketchyBar
brew services start sketchybar
print_success "SketchyBar started"

# Start Borders
brew services start borders
print_success "Borders started"

# Start AeroSpace (it should auto-start, but we can restart it)
killall AeroSpace 2>/dev/null || true
open -a AeroSpace
print_success "AeroSpace started"

print_success "Dotfiles installation complete!"
print_status "Please restart your terminal or run 'source ~/.zshrc' to load shell configurations"
print_status "You may need to log out and log back in for all changes to take effect"