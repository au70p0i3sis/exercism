#!/usr/bin/env bash
x="$1"
len=${#x}
result=0
for ((i=0;i<len;i++)); do 
	num=${x:i:1}
	p=$((num**len))
	result=$((result+p))
done
if ((result==x)); then 
	echo "true"
else 
	echo "false"
fi
