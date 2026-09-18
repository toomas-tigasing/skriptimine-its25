#!/bin/bash

read -p "Sisesta ridade arv: " read_rows
read -p "Sisesta tarnide arv reas: " read_cols

for (( i=1; i<=read_rows; i++ ))
do
	echo -n "$i.  "
	for (( j=1; j<=read_cols; j++ ))
	do
	   echo -n "* "
	done
	echo ""
done
