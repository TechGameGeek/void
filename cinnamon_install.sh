#!bin/bash

#Void aktualisieren / update void
sudo xbps-install -Syu

#void-nonfree Repository aktivieren / Activate void nonfree-repository
sudo xbps-install -y void-repo-nonfree

#void-multilib Repository aktivieren / Activate void multilib-repository (e.g. for Steaminstall)
sudo xbps-install -y void-repo-multilib

#Voidrepo aktualisieren / update voidrepository
sudo xbps-install -Syu

#Netzwerk/Network
sudo xbps-install -y NetworkManager
sudo ln -s /etc/sv/NetworkManager /var/service/

#Audio
sudo xbps-install -y pipewire wireplumber
sudo ln -s /etc/sv/pipewire /var/service/
sudo ln -s /etc/sv/pipewire-pulse /var/service/
sudo usermod -aG _pipewire,pulse,pulse-access $USER

#dbus
sudo xbps-install -y dbus
sudo ln -s /etc/sv/dbus /var/service


#NVIDIA Treiber installieren / Install NVIDIA-driver
sudo xbps-install -y nvidia-driver nvidia-drm nvidia-utils

#XORG & Cinnamon & Tools
sudo xbps-install -y xorg
sudo xbps-install -y cinnamon-all xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk xdg-utils

#Druckerunterstuetzung / Printersupport
sudo xbps-install -y cups cups-filters gutenprint
sudo ln -s /etc/sv/cupsd /var/service

#Fonts
sudo xbps-install -y noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf noto-fonts-ttf-extra

#Software
sudo xbps-install -y firefox-esr terminal

#Loginmanager
sudo xbps-install -y lightdm light-gtk-greeter
sudo ln -s /etc/sv/lightdm/ /var/service/

