# Dotfiles

My personal dotfiles managed with GNU Stow.

## Setup

### Prerequisites

- macOS
- [Homebrew](https://brew.sh/)
- GNU Stow: `brew install stow`

### Quick Installation (Automated)

```bash
git clone https://github.com/aanctil26/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

The install script will:
- Back up your existing dotfiles
- Install GNU Stow and dependencies
- Create symlinks for all configs
- Install Oh My Zsh, Powerlevel10k, and zsh plugins
- Install UV (Python package manager)

### Manual Installation

1. Clone this repo:
```bash
git clone https://github.com/aanctil26/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

2. Install packages using Stow:
```bash
# Install all packages
stow */

# Or install specific packages
stow zsh
stow nvim
stow kitty
stow sketchybar
stow tmux
stow git
stow borders
stow aerospace
```

3. Install dependencies:
```bash
# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

# UV (Python package manager)
brew install uv
```

## Packages

- **zsh**: Zsh config with Powerlevel10k theme
- **nvim**: Neovim config with NvChad
- **kitty**: Kitty terminal config
- **sketchybar**: SketchyBar status bar config
- **tmux**: Tmux config
- **git**: Git config
- **borders**: JankyBorders config
- **aerospace**: AeroSpace window manager config

## Usage

### Adding new dotfiles

```bash
# Create package directory if it doesn't exist
mkdir -p ~/dotfiles/package_name

# Copy your config (maintaining directory structure from ~/)
cp ~/.some_config ~/dotfiles/package_name/.some_config

# Stow it
cd ~/dotfiles
stow package_name
```

### Updating dotfiles

You can edit files in two ways:

**Option 1: Edit symlinked files directly**
Just edit the files in `~/dotfiles/` - they're symlinked to your actual config locations!

**Option 2: Edit actual configs and sync back**
Edit your actual config files (e.g., `~/.zshrc`), then sync changes back to the repo:
```bash
cd ~/dotfiles
./sync.sh push
```

### Syncing between machines

**Pull latest changes from GitHub:**
```bash
cd ~/dotfiles
./sync.sh pull
# or just: ./sync.sh
```

**Push local changes to GitHub:**
```bash
cd ~/dotfiles
./sync.sh push
```

### Removing a package

```bash
cd ~/dotfiles
stow -D package_name
```

## New Machine Setup

```bash
# Clone repo
git clone https://github.com/aanctil26/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install all configs
stow */

# Install dependencies (see Installation section above)
```
