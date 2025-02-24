#!bin/bash
#Skript ist noch nicht fertig - noch nicht verweden! / WORK IN PROGRESS -- do not use yet!
#Das Skript ist für NVIDIA-GPU Besitzer gedacht / AMD GPU Besitzer kommentieren die Zeile mit der NVIDIA Paketinstallation aus!
#This script is intended to be used by NVIDIA-GPU Owners, you may comment the line with
#sudo xbps-install -y nvidia if you have an AMD-GPU
#Void aktualisieren / update void

#Setze Keyboardlayout de-latin1 / Set keyboard de-latin1 (if you don't want DE-key comment out this line)
#loadkeys de-latin1

#Sudo einrichten
entry="%wheel ALL=(ALL:ALL) ALL"
echo "$entry" | sudo tee -a /etc/sudoers > /dev/null

sudo xbps-install -Syu

#void-nonfree Repository aktivieren / Activate void nonfree-repository
sudo xbps-install -y void-repo-nonfree

#void-multilib Repository aktivieren / Activate void multilib-repository (e.g. for Steaminstall)
sudo xbps-install -y void-repo-multilib

#Voidrepo aktualisieren / update voidrepository
sudo xbps-install -Syu

#Editor installieren / Install editor
sudo xbps-install -y nano

#Netzwerk/Network
sudo xbps-install -y NetworkManager
sudo ln -s /etc/sv/NetworkManager /var/service/

#Audio
sudo xbps-install -y pipewire wireplumber pavucontrol pulsemixer
sudo ln -s /etc/sv/pipewire /var/service/
sudo ln -s /etc/sv/pipewire-pulse /var/service/
sudo usermod -aG _pipewire,pulse,pulse-access $USER

#dbus
sudo xbps-install -y dbus
sudo ln -s /etc/sv/dbus /var/service


#NVIDIA Treiber installieren / Install NVIDIA-driver
sudo xbps-install -y nvidia

#XORG & Cinnamon & Tools
sudo xbps-install -y xorg
sudo xbps-install -y octoxbps cinnamon-all xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk xdg-utils

#Druckerunterstuetzung / Printersupport
sudo xbps-install -y cups cups-filters gutenprint
sudo ln -s /etc/sv/cupsd /var/service

#Fonts
sudo xbps-install -y noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf noto-fonts-ttf-extra

#Software
sudo xbps-install -y firefox terminal

#Loginmanager
sudo xbps-install -y lightdm light-gtk-greeter
sudo ln -s /etc/sv/lightdm/ /var/service/

#Cinnamon-Themes
sudo xbps-install -y arc-icon-theme arc-theme

#Theme-Einstellungen / Setup Theme
gsettings set org.cinnamon.desktop.interface icon-theme Arc
gsettings set org.cinnamon.desktop.interface gtk-theme Arc-Dark
gsettings set org.cinnamon.theme name Arc-Dark

#Hintergundbild setzen / Set Wallpaper
#muss natürlich vorhanden sein! / Has to be installed in this folder!
gsettings set org.cinnamon.desktop.background picture-uri file:///usr/share/wallpaper/mystical.jpeg

