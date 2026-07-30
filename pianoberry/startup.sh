#!/bin/sh

CONFIG_FILE="/mnt/mmcblk0p1/config.txt"

function read_config() {
	while IFS= read -r line; do
		case "$line" in
			pianoteq_serial=*)
				PIANOTEQ_SERIAL="${line#*=}"
				;;
			pianoteq_initial_preset=*)
				PIANOTEQ_INITIAL_PRESET="${line#*=}"
				;;
		esac
	done < "$CONFIG_FILE"
}

mount /mnt/mmcblk0p1

read_config

if [ ! -f "/opt/.activated" ]; then
	# Check if the boot partition contains Pianoteq binary
	for version in 8 9; do
		if [ -f "/mnt/mmcblk0p1/Pianoteq $version" ]; then
			sudo install -m 755 "/mnt/mmcblk0p1/Pianoteq $version" /usr/bin/Pianoteq
			break
		fi
	done

	# Check if Pianoteq is trial or full version by checking if --help contains the --activate flag
	# If it's the full version, activate the license
	if sudo "/usr/bin/Pianoteq" --help | grep activate; then
		# Wait for internet connection
		while true; do ping -c1 www.google.com > /dev/null && break; done

		sudo "/usr/bin/Pianoteq" --headless --activate pianoberry:$PIANOTEQ_SERIAL

		if [ $? -eq 0 ]; then
			sudo touch /opt/.activated
			# Ensure /root is being synced
			sudo echo "root" >> /opt/.filetool.lst
			sudo echo "usr/bin/Pianoteq" >> /opt/.filetool.lst
			sudo filetool.sh -b
		fi
	fi
fi

# Create Pianoteq user presets folder if it doesn't exist
sudo mkdir -p "/root/.local/share/Modartt/Pianoteq/Presets/My Presets/"

# Check if there are any .fxp files in the boot partition and copy them to the Pianoteq user presets folder
find /mnt/mmcblk0p1 -maxdepth 1 -type f -name "*.fxp" | while read -r fxp_file; do
	filename=$(basename "$fxp_file")
	sudo install -m 644 "$fxp_file" "/root/.local/share/Modartt/Pianoteq/Presets/My Presets/$filename"
done

# Check if there is a midi-map.ptm file in the boot partition and copy it to the Pianoteq installation folder
if [ -f "/mnt/mmcblk0p1/midi-map.ptm" ]; then
	sudo install -m 644 "/mnt/mmcblk0p1/midi-map.ptm" "/usr/bin/midi-map/midi-map.ptm"
fi

umount /mnt/mmcblk0p1

sudo "/usr/bin/Pianoteq" --headless --preset "$PIANOTEQ_INITIAL_PRESET" --midimapping "midi-map"
