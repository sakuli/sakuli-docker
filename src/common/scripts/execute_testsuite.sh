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

### Function declaration
logDebug(){
  [[ $DEBUG == true ]] && echo "${@}"
  return 0
}

getTestSuiteName(){
  echo $1 | rev | cut -d "/" -f 1 | rev
}

isTestSuite(){
  test -f ${1}/testsuite.properties && test -f ${1}/testsuite.suite
  return $?
}

syncToExecutionDir(){
  SOURCE_DIR=${1}
  SAKULI_SUITE_NAME=${2}
  if isTestSuite ${SOURCE_DIR}; then
    logDebug "Syncing test suite"
    rsync ${RSYNC_OPTIONS} ${SOURCE_DIR}/../* ${SAKULI_EXECUTION_DIR} --exclude='*/'
    rsync ${RSYNC_OPTIONS} ${SOURCE_DIR}/ ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME} --exclude=node_modules --exclude=_logs/_screenshots
  else
    logDebug "Syncing project"
    rsync ${RSYNC_OPTIONS} ${SOURCE_DIR}/* ${SAKULI_EXECUTION_DIR} --exclude=node_modules --exclude=_logs/_screenshots
  fi
}

executeRestoreCommand(){
  RESTORE_COMMAND="${1}"
  RESTORE_DESTINATION="${2}"
  logDebug "${RESTORE_COMMAND}"
  if [[ $DEBUG == true ]]; then
     ${RESTORE_COMMAND}
  else
     ${RESTORE_COMMAND} 2>/dev/null
  fi
  [ $? -ne 0 ] && echo -e "ERROR: Could not restore logs and screenshots to ${RESTORE_DESTINATION}"
}

### Main
SAKULI_SUITE_NAME=""

logDebug "Syncing test suite to execution environment"
if [ "${SAKULI_TEST_SUITE}" ]; then
  SAKULI_SUITE_NAME=$(getTestSuiteName ${SAKULI_TEST_SUITE})
  syncToExecutionDir "${SAKULI_TEST_SUITE}" "${SAKULI_SUITE_NAME}"
elif [ "${GIT_URL}" ]; then
  echo "------------------ Cloning git repository ------------------"
  GIT_REPOSITORY_DIR=/headless/git-repository
  git clone $GIT_URL $GIT_REPOSITORY_DIR
  SAKULI_SUITE_NAME=$(getTestSuiteName ${GIT_REPOSITORY_DIR}/${GIT_CONTEXT_DIR})
  syncToExecutionDir "${GIT_REPOSITORY_DIR}/${GIT_CONTEXT_DIR}" "${SAKULI_SUITE_NAME}"
fi

# Link global node_modules into ${SAKULI_EXECUTION_DIR}
GLOBAL_NODE_MODULES_PATH=$(npm root -g | head -n 1)
logDebug "Linking global node_modules from ${GLOBAL_NODE_MODULES_PATH} to ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}."
if isTestSuite ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}; then
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
  if isTestSuite ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}; then
     RESTORE_COMMAND="rsync ${RSYNC_OPTIONS} ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}/_logs ${SAKULI_TEST_SUITE}"
     executeRestoreCommand "${RESTORE_COMMAND}" "${SAKULI_SUITE_NAME}/_logs"
  else
    pushd ${SAKULI_EXECUTION_DIR}
    SUITES=$(ls -d */)
    for SUITE in ${SUITES}; do
      if [[ -d ${SUITE}/_logs ]]; then
       RESTORE_COMMAND="rsync ${RSYNC_OPTIONS} ${SUITE}/_logs ${SAKULI_TEST_SUITE}/${SUITE}/"
       executeRestoreCommand "${RESTORE_COMMAND}" "${SUITE}/_logs"
      fi
    done
    popd
  fi
fi

exit ${SAKULI_RETURN_CODE}
