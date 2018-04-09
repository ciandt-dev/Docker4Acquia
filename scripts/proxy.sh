#!/usr/bin/env bash

: ' Spin-up Nginx proxy container

    '

# bash parameters
set -u  #   nounset  - Attempt to use undefined variable outputs error message, and forces an exit
#set -x  #   xtrace   - Enable print commands and their arguments as they are executed.

# binaries
CAT=$(which cat)
DOCKER=$(which docker)
DOCKER_COMPOSE=$(which docker-compose)
DOCKER_MACHINE=$(which docker-machine)
TR=$(which tr)

## variables
# transform subscription to lower case
export ACQUIA_SUBSCRIPTION=$("${TR}" '[:upper:]' '[:lower:]' <<< "${ACQUIA_SUBSCRIPTION}")
export PROJECT_NAME="${ACQUIA_SUBSCRIPTION//[-]/}"

"${CAT}" << EOM
  _______________________________________________________________________________

                  Docker4Acquia project - Mac/Win support

  -- Docker Pull

  Pulling Docker image(s)

EOM

# pull images first, check for updated versions
"${DOCKER_COMPOSE}" \
    --file infrastructure/proxy/docker-compose.yaml \
    --project-name "proxy" \
    pull

# print messages if docker pull was successful or not
if [ $? -eq 0 ]; then

    "${CAT}" << EOM
  _______________________________________________________________________________

  -- Docker Build

  Your Docker image(s) are built

EOM

  # build
  "${DOCKER_COMPOSE}" \
      --file infrastructure/proxy/docker-compose.yaml \
      --project-name "proxy" \
      build

  # print messages if docker build was successful or not
  if [ $? -eq 0 ]; then

    "${CAT}" << EOM
  _______________________________________________________________________________

  -- Docker Run

  Spinning-up Docker containers

EOM

    # spin-up container
    "${DOCKER_COMPOSE}" \
        --file infrastructure/proxy/docker-compose.yaml \
        --project-name "proxy" \
        up -d

    # print usage message
    "${CAT}" << EOM
  _______________________________________________________________________________

    Your Docker Nginx proxy container is UP and RUNNING

    - For Mac/Windows environments only!

    Please, add these entries in your hosts file

    127.0.0.1 ${ACQUIA_SUBSCRIPTION}-solr.${ENVIRONMENT}
    127.0.0.1 ${ACQUIA_SUBSCRIPTION}-php.${ENVIRONMENT}

    It can be done manually or if you prefer, just copy and paste the commands below:

    -- Mac
    sudo bash -c 'echo "# Docker4Acquia project - ${ACQUIA_SUBSCRIPTION}" >> /etc/hosts'
    sudo bash -c 'echo "127.0.0.1 ${ACQUIA_SUBSCRIPTION}-solr.${ENVIRONMENT}" >> /etc/hosts'
    sudo bash -c 'echo "127.0.0.1 ${ACQUIA_SUBSCRIPTION}-php.${ENVIRONMENT}" >> /etc/hosts'

    -- Windows (prompt with administrator privileges)
    echo # Docker4Acquia project - ${ACQUIA_SUBSCRIPTION} >> %WINDIR%\system32\drivers\etc\hosts
    echo 127.0.0.1 ${ACQUIA_SUBSCRIPTION}-solr.${ENVIRONMENT} >> %WINDIR%\system32\drivers\etc\hosts
    echo 127.0.0.1 ${ACQUIA_SUBSCRIPTION}-php.${ENVIRONMENT} >> %WINDIR%\system32\drivers\etc\hosts

EOM

    # print messages if docker run was successful or not
    if [ $? -ne 0 ]; then

      "${CAT}" << EOM
    _______________________________________________________________________________

    -- Docker Run

    ERROR!!
    Something happened, your Docker image(s) were not built
    _______________________________________________________________________________

EOM

      exit 1

    fi

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

# connect nginx proxy to the project network
"${DOCKER}" network connect ""${PROJECT_NAME}"_default" nginx >/dev/null 2>&1 || true # hence the command still not support -f (force), ignoring the output
