# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
#
source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# activates fzf, use **<TAB> (or e.g. kill -9 <TAB>) to start searching:
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Python Version Manager
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# setting the editor to vim
export VISUAL=vim
export EDITOR="$VISUAL"

# exporting nvm settings
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# setting GOENV
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

# set python for gcloud command
export CLOUDSDK_PYTHON=/usr/bin/python


################### GIT STUFF ###################
github() {
  if [ ! -d .git ] && ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "ERROR: This isnt a git directory" && return false
  fi
  git_url=$(git config --get remote.origin.url)
  if [[ $git_url == https://gitlab* ]]; then
    url=${git_url%.git}
  elif [[ $git_url == https://github* ]]; then
    url=${git_url%.git}
  elif [[ $git_url == git@gitlab* ]]; then
    url=${git_url:4}
    url=${url/\:/\/}
    url="https://${url%.git}"
  elif [[ $git_url == git@github* ]]; then
    url=${git_url:4}
    url=${url/\:/\/}
    url="https://${url%.git}"
  elif [[ $git_url == git://github* ]]; then
    url=${git_url:4}
    url=${url/\:/\/}
    url="https://${url%.git}"
  else
    echo "ERROR: Remote origin is invalid" && return false
  fi
  case $OSTYPE in
  darwin*)
    open $url
    ;;
  *)
    xdg-open $url &> /dev/null &
    ;;
  esac
}

# Aliases
# git aliases
# https://github.com/Bash-it/bash-it/blob/master/aliases/available/git.aliases.bash
alias gcl='git clone'
alias ga='git add'
alias gpristine='git reset --hard && git clean -dfx'
alias gclean='git clean -fd'
alias g='git'
alias gs='git status'
alias gss='git status -s'
alias gsu='git submodule update --init --recursive'
alias gl='git pull'
alias glum='git pull upstream master'
alias gpr='git pull --rebase'
alias gpp='git pull && git push'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gpo='git push origin HEAD'
alias gpu='git push --set-upstream'
alias gpuo='git push --set-upstream origin'
alias gpuoc='git push --set-upstream origin $(git symbolic-ref --short HEAD)'
alias gpom='git push origin master'
alias gr='git remote'
alias grv='git remote -v'
alias gra='git remote add'
alias gd='git diff'
alias gds='git diff --staged'
alias gdv='git diff -w "$@" | vim -R -'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcm='git commit -v -m'
alias gcam="git commit -v -am"
alias gci='git commit --interactive'
alias gcamd='git commit --amend'
alias gb='git branch'
alias gba='git branch -a'
alias gbt='git branch --track'
alias gbm='git branch -m'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gcpx='git cherry-pick -x'
alias gco='git checkout'
alias gcom='git checkout master'
alias gcb='git checkout -b'
alias gcob='git checkout -b'
alias gct='git checkout --track'
alias gcpd='git checkout master; git pull; git branch -D'
alias gexport='git archive --format zip --output'
alias gdel='git branch -D'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
alias ggs="gg --stat"
alias gsl="git shortlog -sn"
alias gwc="git whatchanged"
alias gt="git tag"
alias gta="git tag -a"
alias gtd="git tag -d"
alias gtl="git tag -l"
# From http://blogs.atlassian.com/2014/10/advanced-git-aliases/
# Show commits since last pull
alias gnew="git log HEAD@{1}..HEAD@{0}"
# Add uncommitted and unstaged changes to the last commit
alias gcaa="git commit -a --amend -C HEAD"
alias ggui="git gui"
alias gcsam="git commit -S -am"
alias gst="git stash"
alias gstb="git stash branch"
alias gstd="git stash drop"
alias gstl="git stash list"
alias gstp="git stash pop"
# Show untracked files
alias gu='git ls-files . --exclude-standard --others'

case $OSTYPE in
  darwin*)
    alias gtls="git tag -l | gsort -V"
    ;;
  *)
    alias gtls='git tag -l | sort -V'
    ;;
esac
