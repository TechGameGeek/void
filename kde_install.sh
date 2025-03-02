#!/bin/bash
# !! WORK IN PROGRESS -- Do not use yet! !!
#Das Skript ist für NVIDIA-GPU Besitzer gedacht / AMD GPU Besitzer kommentieren die Zeile mit der NVIDIA Paketinstallation aus!
#This script is intended to be used by NVIDIA-GPU Owners, you may comment the line with

#Das folgende Skript ist für die Installation von Cinnamon & div. Dienste gedacht, nachdem die Basisinstallation durchgefuehrt worden ist!
#The following script is for installing Cinnamon & Services after installing base-void (glibc)

#bash starten & bash für root setzen / start bash - set for root
clear
echo "Setze Rootshell auf /bin/bash / set rootshell to /bin/bash"
echo "Bitte Rootpasswort eingeben / Please give rootpassword"
su -c "chsh -s /bin/bash root"
sleep 2

#Sudo einrichten / Activate sudo
#clear
#echo "Aktiviere sudo für Gruppe wheel / Activate sudo for wheel-group"
#echo "Bitte Rootpasswort eingeben / Please give rootpassword"
#su -c 'echo "%wheel ALL=(ALL:ALL) ALL" | tee -a /etc/sudoers > /dev/null'
#sleep 2

#Styling
clear
echo "Richte Hintergrundbild ein / Setting up backgroundimage"
echo " -- Bitte unten das sudo Passwort eingeben / Please give sudo-password -- "
sudo mkdir -p /usr/share/backgrounds/
sudo cp ~/void/*.jpg /usr/share/backgrounds/
sudo cp ~/void/set-kde-theme.sh /usr/bin/
sudo chmod +x /usr/bin/set-kde-theme.sh


#Kopiere Autostartscript für udisks2 / copy automountscript für udisk2
sudo cp ~/void/mount_disks.sh /usr/bin/
sudo chmod +x /usr/bin/mount_disks.sh


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

#dbus
clear
echo "Install dbus..."
sudo xbps-install -y dbus
sudo ln -s /etc/sv/dbus /var/service/
sleep 1

#elogind
clear
echo "Install elogind..."
sudo xbps-install -y elogind
sudo ln -s /etc/sv/elogind /var/service/
sleep 1

#Audio/bluetooth/Mixer
clear
echo "Install pipewire, wireplumber, pavucontrol, pulsemixer"
sudo xbps-install -y pipewire wireplumber pavucontrol pulsemixer libspa-bluetooth blueman bluez-cups
sleep 1

#NVIDIA Treiber installieren / Install NVIDIA-driver
clear
echo "Verfügbare NVIDIA-Treiber:"
echo "1) Neueste NVIDIA-Treiber (nvidia) / Latest driver"
echo "2) NVIDIA 470 (nvidia470) / GTX 600,700..."
echo "3) NVIDIA 390 (nvidia390) Geforce 400/500 Serie"
echo "0) Keine Installation"
read -p "Bitte wählen Sie einen Treiber aus (1-3, 0 zum Abbrechen): " auswahl

case "$auswahl" in
    1)
        echo "Installiere neueste NVIDIA-Treiber... / Installing latest driver"
        sudo xbps-install -y nvidia nvidia-libs-32bit
        ;;
    2)
        echo "Installiere NVIDIA 470-Treiber... / Installing 470 driver"
        sudo xbps-install -y nvidia470 nvidia470-libs-32bit
        ;;
    3)
        echo "Installiere NVIDIA 390-Treiber... / Installing 390 driver"
        sudo xbps-install -y nvidia390 nvidia390-libs-32bit
        ;;
    0)
        echo "NVIDIA-Setup übersprungen. / Setup skipped!"
        ;;
    *)
        echo "Ungültige Auswahl. Keine Änderungen vorgenommen. / invalid selection!"
        ;;
esac

sleep 1

#Steamkomponenten / Install some Steam-related-Stuff
sudo xbps-install -y libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit mesa-dri-32bit

#XORG & Cinnamon & Tools
clear
echo "Install XORG/KDE..."
sudo xbps-install -y xorg
sudo xbps-install -y octoxbps kde-plasma kde-baseapps ffmpegthumbs xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk xdg-utils
sleep 1

#Druckerunterstuetzung / Printersupport
clear
echo "Install Printer..."
sudo xbps-install -y cups cups-filters gutenprint print-manager
sudo ln -s /etc/sv/cupsd /var/service/
sleep 1

#Filesystem
clear
echo "Install Zusatztools/Installing additional tools..."
sudo xbps-install -y exfat-utils fuse-exfat gvfs-afc gvfs-mtp gvfs-smb udisks2 ntfs-3g gptfdisk bluez
#Aktiviere bluetoothd/activate bluetoothd
sudo ln -s /etc/sv/bluetoothd /var/service/
sleep 1

#Flatpak / Upgradetool
clear
echo "Install Flatpak / topgrade..."
sudo xbps-install -y flatpak flatpak-kcm topgrade
sleep 1

#Fonts
clear
echo "Install Fonts..."
sudo xbps-install -y noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf noto-fonts-ttf-extra
sleep 1

#Software
clear
echo "Install Software..."
sudo xbps-install -y firefox firefox-i18n-de
sleep 1

#Setup Autostart Loginmanager
echo "Start Service SDDM..."
sudo ln -s /etc/sv/sddm/ /var/service/
sleep 1

#Setup Autostart - pipewire & wireplubmer
sudo mkdir -p /etc/pipewire/pipewire.conf.d
sudo ln -s /usr/share/examples/wireplumber/10-wireplumber.conf /etc/pipewire/pipewire.conf.d/
sudo ln -s /usr/share/examples/pipewire/20-pipewire-pulse.conf /etc/pipewire/pipewire.conf.d/

#Nur pipewire automatisch starten lassen (wireplumber nicht)
sudo ln -s /usr/share/applications/pipewire.desktop /etc/xdg/autostart/
sleep 1
clear

#Setup automount ssd/hdd - ohne fstab / setup automount for ssds/hdds - without fstab
sudo cp ~/void/10-mount-drives.rules /etc/polkit-1/rules.d/
clear

#Setup .desktopfile (autostart) fuer set-kde-theme
sudo cp ~/void/set-kde-theme.desktop ~/.config/autostart/
sudo chmod +x ~/.config/autostart/set-kde-theme.desktop

#Setup sddm wallpaper
sudo cp ~/void/sddm.conf /etc/sddm.conf

#Setup octo-xbps-notifier Autostart
sudo cp ~/void/octoxbpsnotifier.desktop ~/.config/autostart/
sudo chmod +x ~/.config/autostart/octoxbpsnotifier.desktop


echo "Setupscript beendet - System kann nun neu gestartet werden / Setup finished - please reboot"
echo "sudo reboot verwenden - use sudo reboot"
