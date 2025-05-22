# 🛠️ dotfiles

Personal dotfiles for macOS setup, managing CLI tools, Neovim config, Zsh environment, and more — using `stow` for clean symlinking and `Homebrew` for package management.

---

## ✨ Features

- 📦 Easy install script for packages and configs
- 🔗 Dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/)
- 🧠 Clean directory structure for modularity
- ⚙️ Includes:
  - [Neovim](https://neovim.io) config
  - [Starship](https://starship.rs/) prompt
  - Zsh setup with plugins
  - CLI tools: `fzf`, `zoxide`, `eza`, `bat`, `tldr`, `ripgrep`, etc.

---

## 🚀 Installation

### 1. Install homebrew

If you don't have it:

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Clone this repo

```zsh
git clone https://github.com/m-santanna/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

_Note: We clone to `~/dotfiles`. `stow` will create symlinks from here into our home directory (`~`)._

### 3. Run the setup script

```zsh
./setup.sh
```

## ⚙️ Usage with Stow

### Understanding the Structure

`GNU Stow` is a symlink farm manager. It takes files from a "source" directory (e.g., `~/dotfiles/zsh`) and creates symlinks to them in a "target" directory (by default, the parent of the source directory, which is `~` since our dotfiles are in `~/dotfiles`).

For example, if you have:
`~/dotfiles/zsh/.zshrc`

Running `stow zsh` (from within `~/dotfiles`) will create a symlink:
`~/.zshrc` -> `~/dotfiles/zsh/.zshrc`

This keeps our actual configuration files neatly organized in your `~/dotfiles` repository.

### Unstowing Packages

To remove the symlinks for a package (e.g., `nvim`):

```zsh
stow -D nvim
```

This removes the symlinks but leaves your actual configuration files in ~/dotfiles/nvim/ intact.

### Updating Changes

### 1. Pull the remote changes.

```zsh
cd ~/dotfiles
git pull origin main
```

### 2. Stow them!

```zsh
stow */
```

### 3. Install/Upgrade brew packages

```zsh
brew bundle upgrade
```

### 4. Source .zshrc

```zsh
source ~/.zshrc
```
