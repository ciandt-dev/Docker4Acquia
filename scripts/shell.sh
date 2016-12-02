#!/usr/bin/env bash

: ' Runs Docker container(s) and connects to Apache/PHP shell (BASH)

    '

# bash parameters
set -u  #   nounset  - Attempt to use undefined variable outputs error message, and forces an exit
#set -x  #   xtrace   - Enable print commands and their arguments as they are executed.

# binaries
DOCKER=$(which docker)
TR=$(which tr)

# variables
export ACQUIA_SUBSCRIPTION=$("${TR}" '[:upper:]' '[:lower:]' <<< "${ACQUIA_SUBSCRIPTION}")
SHELL_TYPE="bash"

# shell message
echo -e "\n  Connecting to Apache/PHP Docker container shell...\n"

# get docker container shell
"${DOCKER}" exec \
            --interactive \
            --tty \
            ""${ACQUIA_SUBSCRIPTION}"-php" \
            "${SHELL_TYPE}"
