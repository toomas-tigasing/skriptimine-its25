#!/bin/bash
#
# php_paigaldus.sh
# Kontrollib, kas php on paigaldatud. Kui ei ole, paigaldab php koos
# apache2 mooduli ja mysql toega. Kui on, teatab sellest ja naitab versiooni.

# Kontrollime root-oigusi (apt vajab neid)
if [ "$(id -u)" -ne 0 ]; then
    echo "Viga: kaivita skript root-oigustega (sudo $0)"
    exit 1
fi

# Loeme, mitu korda leitakse "ok installed"
PHP=$(dpkg-query -W -f='${Status}' php 2>/dev/null | grep -c 'ok installed')

# Kui tulemus on 0, siis php ei ole paigaldatud
if [ "$PHP" -eq 0 ]; then
    echo "Paigaldame php ja vajalikud lisad"
    apt update
    # php               - php ise
    # libapache2-mod-php - tugi apache2 veebiserveri jaoks
    # php-mysql         - mysql tugi (vajalik hiljem andmebaasiga tootamiseks)
    if apt install -y php libapache2-mod-php php-mysql; then
        echo "php on paigaldatud"
        # Taaskaivitame apache2, et php moodul rakenduks
        systemctl restart apache2
    else
        echo "Viga: php paigaldamine ebaonnestus"
        exit 1
    fi

# Kui tulemus on 1, siis php on juba olemas
elif [ "$PHP" -eq 1 ]; then
    echo "php on juba paigaldatud"
    # Kontrollime olemasolu ja naitame versiooni
    which php
    php -v
fi

# skripti lopp
