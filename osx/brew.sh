#!/bin/sh

if test ! $(which brew); then
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing homebrew packages..."

# update
brew update
brew doctor
brew install cask

# cli tools
brew install tree
brew install wget
brew install iTerm2
# caps lock to esc
brew cask install seil
cd ~/Downloads  
wget https://raw.github.com/altercation/solarized/master/iterm2-colors-solarized/Solarized%20Dark.itermcolors

# development tools
brew install git
brew install hub
brew install vim --with-lua
brew install reattach-to-user-namespace
brew install tmux
brew install zsh
chsh -s /bin/zsh
brew install highlight
brew install markdown
brew install go

# frontend tools
brew install node
npm install gulp

# android, mono
brew install android-sdk
brew install android-ndk
brew install mono

# database
brew install postgresql

# development server setup
brew install nginx

# install Data Science stuff
# download python
brew install python

# download R
brew tap homebrew/science
brew install gcc
brew install Caskroom/cask/xquartz
brew install r
brew install Caskroom/cask/rstudio

# install Julia
brew tap staticfloat/julia
brew install --HEAD --64bit julia

# install Neovim
brew tap neovim/neovim
brew install --HEAD neovim

# install fun
brew install cmatrix

exit 0
