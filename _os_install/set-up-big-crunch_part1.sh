#!/bin/bash
# sudo fdisk -l
# mount using omv

cd /home/
echo ">>> Setting up Big Crunch..."

echo ">>> Updating ..."
sudo apt update
sudo apt upgrade

echo ">>> Installing motion"
yes | sudo apt-get install motion

echo ">>> Installing git"
yes | sudo apt-get install git

echo ">>> Cleaning installation"
sudo apt clean
sudo apt autoremove

echo ">>> Updating ..."
sudo apt update
sudo apt upgrade

echo ">>> Installing openmediavault"
yes | wget -O - https://raw.githubusercontent.com/OpenMediaVault-Plugin-Developers/installScript/master/install | sudo bash

echo ">>> Run part 2 after restart!"
