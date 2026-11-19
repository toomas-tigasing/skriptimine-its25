#!/bin/bash
#
# apache_paigaldus.sh
# Kontrollib, kas apache2 on paigaldatud.
# Kui ei ole, siis paigaldab. Kui on, siis teatab sellest ja näitab staatust.

# Loeme, mitu korda leitakse "ok installed".
# 2>/dev/null peidab veateate, kui pakett puudub.
APACHE2=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c 'ok installed')

# Kui tulemus on 0, siis teenus ei ole paigaldatud
if [ $APACHE2 -eq 0 ]; then
    # Teavitame ja paigaldame
    echo "Paigaldame apache2"
    apt update
    apt install -y apache2
    echo "Apache on paigaldatud"

# Kui tulemus on 1, siis teenus on juba olemas
elif [ $APACHE2 -eq 1 ]; then
    echo "apache2 on juba paigaldatud"
    # Käivitame teenuse (kui ei tööta) ja näitame staatust
    service apache2 start
    service apache2 status
fi

# skripti lõpp
