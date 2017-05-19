#!/usr/bin/env bash

echo "Installing Xcode Command Line Tools."
# Install Xcode command line tools
xcode-select --install

# inspiration
# https://github.com/donnemartin/dev-setup/blob/master/osx.sh

# Ask for the administrator password upfront
sudo -v

# Disable smart quotes as they’re annoying when typing code
sudo defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
sudo defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
sudo defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Disable press-and-hold for keys in favor of key repeat"
sudo defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
sudo defaults write NSGlobalDomain KeyRepeat -int 1

# Disable auto-correct
sudo defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Require password immediately after sleep or screen saver begins
sudo defaults write com.apple.screensaver askForPassword -int 1
sudo defaults write com.apple.screensaver askForPasswordDelay -int 0

# Finder: disable window animations and Get Info animations
sudo defaults write com.apple.finder DisableAllAnimations -bool true

# Finder: show hidden files by default
sudo defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
sudo defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
sudo #defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
sudo defaults write com.apple.finder ShowPathbar -bool true

# Finder: allow text selection in Quick Look
sudo defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
sudo defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
sudo defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
sudo defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
sudo defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Tweak the spring loading delay for directories
sudo defaults write NSGlobalDomain com.apple.springing.delay -float .5

# Avoid creating .DS_Store files on network volumes
sudo defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
sudo defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
sudo defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
sudo defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
sudo defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Show the ~/Library folder
sudo chflags nohidden ~/Library

# top left corner, display to sleep
sudo defaults write com.apple.dock wvous-tl-corner -int 10
sudo defaults write com.apple.dock wvous-tl-modifier -int 0

# Privacy: don’t send search queries to Apple
sudo defaults write com.apple.Safari UniversalSearchEnabled -bool false
sudo defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Disable send and reply animations in Mail.app
sudo defaults write com.apple.mail DisableReplyAnimations -bool true
sudo defaults write com.apple.mail DisableSendAnimations -bool true

# Copy email addresses as `foo@example.com` instead of `Foo Bar <foo@example.com>` in Mail.app
sudo defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

#echo "only use UTF-8 in Terminal.app"
#defaults write com.apple.terminal StringEncodings -array 4

echo "Enable subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

echo "Dont animate opening applications from the Dock"
sudo defaults write com.apple.dock launchanim -bool false

echo "Enable tap to click (Trackpad)"
sudo defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

echo "Disable hide animation on Dock"
sudo defaults write com.apple.dock autohide-time-modifier -int 0

echo "Move the dock to the left"
sudo defaults write com.apple.dock orientation left

echo "Kill affected applications"
sudo for app in Finder Dock Mail SystemUIServer; do killall "$app" >/dev/null 2>&1; done
