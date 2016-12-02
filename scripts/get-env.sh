#!/usr/bin/env bash

: ' Exports all environment variables from defined .env file and executes next
    command in line

    '

# bash parameters
set -e  #   errexit  - Abort script at first error, when a command exits with non-zero status (except in until or while loops, if-tests, list constructs)
set -u  #   nounset  - Attempt to use undefined variable outputs error message, and forces an exit
#set -x  #   xtrace   - Enable print commands and their arguments as they are executed.

# variables
ENV_FILE=".env"

# get variables from ENV_FILE and export them
if [ -f "${ENV_FILE}" ]; then

  export $(cat "${ENV_FILE}" | grep -v ^# | xargs)

else

  echo ""${ENV_FILE}" file not found"

fi

# run the next command
exec "$@"
