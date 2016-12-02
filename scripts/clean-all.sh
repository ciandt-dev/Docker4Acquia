#!/usr/bin/env bash

: ' Clean up all Docker dangling image(s) and volume(s)

    '

# bash parameters
set -u  #   nounset  - Attempt to use undefined variable outputs error message, and forces an exit
#set -x  #   xtrace   - Enable print commands and their arguments as they are executed.

# binaries
DOCKER=$(which docker)

# remove dangling images
echo -en "\n\n  Removing Docker dangling images: "
"${DOCKER}" rmi \
            --force \
            $(docker images --filter "dangling=true" --quiet)

# remove dangling volumes
echo -en "\n\n  Removing Docker dangling volumes: "
"${DOCKER}" rmi \
            --force \
            $(docker volume ls --filter "dangling=true" --quiet)
