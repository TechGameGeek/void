# Void Linux KDE-Plasma Installation Script

This script simplifies the installation of Void Linux with the KDE-plasma desktop environment.

## Requirements
- Void Linux (glibc) has been installed using the base image.
- The installed Void Linux has been booted.
- An internet connection is available.

## Initial Steps

1. **Log into Void Linux** (as a normal user).
2. **Install `git`**:
   ```bash
   sudo xbps-install git
   ```
3. **Clone the repository** (as a normal user):
   ```bash
   git clone -b kde https://github.com/TechGameGeek/void.git
   ```
   > *Note:* The repository will be cloned to `~/void`.
4. **Navigate to the directory**:
   ```bash
   cd void
   ```
5. **Make the script executable**:
   ```bash
   chmod +x kde_install.sh
   ```
6. **Run the script**:
   ```bash
   ./kde_install.sh
   ```

## What does the script do?
- Installs Void Linux with the KDE-plasma desktop environment.
- Activates:
  - PipeWire
  - Printer support
  - Bluetooth
- During installation, you will be asked whether you want to install NVIDIA drivers (from latest to older versions).
- Automatically mounts drives using `udisks2` & `polkit`, so there's no need to edit `/etc/fstab`.
- Customizations:
  - KDE and SDDM background images are modified.
  - Autostart scripts for KDE-plasma:
    - **Enables `octoxbps-updater`**.
    - **Automounts all Linux filesystem drives**, useful for a Steam library, for example.

## Feedback
Suggestions and improvements are always welcome! 😊
