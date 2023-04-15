#!/usr/bin/env bash
# Setup script for setting up a new macos machine
echo "Starting setup"


if [ "$(uname)" == "Darwin" ]; then
  # install xcode CLI
  xcode-select --install
fi

# Check for Homebrew to be present, install if it's missing
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Change directory ~/.config..."
cd ~/.config/

echo "git cloning dot files..."
git clone git@github.com:Vikaspogu/dotfiles.git nvim

echo "Brew install from bundle file..."
brew bundle install --file=nvim/Brewfile
