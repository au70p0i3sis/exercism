#!/usr/bin/env bash

set -euo pipefail

declare -a arr=("$@")
search_key="${arr[0]}"
arr_len="${#arr[@]}"

if [[ "$arr_len" -lt 1 || ${arr[0]} -eq 0 ]]; then echo "-1" && exit 0; fi

center_idx=$((arr_len/2))
loop_count=0
test_key=""
while [[ "$test_key" -ne "$search_key" ]]; do 
	test_key="${arr[center_idx]:=-1}"
	split_idx=$((center_idx/2))
	if [[ "$search_key" -ne "$test_key" ]]; then
		if [[ "$search_key" -gt "$center_idx" ]] ; then 
			center_idx=$((center_idx+split_idx))	
		else
			center_idx=$((center_idx-split_idx))
		fi
	else 
		echo "$((center_idx-1))"
	fi
	((++loop_count))
	if [[ "$loop_count" -gt "$arr_len" ]]; then echo "-1" && exit 0; fi
done

