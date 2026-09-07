#!/bin/bash
#
# reisijate arv
#
read -p "Sisesta reisijate arv: " reisijad
#
# kohtade arv
#
read -p "Sisesta kohtade arv bussis: " kohad
#
# arvututsed
#
bussid=$(($reisijad / $kohad))
ylejaanud=$(($reisijad % $kohad))
#
# kui on olemas ylejaanud, tuleb suurendada busside arv 1 v6rra
if test $ylejaanud -gt 0
then
	bussid=$(($bussid + 1))
fi

echo "Kokku on vaja $bussid taisbussi"

#skripti lõpp
