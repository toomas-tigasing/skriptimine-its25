#!/bin/bash

# Paaris- ja Paarituarvud
read -p "Sisesta suvaline täisarv: " arv

# ARVUTAMINE AWDJIAWDOUAWDji
jaak=$(( arv % 2 ))

# kontrallimine
if [ $jaak -eq 0 ]; then
	echo "Antud arv on paaris"
else
	echo "Antud arv on paaritu"
fi
