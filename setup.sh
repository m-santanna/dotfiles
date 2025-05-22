#!/bin/bash

set -e  # Exit immediately if any command fails

echo "🔧 Setting up your system..."

# Step 1: Install Homebrew packages from Brewfile
if [[ -f "Brewfile" && $(command -v brew) ]]; then
  read -p "Do you want to install Homebrew packages? (y/N): " answer
  if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
    echo "🏗️  Installing Homebrew packages from Brewfile..."
    brew bundle --file=Brewfile
  else 
    echo "⏩ Skipping Homebrew package installation"
  fi
else
  echo "⚠️  No Brewfile found or Homebrew not installed. Skipping Homebrew installation."
fi

# Step 2: Symlink dotfiles using stow
read -p "We are about to symlink all the files from this directory. Want to proceed? (y/N): " answer
if [[ "$answer" == "y" || "$answer" == "Y" ]]; then
  echo "🔗 Symlinking dotfiles with stow..."
  stow */
  echo "✅ Dotfiles installation complete!"
else
  echo "⏩ Skipping symlink. You can install them individually with: stow <dirName>"
fi

echo "👍 Script ran successfully."
