#!/bin/bash

ajutine_fail=$(mktemp)
> "$ajutine_fail"

arv_loendus=0

while [ "$arv_loendus" -lt 5 ]; do
    number=$((RANDOM % 50 + 1))

    if ! grep -qx "$number" "$ajutine_fail"; then
        echo "$number" >> "$ajutine_fail"
        arv_loendus=$((arv_loendus + 1))
    fi
done

echo "Genereeritud numbrid:"
cat "$ajutine_fail"
echo ""

echo "Kas soovid tulemuse (k) kuvada terminalis või (s) salvestada faili?"
read -p "Valik (k/s): " valik

if [ "$valik" = "k" ]; then
    echo "Loosinumbrid:"
    cat "$ajutine_fail"

elif [ "$valik" = "s" ]; then
    tulemuse_fail="lotonumbrid.txt"
    praegune_aeg=$(date "+%Y-%m-%d %H:%M:%S")

    echo "$praegune_aeg" >> "$tulemuse_fail"
    cat "$ajutine_fail" >> "$tulemuse_fail"
    echo "" >> "$tulemuse_fail"

    echo "Tulemus salvestatud faili: $tulemuse_fail"

else
    echo "Vigane valik. Skript lõpetab tegevuse."
fi

rm "$ajutine_fail"
