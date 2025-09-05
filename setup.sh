#!/bin/bash

# Navigate to the script's directory to ensure paths are relative to the repo root
cd "$(dirname "$0")"

set -euo pipefail # Exit on error, treat unset variables as error, pipefail

ask_yes_no() {
    local prompt="$1 (y/N): "
    local answer
    read -p "$prompt" answer
    if [[ "${answer}" == "y" || "${answer}" == "Y" ]]; then
        return 0 # Yes
    else
        return 1 # No
    fi
}

#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
#                                  macOS Setup                                 #
#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#

setup_macos() {
    echo "🔧 Setting up your macOS system..."

    # Step 1: Install Homebrew packages from Brewfile
    if command -v brew &> /dev/null; then
      if ask_yes_no "Do you want to install/update Homebrew packages from Brewfile?"; then
        echo "🏗️  Installing/updating Homebrew packages from Brewfile..."
        brew bundle --file="Brewfile"
      else
        echo "⏩ Skipping Homebrew package installation."
      fi
    else
      echo "⚠️ Homebrew (brew) command not found. Skipping Brewfile installation."
      echo "⚠️ Please install Homebrew first: https://brew.sh/"
      echo "⚠️ If it is already installed, run: echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile"
      echo "⚠️ You can later delete that file, since the same config will be in .zshrc"
    fi

    # Step 2: Check for stow and offer to install if missing
    if ! command -v stow &> /dev/null; then
        echo "⚠️ GNU Stow is not installed, which is needed to symlink dotfiles."
        if command -v brew &> /dev/null; then
            if ask_yes_no "Do you want to install Stow using Homebrew?"; then
                brew install stow
            else
                echo "🚫 Stow not installed. Cannot proceed with symlinking. Please install stow and try again."
                exit 1
            fi
        else
            echo "🚫 Stow not installed, and Homebrew is not available to install it. Please install stow manually."
            exit 1
        fi
    fi


    # Step 3: Symlink dotfiles using stow
    if ask_yes_no "We are about to symlink all the files from this directory. Want to proceed?"; then
      echo "🔗 Symlinking dotfiles with stow..."
      stow */
      echo "✅ Dotfiles installation complete!"
    else
      echo "⏩ Skipping symlink. You can install them individually with: stow <dirName>"
    fi

    echo "👍 macOS setup script finished."
}

#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
#                                Arch Linux Setup                              #
#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#

setup_arch() {
    echo "🔧 Setting up your Arch Linux system..."

    # Step 1: Install Zsh and set it as the default shell
    if ask_yes_no "Do you want to install Zsh and set it as your default shell?"; then
        echo "📦 Installing Zsh..."
        sudo pacman -Syu --needed zsh

        # Check if Zsh is already the default shell
        # Use `getent` for a more reliable check than $SHELL
        if [[ "$(getent passwd $USER | cut -d: -f7)" != *"zsh"* ]]; then
            echo "Changing default shell to Zsh..."
            chsh -s $(which zsh)
            echo "✅ Default shell changed to Zsh. Please log out and log back in for the change to take effect."
        else
            echo "👍 Zsh is already your default shell."
        fi
    else
        echo "⏩ Skipping Zsh installation and configuration."
    fi


    # Step 2: Install packages from official repositories
    if ask_yes_no "Do you want to install packages from the official repositories?"; then
        echo "🏗️  Installing packages..."
        sudo pacman -Syu --needed \
            stow \
            bat \
            eza \
            fd \
            fzf \
            neovim \
            ripgrep \
            starship \
            tldr \
            zoxide 
    else
        echo "⏩ Skipping package installation from official repositories."
    fi

    # Step 3: Install AUR packages
    if ask_yes_no "Do you want to install packages from the AUR (requires an AUR helper like yay)?"; then
        if ! command -v yay &> /dev/null; then
            echo "⚠️ yay is not installed. It's a popular AUR helper."
            if ask_yes_no "Do you want to install yay?"; then
                sudo pacman -S --needed git base-devel
                git clone https://aur.archlinux.org/yay.git
                (cd yay && makepkg -si)
            else
                echo "⏩ Skipping AUR package installation."
            fi
        fi

        if command -v yay &> /dev/null; then
            echo "🏗️  Installing AUR packages..."
            yay -S --needed ttf-jetbrains-mono-nerd
        fi
    else
        echo "⏩ Skipping AUR package installation."
    fi


    # Step 4: Check for stow
    if ! command -v stow &> /dev/null; then
        echo "⚠️ GNU Stow is not installed, which is needed to symlink dotfiles."
        if ask_yes_no "Do you want to install Stow using pacman?"; then
            sudo pacman -S stow
        else
            echo "🚫 Stow not installed. Cannot proceed with symlinking. Please install stow and try again."
            exit 1
        fi
    fi

    # Step 5: Symlink dotfiles using stow
    if ask_yes_no "We are about to symlink all the files from this directory. Want to proceed?"; then
        echo "🔗 Symlinking dotfiles with stow..."
        stow */
        echo "✅ Dotfiles installation complete!"
    else
        echo "⏩ Skipping symlink. You can install them individually with: stow <dirName>"
    fi

    echo "👍 Arch Linux setup script finished."
}


#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#
#                                 Main Script                                  #
#––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––#

if [[ "$(uname)" == "Darwin" ]]; then
    setup_macos
elif [[ -f "/etc/arch-release" ]]; then
    setup_arch
else
    echo "Unsupported OS. This script is for macOS and Arch Linux."
    exit 1
fi
