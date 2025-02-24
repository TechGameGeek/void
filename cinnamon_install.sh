#!/bin/bash
#Skript ist noch nicht fertig - noch nicht verweden! / WORK IN PROGRESS -- do not use yet!
#Das Skript ist für NVIDIA-GPU Besitzer gedacht / AMD GPU Besitzer kommentieren die Zeile mit der NVIDIA Paketinstallation aus!
#This script is intended to be used by NVIDIA-GPU Owners, you may comment the line with
#sudo xbps-install -y nvidia if you have an AMD-GPU
#Void aktualisieren / update void

#Setze Keyboardlayout de-latin1 / Set keyboard de-latin1 (if you don't want DE-key comment out this line)
#loadkeys de-latin1

#Das folgende Skript ist für die Installation von Cinnamon & div. Dienste gedacht, nachdem die Basisinstallation durchgefuehrt worden ist!
#The following script is for installing Cinnamon & Services after installing base-void (glibc)

#bash starten & bash für root setzen / start bash - set for root
clear
echo "Setze Rootshell auf /bin/bash / set rootshell to /bin/bash"
echo "Bitte Rootpasswort eingeben / Please give rootpassword"
su -c "chsh -s /bin/bash root"
sleep 2

#Sudo einrichten / Activate sudo
clear
echo "Aktiviere sudo für Gruppe wheel / Activate sudo for wheel-group"
echo "Bitte Rootpasswort eingeben / Please give rootpassword"
su -c 'echo "%wheel ALL=(ALL:ALL) ALL" | tee -a /etc/sudoers > /dev/null'
sleep 2

#Systemupdate checken / Check systemupdates
sudo xbps-install -Syu

#void zusätzliche Repos aktivieren / activate all essential Repos
clear
echo "Nonfree, multilib, multilib-nonfree aktivieren / Activate all essential additional repos"
sudo xbps-install -y void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree
sleep 2

#Voidrepo aktualisieren / update voidrepository
sudo xbps-install -Syu

#Editor installieren / Install editor
clear
echo "Install nano..."
sudo xbps-install -y nano
sleep 1

#Netzwerk/Network
clear
echo "Install NetworkManager"
sudo xbps-install -y NetworkManager
sudo ln -s /etc/sv/NetworkManager /var/service/
sleep 1

#Audio
clear
echo "Install pipewire, wireplumber, pavucontrol, pulsemixer"
sudo xbps-install -y pipewire wireplumber pavucontrol pulsemixer
#sudo ln -s /etc/sv/pipewire /var/service/
#sudo ln -s /etc/sv/pipewire-pulse /var/service/
#sudo usermod -aG _pipewire,pulse,pulse-access $USER
sleep 1

#dbus
clear
echo "Install dbus..."
sudo xbps-install -y dbus
sudo ln -s /etc/sv/dbus /var/service/
sleep 1

#NVIDIA Treiber installieren / Install NVIDIA-driver
read -p "NVIDIA-Treiber installieren / Install Nvidia-driver? (1 = Ja/Yes, 0 = Nein/No): " auswahl
if [ "$auswahl" -eq 1 ]; then
    echo "Installiere NVIDIA-Treiber / Installing NVIDIA..."
    sudo xbps-install -y nvidia
else
    echo "NVIDIA-Setup übersprungen / NVIDIA skipped."
fi
#XORG & Cinnamon & Tools
sudo xbps-install -y xorg
sudo xbps-install -y octoxbps cinnamon-all xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk xdg-utils

#Druckerunterstuetzung / Printersupport
sudo xbps-install -y cups cups-filters gutenprint
sudo ln -s /etc/sv/cupsd /var/service/
sudo xbps-install -y gnome-system-tools users-admin

#Filesystem
sudo xbps-install -y exfat-utils fuse-exfat gvfs-afc gvfs-mtp gvfs-smb udisks2 ntfs-3g gptfdisk 

#Flatpak / Upgradetool
sudo xbps-install -y flatpak topgrade

#Fonts
sudo xbps-install -y noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf noto-fonts-ttf-extra

#Software
sudo xbps-install -y firefox terminal

#Loginmanager
sudo xbps-install -y lightdm lightdm-gtk-greeter
sudo ln -s /etc/sv/lightdm/ /var/service/

#Cinnamon-Themes
sudo xbps-install -y arc-icon-theme arc-theme

#Theme-Einstellungen / Setup Theme
gsettings set org.cinnamon.desktop.interface icon-theme Arc
gsettings set org.cinnamon.desktop.interface gtk-theme Arc-Dark
gsettings set org.cinnamon.theme name Arc-Dark

#Hintergundbild setzen / Set Wallpaper
#muss natürlich vorhanden sein! / Has to be installed in this folder!
#gsettings set org.cinnamon.desktop.background picture-uri file:///usr/share/wallpaper/mystical.jpeg

