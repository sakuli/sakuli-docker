#!/bin/bash
set -e

main() {
	$STARTUPDIR/sakuli_startup.sh "$@"
}

clone_repository() {
    $STARTUPDIR/clone_git_repo.sh
}

if [ $# -gt 0 ]; then
	# pass all parameters
	main "$@"
else
  if [[ ! -z "$GIT_URL" ]]; then
	    clone_repository
	fi
	# no parameters: Run test project placed in ${SAKULI_EXECUTION_DIR}
  pushd ${SAKULI_EXECUTION_DIR}
	main npm test
	popd
fi
