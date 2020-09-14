#!/bin/bash
# every exit != 0 aborts the script
set -e

## Preparing execution environment
RSYNC_OPTIONS="-aO"
if [[ $DEBUG == true ]]; then
    RSYNC_OPTIONS="${RSYNC_OPTIONS}v"
else
    RSYNC_OPTIONS="${RSYNC_OPTIONS}q"
fi


SAKULI_SUITE_NAME=""
getTestSuiteName(){
  echo $1 | rev | cut -d "/" -f 1 | rev
}
[[ $DEBUG == true ]] && echo "Syncing test suite to execution environment."
if [ "${SAKULI_TEST_SUITE}" ]; then
  rsync ${RSYNC_OPTIONS} ${SAKULI_TEST_SUITE}/../* ${SAKULI_EXECUTION_DIR} --exclude node_modules
  SAKULI_SUITE_NAME=$(getTestSuiteName ${SAKULI_TEST_SUITE})
elif [ "${GIT_URL}" ]; then
  echo "------------------ Cloning git repository ------------------"
  GIT_REPOSITORY_DIR=/headless/git-repository
  git clone $GIT_URL $GIT_REPOSITORY_DIR
  rsync ${RSYNC_OPTIONS} ${GIT_REPOSITORY_DIR}/${GIT_CONTEXT_DIR}/../* ${SAKULI_EXECUTION_DIR} --exclude node_modules
  SAKULI_SUITE_NAME=$(getTestSuiteName ${GIT_CONTEXT_DIR})
else
  echo "ERROR: SAKULI_TEST_SUITE not set."
  exit 1
fi

# Link global node_modules into ${SAKULI_EXECUTION_DIR}
GLOBAL_NODE_MODULES_PATH=$(npm root -g | head -n 1)
[[ $DEBUG == true ]] && echo "Linking global node_modules from ${GLOBAL_NODE_MODULES_PATH} to ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}."
ln -s ${GLOBAL_NODE_MODULES_PATH} ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}/node_modules
[[ $DEBUG == true ]] && echo "Linking global node_modules from ${GLOBAL_NODE_MODULES_PATH} to ${SAKULI_EXECUTION_DIR}."
ln -s ${GLOBAL_NODE_MODULES_PATH} ${SAKULI_EXECUTION_DIR}/node_modules

# exit != 0 does not abort script execution anymore
set +e

SAKULI_RETURN_CODE=1
if [ -z "$1" ] || [[ $1 =~ -w|--wait ]]; then
    wait $PID_SUB
else
    # unknown option ==> call command
    echo -e "\n\n------------------ EXECUTE COMMAND ------------------"
    echo "Executing command: '$@'"
    $@
    SAKULI_RETURN_CODE=$?
fi

## Restore logs and screenshots into the actual mounted volume, if possible
if [ -z "$GIT_URL" ]; then
  [[ $DEBUG == true ]] && echo "Restoring testsuite to ${SAKULI_TEST_SUITE}."
  RESTORE_COMMAND="rsync ${RSYNC_OPTIONS} ${SAKULI_EXECUTION_DIR}/* ${SAKULI_TEST_SUITE}/.. --exclude node_modules"
  if [[ $DEBUG == true ]]; then
      echo "${RESTORE_COMMAND}"
      ${RESTORE_COMMAND}
  else
      ${RESTORE_COMMAND} 2>/dev/null
  fi
  [ $? -ne 0 ] && echo -e "ERROR: Could not restore logs and screenshots due to insufficient permissions."
fi

exit ${SAKULI_RETURN_CODE}