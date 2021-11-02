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

echo "Installing Xcode Command Line Tools."
# Install Xcode command line tools
xcode-select --install

# set qvartz windows to repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

echo "Setting trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

# Disable auto-correct
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

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

# Finder: allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Tweak the spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float .5

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Show the ~/Library folder
chflags nohidden ~/Library

# top left corner, display to sleep
defaults write com.apple.dock wvous-tl-corner -int 10
defaults write com.apple.dock wvous-tl-modifier -int 0

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

#echo "only use UTF-8 in Terminal.app"
#defaults write com.apple.terminal StringEncodings -array 4

#####
# Dock & Mission Control
#####
echo "Wipe all (default) app icons from the Dock? (y/n)"
echo "(This is only really useful when setting up a new Mac, or if you don't use the Dock to launch apps.)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults write com.apple.dock persistent-apps -array
fi

echo "Setting the icon size of Dock items to 36 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 36

echo "Hide the menu bar? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults write "Apple Global Domain" "_HIHideMenuBar" 1
fi

echo "Dont animate opening applications from the Dock"
defaults write com.apple.dock launchanim -bool false

echo "Enable tap to click (Trackpad)"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

echo "Disable hide animation on Dock"
defaults write com.apple.dock autohide-time-modifier -int 0

echo "Kill affected applications"
for app in "Activity Monitor" "Address Book" "Calendar" "Contacts" "cfprefsd" \
    "Dock" "Finder" "Google Chrome" "Google Chrome Canary" "Mail" "Messages" \
    "Opera" "Safari" "SizeUp" "Numbers" "Keynote" "TV" "SystemUIServer" \
    "Transmission" "Twitter" "iCal"; do
    killall "${app}" > /dev/null 2>&1
done

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


    # Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
    brew install findutils
    # Install GNU `sed`, overwriting the built-in `sed`.
    brew install gnu-sed
    # Install Bash 4.
    brew install bash
    brew tap homebrew/versions
    brew install bash-completion2
    # We installed the new shell, now we have to activate it
    echo "Adding the newly installed shell to the list of allowed shells"
    # Prompts for password
    sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells'

    # Install more recent versions of some OS X tools.
    brew install --HEAD luajit
    brew install --HEAD neovim
    brew install homebrew/grep
    brew install homebrew/openssh
    brew install homebrew/screen
    # cli tools
    brew install tree
    brew install the_silver_searcher
    brew install fzf
    brew install ctags

    # Install version control binaries.
    brew install git

    # backend stuffz
    brew install gvm
    brew install rust
    
    # frontend tools
    brew install nvm
    brew install jq

    # database
    brew install postgresql
    brew install pgcli

    # Install Cask
    echo "Installing Applications"

    brew install --cask --appdir="/Applications" slack
    brew install --cask --appdir="/Applications" visual-studio-code
    brew install --cask --appdir="/Applications" iterm2
    brew install --cask --appdir="/Applications" 1password
    brew install --cask --appdir="/Applications" google-chrome
    brew install --cask --appdir="/Applications" spectacle #panes for mac
    brew install --cask --appdir="/Applications" tableplus

    # Install developer friendly quick look plugins; see
    # https://github.com/sindresorhus/quick-look-plugins
    brew install qlcolorcode qlstephen qlmarkdown quicklook-json qlimagesize suspicious-package apparency quicklookase qlvideo
    # best fontttty
    brew tap homebrew/cask-fonts
    brew install --cask font-hack-nerd-font
    
    # install fun
    brew install ponysay
    brew install cmatrix

    brew cleanup

    # Restart shell
    exec -l $SHELL
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done2>/dev/null &
