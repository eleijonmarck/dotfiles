## GIT

# Aliases
# git aliases
alias ga='git add'
alias gpristine='git reset --hard && git clean -dfx'
alias gclean='git clean -fd'
alias g='git'
alias gs='git status'
alias gss='git status -s'
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
alias gd='git diff'
alias gds='git diff --staged'
alias gdv='git diff -w "$@" | vim -R -'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcaa="git commit -a --amend -C HEAD" # Add uncommitted and unstaged changes to the last commit
alias gcm='git commit -v -m'
alias gcam="git commit -v -am"
alias gci='git commit --interactive'
alias gcamd='git commit --amend'
alias gb='git branch'
alias gcount='git shortlog -sn'
alias gco='git checkout'
alias gcom='git checkout master'
alias gcb='git checkout -b'
alias gcob='git checkout -b'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gg="git log --graph --pretty=format:'%C(bold)%h%Creset%C(magenta)%d%Creset %s %C(yellow)<%an> %C(cyan)(%cr)%Creset' --abbrev-commit --date=relative"
alias ggs="gg --stat"
alias gsl="git shortlog -sn"
alias gwc="git whatchanged"



[[ -s "/Users/eleijonmarck/.gvm/scripts/gvm" ]] && source "/Users/eleijonmarck/.gvm/scripts/gvm"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/eleijonmarck/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/eleijonmarck/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/eleijonmarck/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/eleijonmarck/google-cloud-sdk/completion.zsh.inc'; fi

# The next line enables shell command completion for kubectl.
source <(kubectl completion zsh)

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# setup fnm
eval "$(fnm env --use-on-cd --shell zsh)"
export PATH="$(npm prefix -g)/bin:$PATH"

# fast ls
alias ls=eza

# pressing Ctrl+X Ctrl+E will open the command in your configured editor
bindkey "^X^E" vi-edit-command

export DEPLOYMENT_TOOLS_PATH="/Users/eleijonmarck/dev/grafana/deployment_tools/"

# go bin
export PATH="$PATH:$HOME/go/bin"

# 1password agent
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock

# kubectl krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

. "$HOME/.atuin/bin/env"

# atuin
eval "$(atuin init zsh)"


# show branch
parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}
COLOR_DEF='%f'
COLOR_DIR='%F{197}'
COLOR_GIT='%F{39}'
NEWLINE=$'\n'
setopt PROMPT_SUBST
export PROMPT='${COLOR_DIR}%d ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF}${NEWLINE}%% '
