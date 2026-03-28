#!/bin/bash

set -e

echo "== Fix Debian Buster Repo & Key =="

# Import key Debian lama
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0E98404D386FA1D9
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6ED0E7B82643E131

# Download & install Freexian keyring
wget -q https://deb.freexian.com/extended-lts/pool/main/f/freexian-archive-keyring/freexian-archive-keyring_2022.06.08_all.deb
dpkg -i freexian-archive-keyring_2022.06.08_all.deb

# Backup sources.list lama
cp /etc/apt/sources.list /etc/apt/sources.list.bak

# Tulis ulang sources.list
cat > /etc/apt/sources.list <<EOF
deb http://archive.debian.org/debian buster main contrib non-free
deb http://archive.debian.org/debian buster-updates main contrib non-free
deb http://archive.debian.org/debian-security buster/updates main contrib non-free
deb http://archive.debian.org/debian buster-backports main contrib non-free
deb http://deb.freexian.com/extended-lts buster main contrib non-free
EOF

# Disable valid-until check
echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid

# Update & upgrade
apt update -y
apt full-upgrade -y

echo "== SELESAI =="
