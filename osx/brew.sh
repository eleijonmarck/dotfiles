#!/bin/sh

if test ! $(which brew); then
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo "Installing homebrew packages..."

# cli tools
brew install tree
brew install wget

# development tools
brew install git
brew install hub
brew install macvim --override-system-vim
brew install reattach-to-user-namespace
brew install tmux
brew install zsh
brew install highlight
brew install markdown
# for use with jupyter
brew install node

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

# install Julia
brew tap staticfloat/julia
brew install --HEAD --64bit julia

# install Neovim
brew tap neovim/neovim
brew install --HEAD neovim


exit 0