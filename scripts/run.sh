#!/usr/bin/env bash

: ' Spin-up Docker4Acquia containers

    '

## bash parameters
set -u  #   nounset  - Attempt to use undefined variable outputs error message, and forces an exit
#set -x  #   xtrace   - Enable print commands and their arguments as they are executed.

## binaries
CAT=$(which cat)
DOCKER_COMPOSE=$(which docker-compose)
TR=$(which tr)

## variables
# transform subscription to lower case
export ACQUIA_SUBSCRIPTION=$("${TR}" '[:upper:]' '[:lower:]' <<< "${ACQUIA_SUBSCRIPTION}")

## functions
# get Docker container IP
function get_docker_container_ip()
{

  # local function variables
  local _PROJECT_NAME="${1:-}"
  local _CONTAINER_NAME="${2:-}"

  # inspect the container and get the IP address
  local _CONTAINER_IP=$(\
          docker inspect \
            --type \
              container \
            --format \
              "{{ .NetworkSettings.Networks."${_PROJECT_NAME}"_default.IPAddress }}" \
            "${_CONTAINER_NAME}" \
          )

  # return the IP address
  echo "${_CONTAINER_IP}"

} # end of get_docker_container_ss

## flow
# start message
echo "  _______________________________________________________________________________"
echo -en "\n  -- Docker run\n\n  Spinning-up Docker containers\n\n"

# spin-up containers
"${DOCKER_COMPOSE}" \
    --file infrastructure/docker-compose.yaml \
    --project-name "${ACQUIA_SUBSCRIPTION}" \
    up -d

# print messages if docker run was successful or not
if [ $? -eq 0 ]; then

  # change bash parameter
  set -e  #   errexit  - Abort script at first error, when a command exits with non-zero status (except in until or while loops, if-tests, list constructs)

  # collect IPs
  SOLR_IP=$(get_docker_container_ip "${ACQUIA_SUBSCRIPTION//[-]/}" ""${ACQUIA_SUBSCRIPTION}"-solr")
  MEMCACHED_IP=$(get_docker_container_ip "${ACQUIA_SUBSCRIPTION//[-]/}" ""${ACQUIA_SUBSCRIPTION}"-memcached")
  PERCONA_IP=$(get_docker_container_ip "${ACQUIA_SUBSCRIPTION//[-]/}" ""${ACQUIA_SUBSCRIPTION}"-percona")
  PHP_IP=$(get_docker_container_ip "${ACQUIA_SUBSCRIPTION//[-]/}" ""${ACQUIA_SUBSCRIPTION}"-php")

"${CAT}" << EOM
  _______________________________________________________________________________

  Your Docker containers are UP and RUNNING

  Solr is avaiable at:
  ${SOLR_IP}:8983

  Memcached is avaiable at:
  ${MEMCACHED_IP}:11211

  Percona (MySQL) is avaiable at:
  ${PERCONA_IP}:3306

  PHP/Apache is avaiable at:
  ${PHP_IP}:80
  ${PHP_IP}:443

  If you prefer to use hostname instead, please add it to your hosts file
  Just copy and paste the commands below in your terminal or add it manually later

  sudo bash -c 'echo "${SOLR_IP} ${ACQUIA_SUBSCRIPTION}-solr.local" >> /etc/hosts'
  sudo bash -c 'echo "${MEMCACHED_IP} ${ACQUIA_SUBSCRIPTION}-memcached.local" >> /etc/hosts'
  sudo bash -c 'echo "${PERCONA_IP} ${ACQUIA_SUBSCRIPTION}-percona.local" >> /etc/hosts'
  sudo bash -c 'echo "${PHP_IP} ${ACQUIA_SUBSCRIPTION}-php.local" >> /etc/hosts'

  THEN, will be able to access at:

  ${ACQUIA_SUBSCRIPTION}-solr.local:9398
  ${ACQUIA_SUBSCRIPTION}-memcached.local:11211
  ${ACQUIA_SUBSCRIPTION}-percona.local:3306
  ${ACQUIA_SUBSCRIPTION}-php.local:80
  ${ACQUIA_SUBSCRIPTION}-php.local:443

  _______________________________________________________________________________

EOM

else

"${CAT}" << EOM

  There are already Docker containers running!!!
  Please stop and delete it before running this commmand again

  _______________________________________________________________________________

EOM

  exit 1

fi
