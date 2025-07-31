# Andrew's Dotfiles

A complete macOS development environment setup featuring AeroSpace window management, SketchyBar status bar, Neovim, and custom shell configurations.

## 🚀 Quick Start

**One-command installation:**

```bash
curl -fsSL https://raw.githubusercontent.com/aanctil26/dotfiles/main/install.sh | bash
```

Or clone and install manually:

```bash
git clone https://github.com/aanctil26/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## 📦 What's Included

### Window Management
- **AeroSpace** - Tiling window manager for macOS
- **Borders** - Window border highlighting

### Status Bar
- **SketchyBar** - Highly customizable status bar
- Custom plugins for AeroSpace integration
- System monitoring widgets

### Development Tools
- **Neovim** - Complete IDE-like setup
- **Git** - Custom configurations and aliases
- **Shell** - Zsh and Bash configurations with aliases and functions

## 📁 Repository Structure

```
dotfiles/
├── aerospace/
│   └── .aerospace.toml          # AeroSpace window manager config
├── config/
│   ├── nvim/                    # Neovim configuration
│   ├── sketchybar/              # SketchyBar setup with plugins
│   ├── borders/                 # Borders configuration
│   └── git/                     # Git configuration
├── shell/
│   ├── .zshrc                   # Zsh configuration
│   └── .bash_profile            # Bash configuration
├── install.sh                   # Automated installation script
└── README.md                    # This file
```

## 🛠 Manual Installation

If you prefer to install components individually:

### Prerequisites

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add FelixKratz tap for SketchyBar and Borders
brew tap FelixKratz/formulae
```

### Install Applications

```bash
# AeroSpace (tiling window manager)
brew install --cask nikitabobko/tap/aerospace

# SketchyBar (status bar)
brew install sketchybar

# Borders (window highlighting)
brew install borders

# Neovim
brew install neovim
```

### Create Symlinks

```bash
# AeroSpace
ln -sf ~/dotfiles/aerospace/.aerospace.toml ~/.aerospace.toml

# Neovim
ln -sf ~/dotfiles/config/nvim ~/.config/nvim

# SketchyBar
ln -sf ~/dotfiles/config/sketchybar ~/.config/sketchybar

# Borders
ln -sf ~/dotfiles/config/borders ~/.config/borders

# Shell configurations
ln -sf ~/dotfiles/shell/.zshrc ~/.zshrc
ln -sf ~/dotfiles/shell/.bash_profile ~/.bash_profile
```

### Start Services

```bash
# Start SketchyBar
brew services start sketchybar

# Start Borders
brew services start borders

# Start AeroSpace
open -a AeroSpace
```

## 🔧 Configuration Details

### AeroSpace
- Custom keybindings for window management
- Workspace organization
- Integration with SketchyBar

### SketchyBar
- System information display
- AeroSpace workspace indicators
- Custom styling and colors

### Neovim
- LSP configurations
- Plugin management
- Custom keybindings and themes

## 🚨 Backup

The install script automatically backs up existing configurations to `.backup` files. You can restore them if needed:

```bash
# Example: restore original zshrc
mv ~/.zshrc.backup ~/.zshrc
```

## 🔄 Updating

To update your dotfiles:

```bash
cd ~/dotfiles
git pull origin main
./install.sh
```

## 🐛 Troubleshooting

### Services not starting
```bash
# Restart SketchyBar
brew services restart sketchybar

# Restart Borders
brew services restart borders

# Restart AeroSpace
killall AeroSpace && open -a AeroSpace
```

### Permission issues
```bash
# Make install script executable
chmod +x ~/dotfiles/install.sh
```

### Symlink conflicts
The install script will automatically backup existing files. If you encounter issues:

```bash
# Remove broken symlinks
find ~ -type l -exec test ! -e {} \; -print | xargs rm

# Re-run installation
~/dotfiles/install.sh
```

## 📝 Customization

Each configuration is modular and can be customized:

1. **AeroSpace**: Edit `aerospace/.aerospace.toml`
2. **SketchyBar**: Modify files in `config/sketchybar/`
3. **Neovim**: Update `config/nvim/` files
4. **Shell**: Edit `shell/.zshrc` or `shell/.bash_profile`

After making changes, either restart the relevant service or re-run the install script.

## 🤝 Contributing

Feel free to fork this repository and customize it for your own needs. If you find improvements or fixes, pull requests are welcome!

## 📄 License

This project is open source and available under the [MIT License](LICENSE).