#!/bin/bash

# Skript zur Installation von VirtualBox Guest Additions auf Debian 10, 11 und 12

set -e  # Stoppe das Skript bei Fehlern

echo "Starte die Installation der VirtualBox Guest Additions..."

# Installiere lsb-release, falls nicht vorhanden
echo "Installiere lsb-release..."
sudo apt update
sudo apt install -y lsb-release

# Füge Backports zu sources.list hinzu
echo "Füge Backports zur sources.list hinzu..."
echo "deb http://deb.debian.org/debian $(lsb_release -cs)-backports main contrib" | sudo tee /etc/apt/sources.list.d/backports.list

# Importiere den fasttrack-archive-keyring
echo "Installiere fasttrack-archive-keyring..."
sudo apt install -y fasttrack-archive-keyring

# Füge die Fast Track Repositories hinzu
echo "Füge die Fast Track Repositories hinzu..."
echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-fasttrack main contrib" | sudo tee /etc/apt/sources.list.d/fasttrack.list
echo "deb http://fasttrack.debian.net/debian-fasttrack/ $(lsb_release -cs)-backports-staging main contrib" | sudo tee -a /etc/apt/sources.list.d/fasttrack.list

# Aktualisiere die Paketliste
echo "Aktualisiere die Paketliste..."
sudo apt update

# Installiere VirtualBox und das Extension Pack
echo "Installiere VirtualBox und das Extension Pack..."
sudo apt install -y virtualbox virtualbox-ext-pack

sudo apt install -y virtualbox-guest-utils

echo "Installation abgeschlossen!"
