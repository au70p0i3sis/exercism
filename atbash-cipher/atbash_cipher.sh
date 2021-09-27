#!/usr/bin/env bash

set -euo pipefail

alpha="abcdefghijklmnopqrstuvwxyz"
alpha_rev="zyxwvutsrqponmlkjihgfedcba"

encode () {
	string="$*"
	str_len="${#string}"
	result_string=""
	for ((i=0;i<str_len;i++)); do 
		test_char="${string:i:1}"
		result_char=""
		if [[ "$test_char" =~ [[:alpha:]] ]]; then #check if num or alpha
			x=0
			while [[ -z "$result_char" ]]; do 
				if [[ ${alpha:x:1} == "$test_char" ]]; then 
					opp=$((25-x))
					result_char="${alpha:opp:1}"
				fi
				((++x))
			done
		elif [[ "$test_char" =~ [0-9] ]]; then #is num
			result_char=$test_char
		else
			echo "alphanumeric only!" && exit 1
		fi
		[[ "$((i%5))" -eq 0 && $i -gt 2 ]] && result_string+=" " # add space after every 5 chars
		result_string+=$result_char
	done
	echo "$result_string"
}

decode () {
	string="$*"
	str_len="${#string}"
	result_string=""
	for ((i=0;i<str_len;i++)); do 
		test_char="${string:i:1}"
		result_char=""
		if [[ "$test_char" =~ [[:alpha:]] ]]; then #check if num or alpha
			x=0
			while [[ -z "$result_char" ]]; do 
				if [[ ${alpha_rev:x:1} == "$test_char" ]]; then 
					opp=$((25-x))
					result_char="${alpha_rev:opp:1}"
				fi
				((++x))
			done
		elif [[ "$test_char" =~ [0-9] ]]; then #is num
			result_char=$test_char
		else
			echo "alphanumeric only!" && exit 1
		fi
		result_string+=$result_char
	done
	echo "$result_string"
}

main () {
	string="${2// /}"
	string="${string,,}"
	string="${string//[^a-z|0-9]/}"
	if [[ "$1" == "encode" ]]; then 
		encode "$string"
	elif [[ "$1" == "decode" ]]; then 
		decode "$string"
	else
		echo 'Usage atbash_cipher.sh [encode|decode] "<string>"'
	fi
}
main "$@"
