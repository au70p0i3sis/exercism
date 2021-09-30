#!/usr/bin/env bash 

function encode () {
	string="$1"
	len=${#string}
	i=0
	result=""
	while [[ $i -lt "$len" ]]; do 
		char="${string:i:1}"
		char_count=1
		next_idx=$((i+1))
		while [[ "$char" == "${string:next_idx:1}" ]]; do 
			char_count=$((char_count+1))	
			next_idx=$((next_idx+1))
		done
		if [[ $char_count -eq 1 ]]; then
			result+=$(printf "%s" "$char")
		else
			result+=$(printf "%i%s" "$char_count" "$char")
		fi 
		i=$((i+char_count))
	done
	echo "$result"
}

function decode () {
	string="$1"
	len=${#string}
	i=0
	result=""
	while [[ $i -lt "$len" ]]; do 
		dec=1
		if is_num "${string:i:1}"; then
			# how many digits long is the num?
			while is_num "${string:i:dec}"; do 
				dec=$((dec+1))
			done
			# now use the digit length to extract the multiplier from the string
			dig_len=$((dec-1)) #loop bursts one over
			mult="${string:i:dig_len}"
			mult=$((mult-1))
			i=$((i+dig_len)) # get next letter
			letter="${string:i:1}"
			result+=$(printf "$letter%.0s" $(seq 1 $mult))
		else # is a single letter
			result+=$(printf "%s" "${string:i:1}")
			i=$((i+dec))
		fi
	done
	echo "$result"
}

function is_num () {
	[[ -z "${1//[0-9]/}" ]] && return 0 || return 1
}

case "$1" in 
	-e|encode|--encode) encode "$2" ;;
	-d|decode|--decode) decode "$2" ;;
	*)  echo "usage:"
		echo "solution.sh [encode|decode] STRING"
		echo ;;
esac
