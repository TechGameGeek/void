#!/bin/bash
# Setze das gewünschte KDE-Theme / Set KDE theme
plasma-apply-desktoptheme breeze-dark
lookandfeeltool -a org.kde.breezedark.desktop

#Hintergrundbild festlegen / set wallpaperimage
plasma-apply-wallpaperimage "/usr/share/backgrounds/background.jpg"

# Lösche den Autostart-Eintrag nach der ersten Ausführung / remove one-time-autostart-entry
rm -f ~/.config/autostart/set-kde-theme.desktop

