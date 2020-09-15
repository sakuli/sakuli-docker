#!/bin/bash
set -e

main() {
	$STARTUPDIR/sakuli_startup.sh "$@"
}

if [ $# -gt 0 ]; then
	# pass all parameters
	main "$@"
else
	main npm test
fi
