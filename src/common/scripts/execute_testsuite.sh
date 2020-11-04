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

logDebug(){
  [[ $DEBUG == true ]] && echo "${@}"
  return 0
}

SAKULI_SUITE_NAME=""
getTestSuiteName(){
  echo $1 | rev | cut -d "/" -f 1 | rev
}

syncToExecutionDir(){
  SAKULI_SUITE_NAME=$(getTestSuiteName ${1})
  if [[ -f ${1}/testsuite.properties && -f ${1}/testsuite.suite ]]; then
    logDebug "Syncing test suite"
    rsync ${RSYNC_OPTIONS} ${1}/../* ${SAKULI_EXECUTION_DIR} --exclude='*/'
    rsync ${RSYNC_OPTIONS} ${1}/ ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME} --exclude=node_modules --exclude=_logs/_screenshots
  else
    logDebug "Syncing project"
    rsync ${RSYNC_OPTIONS} ${1}/* ${SAKULI_EXECUTION_DIR} --exclude=node_modules --exclude=_logs/_screenshots
  fi
}

logDebug "Syncing test suite to execution environment"
if [ "${SAKULI_TEST_SUITE}" ]; then
  syncToExecutionDir ${SAKULI_TEST_SUITE}
elif [ "${GIT_URL}" ]; then
  echo "------------------ Cloning git repository ------------------"
  GIT_REPOSITORY_DIR=/headless/git-repository
  git clone $GIT_URL $GIT_REPOSITORY_DIR
  syncToExecutionDir ${GIT_REPOSITORY_DIR}/${GIT_CONTEXT_DIR}
fi

# Link global node_modules into ${SAKULI_EXECUTION_DIR}
GLOBAL_NODE_MODULES_PATH=$(npm root -g | head -n 1)
logDebug "Linking global node_modules from ${GLOBAL_NODE_MODULES_PATH} to ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}."
if [[ -f $${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}/testsuite.properties && -f ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}/testsuite.suite ]]; then
  ln -s ${GLOBAL_NODE_MODULES_PATH} ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}/node_modules
fi
logDebug "Linking global node_modules from ${GLOBAL_NODE_MODULES_PATH} to ${SAKULI_EXECUTION_DIR}."
ln -s ${GLOBAL_NODE_MODULES_PATH} ${SAKULI_EXECUTION_DIR}/node_modules

# exit != 0 does not abort script execution anymore
set +e

SAKULI_RETURN_CODE=1
if [ -f "${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}/package.json" ]; then
  pushd ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}
else
  pushd ${SAKULI_EXECUTION_DIR}
fi
# unknown option ==> call command
echo -e "\n\n------------------ EXECUTE SAKULI ------------------"
echo "Executing command: '$@'"
$@
SAKULI_RETURN_CODE=$?
popd

# unlink global node_modules in ${SAKULI_EXECUTION_DIR}
logDebug "remove global node_modules link from ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}"
[ -L "${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}/node_modules" ] && rm ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}/node_modules
logDebug "remove global node_modules link from ${SAKULI_EXECUTION_DIR}"
[ -L "${SAKULI_EXECUTION_DIR}/node_modules" ] && rm ${SAKULI_EXECUTION_DIR}/node_modules

## Restore logs and screenshots into the actual mounted volume, if possible
if [ -z "$GIT_URL" ]; then
  logDebug "Restoring logs and screenshots to ${SAKULI_TEST_SUITE}"
  if [[ -f $${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}/testsuite.properties && -f ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}/testsuite.suite ]]; then
     RESTORE_COMMAND="rsync ${RSYNC_OPTIONS} ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}/_logs ${SAKULI_TEST_SUITE}"
  else
     RESTORE_COMMAND="rsync ${RSYNC_OPTIONS} ${SAKULI_EXECUTION_DIR}/**/_logs ${SAKULI_TEST_SUITE}"
  fi

  logDebug "${RESTORE_COMMAND}"
  if [[ $DEBUG == true ]]; then
      ${RESTORE_COMMAND}
  else
      ${RESTORE_COMMAND} 2>/dev/null
  fi
  [ $? -ne 0 ] && echo -e "ERROR: Could not restore logs and screenshots due to insufficient permissions."
fi

exit ${SAKULI_RETURN_CODE}
