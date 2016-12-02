#!/usr/bin/env bash

: ' Builds Docker image(s) using variables from .env file and also provides a
    detailed status output message

    TODO : Improve how to retrieve information from Docker inspect in Maintainers list

    '

# bash parameters
set -u  #   nounset  - Attempt to use undefined variable outputs error message, and forces an exit
#set -x  #   xtrace   - Enable print commands and their arguments as they are executed.

# binaries
CAT=$(which cat)
DOCKER_COMPOSE=$(which docker-compose)
TR=$(which tr)

## variables
# transform subscription to lower case
export ACQUIA_SUBSCRIPTION=$("${TR}" '[:upper:]' '[:lower:]' <<< "${ACQUIA_SUBSCRIPTION}")

"${CAT}" << EOM
  _______________________________________________________________________________

                            Docker4Acquia project

  -- Docker Pull

  Pulling Docker image(s)

EOM

# pull images first, check for updated versions
"${DOCKER_COMPOSE}" \
    --file infrastructure/docker-compose.yaml \
    --project-name "${ACQUIA_SUBSCRIPTION}" \
    pull

# print messages if docker run was successful or not
if [ $? -eq 0 ]; then

  # build
  "${DOCKER_COMPOSE}" \
      --file infrastructure/docker-compose.yaml \
      --project-name "${ACQUIA_SUBSCRIPTION}" \
      build

  # print messages if docker run was successful or not
  if [ $? -eq 0 ]; then

    "${CAT}" << EOM
  _______________________________________________________________________________

  -- Docker Build

  Your Docker image(s) are built

EOM

  else

    "${CAT}" << EOM
  _______________________________________________________________________________

  -- Docker Build

  ERROR!!
  Something happened, your Docker image(s) were not built
  _______________________________________________________________________________

EOM

    exit 1

  fi

else

  "${CAT}" << EOM
  _______________________________________________________________________________

  -- Docker Pull

  ERROR!!
  Something happened, could not pull images
  _______________________________________________________________________________

EOM

  exit 1

fi
