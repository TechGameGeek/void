#!/bin/bash
# Setze das gewünschte KDE-Theme / Set KDE theme
plasma-apply-desktoptheme breeze-dark
lookandfeeltool -a org.kde.breezedark.desktop

# Lösche den Autostart-Eintrag nach der ersten Ausführung / remove one-time-autostart-entry
rm -f ~/.config/autostart/set-kde-theme.desktop

