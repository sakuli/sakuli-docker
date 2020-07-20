#!/bin/bash
set -e

main() {
	$STARTUPDIR/sakuli_startup.sh "$@"
}

if [ $# -gt 0 ]; then
	# pass all parameters
	main "$@"
else
	# no parameters
	# - run the suite defined by $SAKULI_TEST_SUITE, if set
	# or
	# - run the example case (fallback)
	pushd ${SAKULI_TEST_SUITE:-$HOME/demo_testcase}
	main npm test
	popd
fi
