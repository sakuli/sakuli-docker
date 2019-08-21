#!/bin/bash
set -e

main() {
	# If arg 1 is not npm, execute as it is.
	if [[ $1 =~ npm ]]; then
        $STARTUPDIR/sakuli_startup.sh "$@"
	else
		# execute any other command, init VNC anyway
		$STARTUPDIR/vnc_startup.sh "$@"
	fi
}

if [ $# -gt 0 ]; then
	# pass all parameters
	main "$@"
else
	# no parameters
	# - run the suite defined by $SAKULI_TEST_SUITE, if set
	# or
	# - run the example case (fallback)
	main npm --prefix "${SAKULI_TEST_SUITE:-$HOME/demo_testcase}" test
fi
