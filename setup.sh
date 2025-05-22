#!/bin/bash

set -e  # Exit immediately if any command fails

echo "🔧 Setting up your system..."

# Step 1: Install Homebrew packages from Brewfile
if [[ -f "Brewfile" ]]; then
  read -p "Do you want to install Homebrew packages? (y/N): " answer
  if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    echo "🏗️  Installing Homebrew packages from Brewfile..."
    brew bundle --file=Brewfile
  else 
    echo "⏩ Skipping Homebrew package installation"
  fi
else
  echo "⚠️  No Brewfile found. Skipping Homebrew installation."
fi

# Step 2: Symlink dotfiles using stow
echo "🔗 Symlinking dotfiles with stow..."
stow */

echo "✅ Dotfiles installation complete!"
