#!/bin/bash
# Ülesanne 3: Küsib kasutajalt ridade ja tulpade arvu ning väljastab
# kujundi, kus esimene ja viimane rida on täis tärne, aga vahepealsetel
# ridadel on tärn ainult esimeses ja viimases positsioonis, ülejäänud tühikud.

read -p "Sisesta ridade arv: " read_rows
read -p "Sisesta tarnide arv reas: " read_cols

for (( i=1; i<=read_rows; i++ ))
do
    echo -n "$i. "
    if [[ $i -eq 1 || $i -eq $read_rows ]]; then
        # Esimene ja viimane rida - kõik tärnid
        for (( j=1; j<=read_cols; j++ ))
        do
            echo -n "* "
        done
    else
        # Vahepealsed read - tärn, tühikud, tärn
        for (( j=1; j<=read_cols; j++ ))
        do
            if [[ $j -eq 1 || $j -eq $read_cols ]]; then
                echo -n "* "
            else
                echo -n "  "
            fi
        done
    fi
    echo ""
done
