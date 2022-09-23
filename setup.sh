#!/usr/bin/env bash
#
# setup.sh:  run the workstation setup
#
# Arguments:
#   - a list of components to install, see scripts/opt-in/ for valid options
#

# Fail immediately if any errors occur
set -e # the shell will exit if a command fails

echo "Caching password..."
sudo -K # clobbers/deletes cached credentials
sudo true; # forces your sign in, runs trivial command
clear

MY_DIR="$(dirname "$0")"  # selects the current directory (always seems to be current directory)

# prevents homebrew from collecting analytics
export HOMEBREW_NO_ANALYTICS=1

# Note: Homebrew needs to be set up first
source ${MY_DIR}/scripts/common/homebrew.sh # sourcing the script so it runs in the current shell

# Install everything else
source ${MY_DIR}/scripts/common/oh-my-zsh.sh
source ${MY_DIR}/scripts/common/editors.sh
source ${MY_DIR}/scripts/common/git.sh
source ${MY_DIR}/scripts/common/git-aliases.sh
source ${MY_DIR}/scripts/common/applications-common.sh
source ${MY_DIR}/scripts/common/developer-utilities.sh
source ${MY_DIR}/scripts/common/unix.sh
source ${MY_DIR}/scripts/common/configuration-osx.sh

# For each command line argument, try executing the corresponding script in opt-in/
for var in "$@"
do
    echo "$var"
    FILE=${MY_DIR}/scripts/opt-in/${var}.sh
    echo "$FILE"
    if [ -f $FILE ]; then
        source ${FILE}
    else
       echo "Warning: $var does not appear to be a valid argument. File $FILE does not exist."
    fi
done

source ${MY_DIR}/scripts/common/finished.sh
