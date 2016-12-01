#!/usr/bin/env bash

: ' Tests running Docker containers

    TODO: Improve tests, maybe try to use Behat as testing tool
    '

# bash parameters
set -u  #   nounset  - Attempt to use undefined variable outputs error message, and forces an exit
set -e  #   errexit  - Abort script at first error, when a command exits with non-zero status (except in until or while loops, if-tests, list constructs)
#set -x  #   xtrace   - Enable print commands and their arguments as they are executed.

# binaries
DOCKER=$(which docker)
NC=$(which nc)

# simple tests start
echo "  _______________________________________________________________________________"
echo -e "\n  -- Docker Test \n\n  Please wait..."

## Memcached
# get container ip address
readonly DOCKER_MEMCACHED_CONTAINER_IP=$(\
  "${DOCKER}" inspect \
              --format \
                "{{ .NetworkSettings.Networks.bridge.IPAddress }}" \
              --type \
                container \
              ""${ACQUIA_SUBSCRIPTION}-memcached"" \
              )

# disable bash errexit
set +e

# connect to container and gather information
echo "version" | "${NC}" "${DOCKER_MEMCACHED_CONTAINER_IP}" "11211" > /dev/null

# check if was OK
if [ $? -eq 0 ]; then

  echo -e "\n  Docker container "${ACQUIA_SUBSCRIPTION}-memcached" service port 11211: OK!"
  echo -e "\n  _______________________________________________________________________________\n"

else

  echo -e "\n  ERROR! Docker container "${ACQUIA_SUBSCRIPTION}-memcached" service port 11211: NOK!"
  echo -e "\n  _______________________________________________________________________________\n"
  exit 1

fi
