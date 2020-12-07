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
    logDebug "Syncing test suite to execution environment"
    rsync ${RSYNC_OPTIONS} ${SOURCE_DIR}/../* ${SAKULI_EXECUTION_DIR} --exclude='*/'
    rsync ${RSYNC_OPTIONS} ${SOURCE_DIR}/ ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME} --exclude=node_modules --exclude=_logs
  else
    logDebug "Syncing project to execution environment"
    rsync ${RSYNC_OPTIONS} ${SOURCE_DIR}/* ${SAKULI_EXECUTION_DIR} --exclude=node_modules --exclude=_logs
  fi
}

restoreLogs(){
  SOURCE=${1}
  DESTINATION=${2}
  LOG_FOLDER="_logs"
  LOG_LOCATION="${LOG_FOLDER}/sakuli.log"
  SCREENSHOT_LOCATION="${LOG_FOLDER}/_screenshots"

  SAKULI_LOG_SOURCE="${SOURCE}/${LOG_LOCATION}"
  SCREENSHOT_SOURCE="${SOURCE}/${SCREENSHOT_LOCATION}"
  SAKULI_LOG_DESTINATION_FOLDER="${DESTINATION}/${LOG_FOLDER}"
  SAKULI_LOG_DESTINATION="${DESTINATION}/${LOG_LOCATION}"
  SCREENSHOT_DESTINATION="${DESTINATION}/${SCREENSHOT_LOCATION}"

  if ! [ -d  "${SAKULI_LOG_DESTINATION_FOLDER}" ]; then
    mkdir "${SAKULI_LOG_DESTINATION_FOLDER}"
  fi
  cat ${SAKULI_LOG_SOURCE} >> ${SAKULI_LOG_DESTINATION}
  [ $? -ne 0 ] && echo -e "ERROR: Could not restore sakuli.log to ${SAKULI_LOG_DESTINATION}"

  if [ -d "${SCREENSHOT_SOURCE}" ]; then
    rsync ${RSYNC_OPTIONS} ${SCREENSHOT_SOURCE}/* ${SCREENSHOT_DESTINATION}
    [ $? -ne 0 ] && echo -e "ERROR: Could not restore screenshots to ${SCREENSHOT_DESTINATION}"
  fi
}

### Main
SAKULI_SUITE_NAME=""

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
if isTestSuite ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}; then
  logDebug "Linking global node_modules from ${GLOBAL_NODE_MODULES_PATH} to ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}."
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

if [[ $INSTALL_PACKAGES == true ]]; then
  echo -e "\n\n------------------ INSTALLING PACKAGES ------------------"
  npm i --no-package-lock
fi

# unknown option ==> call command
echo -e "\n\n------------------ EXECUTE SAKULI ------------------"
echo "Executing command: '$@'"
$@
SAKULI_RETURN_CODE=$?
popd

## Restore logs and screenshots into the actual mounted volume, if possible
if [ -z "$GIT_URL" ]; then
  logDebug "Restoring logs and screenshots to ${SAKULI_TEST_SUITE}"
  pushd "${SAKULI_EXECUTION_DIR}"
  if isTestSuite "${SAKULI_SUITE_NAME}"; then
    restoreLogs "${SAKULI_SUITE_NAME}" "${SAKULI_TEST_SUITE}"
  else
    SUITES=$(ls -d */)
    for SUITE in ${SUITES}; do
      if [[ -d "${SUITE}/_logs/" ]]; then
        restoreLogs "${SUITE}" "${SAKULI_TEST_SUITE}/${SUITE}"
      fi
    done
  fi
  popd
fi

exit ${SAKULI_RETURN_CODE}
