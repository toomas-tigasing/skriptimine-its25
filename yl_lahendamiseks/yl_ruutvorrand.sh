#!/bin/bash

# Täisarvuline ruutjuure leidmine Newtoni meetodiga (ainult bash-i aritmeetika)
isqrt() {
    local n=$1
    if [ "$n" -eq 0 ]; then
        echo 0
        return
    fi
    local x=$n
    local y=$(( (x + 1) / 2 ))
    while [ "$y" -lt "$x" ]; do
        x=$y
        y=$(( (x + n / x) / 2 ))
    done
    echo "$x"
}

# Ümardab murru numerator/denominator lähima täisarvuni
round_div() {
    local num=$1
    local den=$2
    local sign=1

    if [ "$num" -lt 0 ]; then
        num=$(( -num ))
        sign=$(( -sign ))
    fi
    if [ "$den" -lt 0 ]; then
        den=$(( -den ))
        sign=$(( -sign ))
    fi

    local result=$(( (num + den / 2) / den ))
    echo $(( sign * result ))
}

# Vormindab SCALE-ga (100000) skaleeritud täisarvu kujule "x.xxxxx"
format_scaled() {
    local value=$1
    local sign=""
    if [ "$value" -lt 0 ]; then
        sign="-"
        value=$(( -value ))
    fi
    local int_part=$(( value / 100000 ))
    local frac_part=$(( value % 100000 ))
    printf "%s%d.%05d\n" "$sign" "$int_part" "$frac_part"
}

if [ $# -ne 3 ]; then
    echo "Viga: sisesta täpselt kolm argumenti (A B C)."
    echo "Näide: ./yl_ruutvorrand.sh 1 -3 2"
    exit 1
fi

re='^-?[0-9]+$'
if ! [[ $1 =~ $re ]] || ! [[ $2 =~ $re ]] || ! [[ $3 =~ $re ]]; then
    echo "Viga: A, B ja C peavad olema täisarvud."
    exit 1
fi

A=$1
B=$2
C=$3

if [ "$A" -eq 0 ]; then
    echo "Viga: A ei tohi olla 0."
    exit 1
fi

SCALE=100000

D=$(( B*B - 4*A*C ))

if [ "$D" -gt 0 ]; then
    sqrtD=$(isqrt $(( D * SCALE * SCALE )))

    num1=$(( -B*SCALE + sqrtD ))
    num2=$(( -B*SCALE - sqrtD ))
    den=$(( 2*A ))

    x1_scaled=$(round_div "$num1" "$den")
    x2_scaled=$(round_div "$num2" "$den")

    echo "x1 = $(format_scaled "$x1_scaled")"
    echo "x2 = $(format_scaled "$x2_scaled")"

elif [ "$D" -eq 0 ]; then
    num=$(( -B*SCALE ))
    den=$(( 2*A ))
    x_scaled=$(round_div "$num" "$den")

    echo "x = $(format_scaled "$x_scaled")"

else
    echo "Reaalarvulisi lahendeid ei ole (diskriminant on negatiivne v6i lahendus puudub)."
fi
