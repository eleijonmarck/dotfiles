#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Set a blazingly fast keyboard repeat rate
defaults write -g InitialKeyRepeat -int 10
defaults write -g KeyRepeat -int 1

defaults write -g ApplePressAndHoldEnabled -bool false

echo "Setting trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Finder preferences
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write -g AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Dock settings
defaults write com.apple.dock wvous-tl-corner -int 10
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock no-bouncing -bool true
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock autohide -bool true

# Enable tap to click (Trackpad)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Keep-alive: update sudo timestamp
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Update Homebrew
brew update

# Install backend tools
brew install goenv  # Alternative to gvm
brew install rust

# Install terminal utilities
brew install --HEAD luajit
brew install neovim --HEAD
brew install jq
brew install tldr
brew install fzf
brew install ripgrep
brew install the_silver_searcher
brew install shellcheck
brew install scc
# kubernetes
brew install kubectl
brew install k9s
brew install coreutils

# Install fonts
brew install --cask font-hack-nerd-font
brew install --cask font-fira-code

# Install applications
echo "Installing Applications..."
brew install --cask slack
brew install --cask visual-studio-code
brew install --cask 1password
brew install --cask notion

# Cleanup
brew cleanup

echo "✅ Setup complete! Restart your shell or computer for changes to take effect."
