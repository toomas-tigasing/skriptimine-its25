#!/bin/bash
#Küpsise tordi arvutamise skript
#
#
read -p "Sisesta kandiku pikkus: " k_pikkus
read -p "Sisesta kandiku laius: " k_laius
echo
read -p "Sisesta küpsise pikkus: " ky_pkkus
read -p "Sisesta küpsise laius: " ky_laius
echo
read -p "Mitu kihti tordil soovid?: " kihtide_arv
echo
read -p "Mitu küpsist on pakis?: " ky_pakid
echo
k_pindala=$(expr $k_laius \* $k_pikkus)
ky_pindala=$(expr $ky_laius \* $ky_pikkus)
ky_arv=$(expr $k_pindala / $ky_pindala)
ky_koguarv=$(expr $ky_arv \* $kihtide_arv)
ky_pakid=$( echo "scale=3; $ky_koguarv / $ky_pakis" | bc -l )
#
#
#
echo "Läheb vaja $ky_pakid küpsiste pakki"
