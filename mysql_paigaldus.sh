#!/bin/bash
#
# mysql_paigaldus.sh
# Kontrollib, kas MySQL server on paigaldatud. Kui ei ole, paigaldab Oracle
# MySQL 8.0 ametlikust repositooriumist täielikult automaatselt.
# Kui on, teatab sellest ja näitab teenuse staatust.

# Skript lõpetatakse kohe, kui mõni käsk annab vea
set -e

# Kontrollime root-õigusi
if [ "$(id -u)" -ne 0 ]; then
    echo "Viga: käivita skript root-õigustega (sudo $0)"
    exit 1
fi

# --- Seadistus ---
APT_CONFIG_VER="0.8.40-1"   # vajadusel uuenda
MYSQL_ROOT_PASS="qwerty"    # ainult õppetööks!
DEB_URL="https://dev.mysql.com/get/mysql-apt-config_${APT_CONFIG_VER}_all.deb"

# Loeme, mitu korda leitakse "ok installed"
MYSQL=$(dpkg-query -W -f='${Status}' mysql-community-server 2>/dev/null | grep -c 'ok installed' || true)

if [ "$MYSQL" -eq 0 ]; then
    echo "Paigaldame mysql-server"

    # Ei küsita midagi (sinine ekraan)
    export DEBIAN_FRONTEND=noninteractive

    # Vajalikud tööriistad
    apt update
    apt install -y gnupg ca-certificates debconf-utils wget

    # 1. Vastused mysql-apt-config paketi küsimustele
    echo "mysql-apt-config mysql-apt-config/select-server select mysql-8.4-lts" | debconf-set-selections
    echo "mysql-apt-config mysql-apt-config/select-tools select Disabled" | debconf-set-selections
    echo "mysql-apt-config mysql-apt-config/select-product select Ok" | debconf-set-selections

    # 2. Vastused serveri paigalduse küsimustele (root-parool, autentimine)
    echo "mysql-community-server mysql-community-server/root-pass password $MYSQL_ROOT_PASS" | debconf-set-selections
    echo "mysql-community-server mysql-community-server/re-root-pass password $MYSQL_ROOT_PASS" | debconf-set-selections
    echo "mysql-community-server mysql-server/default-auth-override select Use Strong Password Encryption (RECOMMENDED)" | debconf-set-selections

    # 3. Laeme alla ja paigaldame Oracle'i APT konfiguratsioonipaketi (lisab repositooriumi)
    wget -O /tmp/mysql-apt-config.deb "$DEB_URL"
    dpkg -i /tmp/mysql-apt-config.deb

    # 4. Uuendame allikad ja paigaldame serveri
    apt update
    apt install -y mysql-server

    # 5. Teenus käivitub nüüd ja ka pärast reboot'i
    systemctl enable --now mysql

    # 6. .my.cnf, et "mysql" käsk ei küsiks parooli
    cat > /root/.my.cnf <<EOF
[client]
host=localhost
user=root
password=$MYSQL_ROOT_PASS
EOF
    chmod 600 /root/.my.cnf

    echo "mysql on paigaldatud"
    mysql --version

else
    echo "mysql on juba paigaldatud"
    mysql --version
    systemctl status mysql --no-pager
fi

# skripti lopp
