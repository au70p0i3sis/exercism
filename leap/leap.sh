#!/usr/bin/env bash


is_leap () {
	year="$1"
	if [[ $((year%400)) -eq 0 ]]; then  
		echo "true"
	elif [[ $((year%4)) -eq 0 && $((year%100)) -ne 0 ]]; then
		echo "true"
	else 
		echo "false"
	fi
}

main () {
	if [[ $# -eq 1 && -z "${1//[0-9]/}" ]]; then 
		is_leap "$1"
	else
		echo "Usage: leap.sh <year>"
		exit 1
	fi
}

main "$@"
