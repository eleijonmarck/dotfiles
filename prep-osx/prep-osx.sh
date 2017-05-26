#!/usr/bin/env bash

# inspiration
# https://github.com/donnemartin/dev-setup/blob/master/osx.sh

# Ask for the administrator password upfront
sudo -v

# Sets the system language to english
languagesetup -langspec English

echo "Installing Xcode Command Line Tools."
# Install Xcode command line tools
xcode-select --install

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

    # Upgrade any already-installed formulae.
    brew upgrade --all

    # Install GNU core utilities (those that come with OS X are outdated).
    # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
    brew install coreutils
    sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum


    # Install some other useful utilities like `sponge`.
    brew install moreutils
    # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
    brew install findutils
    # Install GNU `sed`, overwriting the built-in `sed`.
    brew install gnu-sed --with-default-names
    # Install Bash 4.
    brew install bash
    brew tap homebrew/versions
    brew install bash-completion2
    # We installed the new shell, now we have to activate it
    echo "Adding the newly installed shell to the list of allowed shells"
    # Prompts for password
    sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'
    # Change to the new shell, prompts for password
    chsh -s /usr/local/bin/bash

    # Install more recent versions of some OS X tools.
    brew install zsh
    brew install vim --override-system-vi
    brew install homebrew/dupes/grep
    brew install homebrew/dupes/openssh
    brew install homebrew/dupes/screen
    # cli tools
    brew install tree
    brew install the_silver_searcher
    brew install fzf
    # install Neovim
    brew tap neovim/neovim
    brew install --HEAD neovim

    # download python
    # Install Python
    brew install python
    brew install python3

    # Install other useful binaries.
    brew install git
    brew install git-lfs
    brew install git-flow
    brew install git-extras
    brew install ssh-copy-id

    brew install libxml2
    brew install libxslt
    brew link libxml2 --force
    brew link libxslt --force

    # frontend tools
    brew install node

    # database
    brew install postgresql

    # Install Cask
    echo "Installing Applications"
    brew install caskroom/cask/brew-cask

    brew cask install --appdir="/Applications" vagrant
    brew cask install --appdir="/Applications" slack
    brew cask install --appdir="/Applications" virtualbox
    brew cask install --appdir="/Applications" visual-studio-code
    brew cask install --appdir="/Applications" iterm2
    brew cask install --appdir="/Applications" 1password
    brew cask install --appdir="/Applications" google-chrome
    brew cask install --appdir="/Applications" evernote
    brew cask install --appdir="/Applications" spectacle #panes for mac

    # Install developer friendly quick look plugins; see
    # https://github.com/sindresorhus/quick-look-plugins
    brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json
    qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook
    suspicious-package

    # install fun
    brew install ponysay
    brew install cmatrix

    brew cleanup

    sudo pip install gsutil
    sudo pip install ansible

    # Restart shell
    exec -l $SHELL
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done2>/dev/null &

        echo "Installing vagrant plugins"
        vagrant plugin install vagrant-triggers
        vagrant plugin install vagrant-multi-hostsupdater
