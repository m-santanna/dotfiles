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

We are assuming you don't have any of the directories and files we will be stowing, such as ~/.config/ and ~/.zshrc
Backup any configurations you still want to have to somewhere like ~/backup/, since you will the opportunity to add them later.

### 1. Install homebrew

If you don't have it:

```zsh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Setup homebrew (if needed)

You may find it necessary to run this command, if your homebrew configuration was at ~/.zshrc

```zsh
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
source ~/.zprofile
```

### 3. Clone this repo

```zsh
git clone https://github.com/m-santanna/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

_Note: We clone to `~/dotfiles`. **stow** will create symlinks from here into our home directory (`~`)._

### 4. Run the setup script

```zsh
./setup.sh
or
zsh setup.sh
```

### 5. Source .zshrc

```zsh
source ~/.zshrc
```

Restart your terminal to apply the configuration changes.

### 6. Add files to dotfiles

Now, any of the files you backed up, you should add them to the dotfiles directory, and stow them.
Let's suppose you had a alacritty config. You moved it to somewhere like ~/backup/.config/alacritty/alacritty.toml
Now you move it to ~/dotfiles/alacritty/.config/alacritty/alacritty.toml and run:

```zsh
cd ~/dotfiles
stow alacritty
or
stow */
```

## ⚙️ Usage with Stow

### Understanding the Structure

`GNU Stow` is a symlink farm manager. It takes files from a "source" directory (e.g., `~/dotfiles/zsh`) and creates symlinks to them in a "target" directory (by default, the parent of the source directory, which is `~` since our dotfiles are in `~/dotfiles`).

Imagine a symlink as a pointer. It will create a pointer in our home directory, whom will point to our dotfiles directory. The coolest thing is that you can change things in one place, and they will update in the other.

For example, in:
`~/dotfiles/zsh/.zshrc`

Running `stow zsh` (from within `~/dotfiles`) will create a symlink:
`~/.zshrc` -> `~/dotfiles/zsh/.zshrc`

Wherever you make changes, they will be reflected in the other file. Since in reality, there exists only one file. Isn't that cool?!

This keeps our actual configuration files neatly organized in your `~/dotfiles` repository.

#### You can learn more about these things here:

- Typecraft's [Blog post](https://typecraft.dev/tutorial/never-lose-your-configs-again)
- Typecraft's [YT video](https://www.youtube.com/watch?v=NoFiYOqnC4o)
- Tamerlan's [Blog post](https://tamerlan.dev/how-i-manage-my-dotfiles-using-gnu-stow/)
- And of course... [GNU Stow](https://www.gnu.org/software/stow/)

### Unstowing Packages

To remove the symlinks for a package (e.g., `nvim`):

```zsh
stow -D nvim
```

This removes the symlinks but leaves your actual configuration files in ~/dotfiles/nvim/ intact.

### Updating Changes

#### 1. Pull the remote changes.

```zsh
cd ~/dotfiles
git pull origin main
```

#### 2. Stow them!

```zsh
stow */
```

#### 3. Install/Upgrade brew packages

```zsh
brew bundle upgrade
```

#### 4. Source .zshrc

```zsh
source ~/.zshrc
```
