#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Function to restore backup and remove symlink
restore_backup() {
    local target="$1"
    
    if [ -L "$target" ]; then
        print_status "Removing symlink: $target"
        rm "$target"
        
        if [ -e "$target.backup" ]; then
            print_status "Restoring backup: $target.backup -> $target"
            mv "$target.backup" "$target"
            print_success "Restored $target"
        fi
    elif [ -e "$target.backup" ]; then
        print_warning "Found backup but no symlink for $target"
    fi
}

print_warning "This will remove all dotfiles symlinks and restore backups"
read -p "Are you sure you want to continue? (y/N): " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_status "Uninstall cancelled"
    exit 1
fi

# Stop services
print_status "Stopping services..."
brew services stop sketchybar 2>/dev/null || true
brew services stop borders 2>/dev/null || true
killall AeroSpace 2>/dev/null || true

# Restore configurations
print_status "Restoring original configurations..."

restore_backup "$HOME/.aerospace.toml"
restore_backup "$HOME/.config/nvim"
restore_backup "$HOME/.config/sketchybar"
restore_backup "$HOME/.config/borders"
restore_backup "$HOME/.config/git"
restore_backup "$HOME/.zshrc"
restore_backup "$HOME/.bash_profile"

print_success "Dotfiles uninstalled successfully!"
print_status "The applications (AeroSpace, SketchyBar, etc.) are still installed."
print_status "Run 'source ~/.zshrc' or restart your terminal to reload shell configs."