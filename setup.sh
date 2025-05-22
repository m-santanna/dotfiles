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

echo "🔧 Setting up your system..."

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

echo "👍 Setup script finished."
