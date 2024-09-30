#!/usr/bin/fish

# Check if the fish shell is available
if not command -v fish >/dev/null
	echo 'Fish shell is not available. Install Fish!'
	exit 1
end

if test (id -u) -ne 0
	echo "This script must be run as root!"
	exit 1
end

if not test (awk -F= '$1=="ID_LIKE" {print $2}' /etc/os-release) = "arch"
	echo "You are not using Arch Linux"
	exit 1
end

# Install packages
set packages git neovim tree bat chezmoi nodejs npm cmake

pacman -S --needed --noconfirm $packages

# check if I am using garuda linux
if test (awk -F= '$1=="NAME" {print $2}' /etc/os-release | tr -d '"') = "Garuda Linux"

	# Check if the graphics startup document is available
	
	if not test -e /etc/dracut.conf.d/earlykms.conf 
		echo 'Warning, early graphics configuration file does not exist'
		set vc_startup /etc/dracut.conf.d/earlykms.conf
		mkdir -p (dirname $vc_startup)
		echo 'force_drivers+=" i915 "' > $vc_startup
		dracut-rebuild
		
		echo 'Rebooting in 5 seconds'
		sleep 5
		reboot
	else
		echo 'Early graphics configuration file already exists.'
	end

else
	echo 'You are not using Garuda Linux'
	exit 0
end
