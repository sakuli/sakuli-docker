#!/bin/bash
set -e

main() {
	$STARTUPDIR/sakuli_startup.sh "$@"
}

if [ $# -gt 0 ]; then
	# pass all parameters
	main "$@"
else
	# no parameters: Run test project placed in ${EXECUTION_DIR}
  pushd ${EXECUTION_DIR}
	main npm test
	popd
fi
