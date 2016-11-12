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
brew install iTerm2
brew install the_silver_searcher
brew install fzf

# caps lock to esc
brew cask install seil

# panes for windows
brew cask install spectacle

# development tools
brew install git
brew install hub
brew install reattach-to-user-namespace
brew install zsh
brew install highlight
brew install markdown
brew install go

# install Neovim
brew tap neovim/neovim
brew install --HEAD neovim

# haskell
brew install ghci cabal-install
brew install haskell-stack

# scala
brew install scala
brew install sbt

# docker installation
brew cask install virtualbox
brew install docker
brew install Caskroom/cask/dockertoolbox

# quicklook smart tools
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package

# frontend tools
brew install node

# database
brew install postgresql

# development server setup
brew install nginx

################## install Data Science stuff #########################
# download python
brew install python

# install  R
brew tap homebrew/science
brew install gcc
brew install Caskroom/cask/xquartz
brew install r
brew install Caskroom/cask/rstudio

# install Julia
brew tap staticfloat/julia
brew install --HEAD --64bit julia

# install fun
brew install cmatrix

exit 0
