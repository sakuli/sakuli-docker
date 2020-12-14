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

LINKING_OPTIONS="-s"
if [[ $DEBUG == true ]]; then
    LINKING_OPTIONS="${LINKING_OPTIONS}v"
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
  ln ${LINKING_OPTIONS} ${GLOBAL_NODE_MODULES_PATH} ${SAKULI_EXECUTION_DIR}/${SAKULI_SUITE_NAME}/node_modules
fi
logDebug "Linking global node_modules from ${GLOBAL_NODE_MODULES_PATH} to ${SAKULI_EXECUTION_DIR}."
ln ${LINKING_OPTIONS} ${GLOBAL_NODE_MODULES_PATH} ${SAKULI_EXECUTION_DIR}/node_modules


## Linking _logs folder
if [ -z "$GIT_URL" ]; then
  logDebug "Linking logs and screenshots from ${SAKULI_TEST_SUITE} to ${SAKULI_EXECUTION_DIR}"
  pushd "${SAKULI_EXECUTION_DIR}"
  if isTestSuite "${SAKULI_SUITE_NAME}"; then
    if [[ -d "${SAKULI_TEST_SUITE}/_logs" ]]; then
      ln ${LINKING_OPTIONS} "${SAKULI_TEST_SUITE}/_logs" "./${SAKULI_SUITE_NAME}/_logs"
    fi
  else
    SUITES=$(ls -d */)
    for SUITE in ${SUITES}; do
      if [[ -d "${SAKULI_TEST_SUITE}/${SUITE}/_logs/" ]]; then
        ln ${LINKING_OPTIONS} "${SAKULI_TEST_SUITE}/${SUITE}/_logs" "./${SUITE}/_logs"
      fi
    done
  fi
  popd
fi


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

exit ${SAKULI_RETURN_CODE}
