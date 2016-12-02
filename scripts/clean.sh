#!/usr/bin/env bash

: ' Stops running Docker container(s), delete it and remove its Docker image

    '

# bash parameters
set -u  #   nounset  - Attempt to use undefined variable outputs error message, and forces an exit
#set -x  #   xtrace   - Enable print commands and their arguments as they are executed.

# binaries
DOCKER_COMPOSE=$(which docker-compose)

# clean message
echo -e "\n  _______________________________________________________________________________\n"
echo -e "\n  -- Docker Clean\n\n  Cleaning up\n  Please wait..."

# stop and remove containers, networks, images, and volumes
echo -en "\n  Stopping and removing containers, networks, images, and volumes: \n\n"
"${DOCKER_COMPOSE}" \
    --file infrastructure/docker-compose.yaml \
    --project-name "${ACQUIA_SUBSCRIPTION}" \
    down

echo -e "  _______________________________________________________________________________\n"
