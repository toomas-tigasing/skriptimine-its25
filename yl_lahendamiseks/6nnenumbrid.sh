#!/bin/bash

arv=1000

while [ "$arv" -le 9999 ]; do
	temp=$arv

	while [ "$temp" -gt 9 ]; do
	    summa=0
	    while [ "$temp" -gt 0 ]; do
		summa=$((summa + temp % 10))
		temp=$((temp / 10))
	    done
	    temp=$summa
	done

	if [ "$temp" -eq 7 ]; then
	    echo "$arv"
	fi

	arv=$((arv + 1))
done
