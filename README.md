# dotfiles

Welcome to the wonderful world of me and my terminal setup. This is a collection of vim, and zsh configurations.
Learn to love Vim, because it's worth the effort.

## Contents

+ zsh configuration
+ vim configuration
+ git configuration
+ osx configuration
+ Homebrew files (brew.sh)

## ZSH Plugins
By default, the `.zshrc` file will source any file within `dotfiles/common`

## Vim Plugins
If you are a first timer try to use some plugins and commands each new week or so.
Vim plugins are managed with [vim-plug](https://github.com/junegunn/vim-plug). 
To install, run `vim +PlugInstall`, or in vim `:PluginInstall`.

Also map the Capslock-key to Esc!!!

## Install OSX

1. install homebrew; `ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`
1. install git via; `brew install git`
1. `git clone https://github.com/eleijonmarck/dotfiles.git`
1. `cd ~/dotfiles`
1. `sh brew.sh`
1. `sh install.sh`


---

![alt text](http://yannesposito.com/Scratch/img/blog/Learn-Vim-Progressively/uber_leet_use_vim.jpg "You are 1337!")
