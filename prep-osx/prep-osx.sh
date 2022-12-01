#!/usr/bin/env bash

# inspiration
# https://github.com/donnemartin/dev-setup/blob/master/osx.sh

# os-x for hackers
# https://gist.github.com/brandonb927/3195465

# Ask for the administrator password upfront
sudo -v

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# Sets the system language to english
languagesetup -langspec English

# Set a blazingly fast keyboard repeat rate
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

echo "Setting trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write -g AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# top left corner, display to sleep
defaults write com.apple.dock wvous-tl-corner -int 10
defaults write com.apple.dock wvous-tl-modifier -int 0

# Stop bouncing dock icon notifications
defaults write com.apple.dock no-bouncing -bool TRUE

echo "Dont animate opening applications from the Dock"
defaults write com.apple.dock launchanim -bool false

echo "Enable tap to click (Trackpad)"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

# Install command-line tools using Homebrew.

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

    # Check for Homebrew,
    # Install if we don't have it
    if test !$(which brew); then
        echo "Installing homebrew..."
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    # Make sure we’re using the latest Homebrew.
    brew update

    # backend stuffz
    brew install gvm # go version manager
    brew install rust
    

    # ----- terminal ------
    # neovim HEAD - 
    brew install --HEAD luajit
    brew install --HEAD neovim
    # terminal
    brew install tmux
    brew install jq

    # tldr
    brew install tldr
    # cli tools
    brew install fzf
    brew install ripgrep
    brew install the_silver_searcher

    # replacement for ls
    brew install exa
    # great fuzzy searching for folders
    brew install zoxide

    # checking bash scripts and giving hints
    brew install shellcheck

    # measure code complexity
    brew install scc

    # best fontttty
    brew tap homebrew/cask-fonts
    brew install --cask font-hack-nerd-font
    brew install --cask font-fira-code


    # make gifs
    brew install --cask kap

    # so that itunes never plays songs
    brew install --cask notunes

    # Install Cask
    echo "Installing Applications"

    brew install --cask --appdir="/Applications" slack
    brew install --cask --appdir="/Applications" visual-studio-code
    brew install --cask --appdir="/Applications" iterm2
    brew install --cask --appdir="/Applications" 1password
    brew install --cask --appdir="/Applications" google-chrome
    brew install --cask --appdir="/Applications" keycast #panes for mac
    brew install --cask --appdir="/Applications" notion

    brew cleanup

    # Restart shell
    exec -l $SHELL
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done2>/dev/null &
