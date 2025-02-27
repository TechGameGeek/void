#!/bin/bash
# Automount-Skript ohne vfat oder ntfs Partitionen, nur Partitionen mit einem Dateisystem, das kein vfat oder ntfs ist, werden gemountet

echo "Starte das Automount-Skript..."

# Alle Partitionen mit einem Dateisystem ermitteln (nur 'part' und 'fstype' überprüfen)
for dev in $(lsblk -lnpo NAME,FSTYPE,TYPE | awk '$2 && $3 == "part" {print $1}'); do
    echo "Überprüfe Gerät: $dev"

    # Prüfen, ob das Dateisystem vfat oder ntfs ist
    fstype=$(lsblk -no FSTYPE "$dev")
    
    # Überspringe vfat und ntfs Partitionen
    if [[ "$fstype" == "vfat" || "$fstype" == "ntfs" ]]; then
        echo "Überspringe Partition mit $fstype: $dev"
        continue
    fi

    # Prüfen, ob die Partition bereits eingebunden ist
    if ! mount | grep -q "$dev"; then
        echo "Mounting $dev..."
        udisksctl mount -b "$dev" || echo "Fehler beim Mounten von $dev"
    else
        echo "$dev ist bereits eingebunden."
    fi
done

echo "Automount-Skript beendet."
