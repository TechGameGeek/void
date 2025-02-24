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

clear
sudo mkdir -p /usr/share/backgrounds/
sudo cp ~/void/*.jpg /usr/share/backgrounds/

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
sleep 1

#dbus
clear
echo "Install dbus..."
sudo xbps-install -y dbus
sudo ln -s /etc/sv/dbus /var/service/
sleep 1

#NVIDIA Treiber installieren / Install NVIDIA-driver
clear
read -p "NVIDIA-Treiber installieren / Install Nvidia-driver? (1 = Ja/Yes, 0 = Nein/No): " auswahl
if [ "$auswahl" -eq 1 ]; then
    echo "Installiere NVIDIA-Treiber / Installing NVIDIA..."
    sudo xbps-install -y nvidia nvidia-libs-32bit
else
    echo "NVIDIA-Setup übersprungen / NVIDIA skipped."
fi
sleep 1

#Steamkomponenten / Install some Steam-related-Stuff
sudo xbps-install -y libgcc-32bit libstdc++-32bit libdrm-32bit libglvnd-32bit mesa-dri-32bit

#XORG & Cinnamon & Tools
clear
echo "Install XORG/Cinnamon-all..."
sudo xbps-install -y xorg
sudo xbps-install -y octoxbps cinnamon-all xdg-desktop-portal xdg-desktop-portal-gtk xdg-user-dirs xdg-user-dirs-gtk xdg-utils
sleep 1

#Druckerunterstuetzung / Printersupport
clear
echo "Install Printer..."
sudo xbps-install -y cups cups-filters gutenprint
sudo ln -s /etc/sv/cupsd /var/service/
sudo xbps-install -y gnome-system-tools users-admin
sleep 1

#Filesystem
clear
echo "Install Zusatztools/Installing additional tools..."
sudo xbps-install -y exfat-utils fuse-exfat gvfs-afc gvfs-mtp gvfs-smb udisks2 ntfs-3g gptfdisk bluez
sleep 1

#Flatpak / Upgradetool
clear
echo "Install Flatpak / topgrade..."
sudo xbps-install -y flatpak topgrade
sleep 1

#Fonts
clear
echo "Install Fonts..."
sudo xbps-install -y noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf noto-fonts-ttf-extra
sleep 1

#Software
clear
echo "Install Software..."
sudo xbps-install -y firefox gnome-terminal
sleep 1
# Erstelle ein Skript, das die gsettings nach der Anmeldung ausführt
echo "Creating autostart script for cinnamon theme settings..."
cat <<EOL > /home/$USER/set-cinnamon-theme.sh
#!/bin/bash
# Setze das gewünschte Cinnamon-Theme & deutsches Tastaturlayout
gsettings set org.cinnamon.desktop.interface icon-theme Arc
gsettings set org.cinnamon.desktop.interface gtk-theme Arc-Dark
gsettings set org.cinnamon.theme name Arc-Dark
gsettings set org.cinnamon.desktop.input-sources sources "[('xkb', 'de')]"
gsettings set org.gnome.desktop.interface monospace-font-name 'Monospace 11'
gsettings set org.cinnamon.desktop.background picture-uri 'file:///usr/share/backgrounds/cinnamon_background.jpg'




# Lösche den Autostart-Eintrag nach der ersten Ausführung
rm -f ~/.config/autostart/set-cinnamon-theme.desktop

# Gib eine Nachricht aus, dass das Skript abgeschlossen ist
echo "Cinnamon-Themes wurden gesetzt und Autostart-Eintrag entfernt."
EOL

# Stelle sicher, dass das Skript ausführbar ist
chmod +x /home/$USER/set-cinnamon-theme.sh

# Erstelle die Autostart-Datei, die das Skript ausführt
mkdir -p ~/.config/autostart
cat <<EOL > ~/.config/autostart/set-cinnamon-theme.desktop
[Desktop Entry]
Type=Application
Exec=/home/$USER/set-cinnamon-theme.sh
Name=Set Cinnamon Theme
Comment=Set the default Cinnamon theme after login
X-GNOME-Autostart-enabled=true
EOL

# Weiter mit weiteren Installationen oder zum Ende des Skripts
echo "Cinnamon-Theme Autostart-Skript erstellt. Skript beendet."

#Loginmanager
clear
echo "Install LightDM..."
sudo xbps-install -y lightdm lightdm-gtk-greeter
sudo ln -s /etc/sv/lightdm/ /var/service/
sleep 1

#Cinnamon-Themes
clear
echo "Install ArcTheme / Arc-icons..."
sudo xbps-install -y arc-icon-theme arc-theme
sleep 1

# Füge die gewünschten Einstellungen zur LightDM-Konfiguration hinzu
echo "theme-name=Arc-Dark" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf > /dev/null
echo "icon-theme-name=Arc" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf > /dev/null
echo "background=/usr/share/backgrounds/lightdmbackground.jpg" | sudo tee -a /etc/lightdm/lightdm-gtk-greeter.conf > /dev/null
