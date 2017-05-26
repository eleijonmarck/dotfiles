#!/bin/bash
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/ericleijonmarck/.sdkman"
[[ -s "/Users/ericleijonmarck/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/ericleijonmarck/.sdkman/bin/sdkman-init.sh"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export ADVENT="~/dev/code/adventofcode/2016"
export PATH=/usr/local/bin:$PATH
source /usr/local/bin/virtualenvwrapper.sh
