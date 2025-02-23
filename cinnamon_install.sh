#!bin/bash
sudo xbps-install -Syu
sudo xbps-install -y void-repo-nonfree
sudo xbps-install -y void-repo-multilib
sudo xbps-install -Syu
sudo xbps-install -y nvidia-driver nvidia-drm nvidia-utils
sudo xbps-install -y xorg xorg-server xf86-input-libinput
sudo xbps-install -y cinnamon cinnamon-desktop cinnamon-control-center cinnamon-screensaver cinnamon-settings-daemon cinnamon-applets cinnamon desktlets gnome-themes 
sudo xbps-install -y papirus-icon-theme sudo xbps-install -y cinnamon-themes sddm cinnamon-themes
sudo ln -s /etc/sv/sddm /var/service/
sudo xbps-install -y firefox-esr vlc gstreamer gstreamer-plugins-good gstreamer-plugins-bad gstreamer-plugins-ugly gnome-system-monitor xrandr dconf-editor
sudo xbps-install -y  
xbps-install -y network-manager
xbps-install -y network-manager-applet
sudo ln -s /etc/sv/networkmanager /var/service/
sudo xbps-install -y pipewire pipewire-pulse pavucontrol
sudo ln -s /etc/sv/pipewire /var/service/
sudo ln -s /etc/sv/pipewire-pulse /var/service/
