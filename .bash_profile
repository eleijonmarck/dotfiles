#!/bin/bash
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/ericleijonmarck/.sdkman"
[[ -s "/Users/ericleijonmarck/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/ericleijonmarck/.sdkman/bin/sdkman-init.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ericleijonmarck/dev/projects/enplore-development/prepare-osx/Theonlygay1/google-cloud-sdk/path.bash.inc' ]; then source '/Users/ericleijonmarck/dev/projects/enplore-development/prepare-osx/Theonlygay1/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ericleijonmarck/dev/projects/enplore-development/prepare-osx/Theonlygay1/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/ericleijonmarck/dev/projects/enplore-development/prepare-osx/Theonlygay1/google-cloud-sdk/completion.bash.inc'; fi
