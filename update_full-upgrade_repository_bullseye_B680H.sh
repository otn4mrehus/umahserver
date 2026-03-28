#!/bin/bash

set -e

echo "== Fix Debian Buster Repo & Key =="


# Download & install Freexian keyring
wget -q https://deb.freexian.com/extended-lts/pool/main/f/freexian-archive-keyring/freexian-archive-keyring_2022.06.08_all.deb
dpkg -i freexian-archive-keyring_2022.06.08_all.deb

# Backup sources.list lama
cp /etc/apt/sources.list /etc/apt/sources.list.buster

# Tulis ulang sources.list
cat > /etc/apt/sources.list <<EOF
deb http://deb.debian.org/debian bullseye main contrib non-free
deb http://deb.debian.org/debian bullseye-updates main contrib non-free
deb http://security.debian.org/debian-security bullseye-security main contrib non-free
deb http://deb.freexian.com/extended-lts bullseye main contrib non-free
EOF

# Disable valid-until check
echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid

# Update & upgrade
apt update -y
apt full-upgrade -y

echo "== SELESAI =="
