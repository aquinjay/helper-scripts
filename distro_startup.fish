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

# Check if pacman is available
set packages git neovim tree bat chezmoi nodejs npm

pacman -S --needed --noconfirm $packages

# setup chezmoi dotfile
#if not test -d ~/.local/share/chezmoi
#	echo 'Chezmoi init file not available. Initializing file.'
#	chezmoi init https://github.com/aquinjay/dotfiles.git
#else
#	echo 'Chezmoi file already exists.'
#end

#echo "Setup GitHub Identity"
#git config --global user.email "afquinteroj@pm.me"
#git config --global user.name "aquinjay"

# Create git management directories
#echo "Create Git directories"
#set base_dir $HOME/Documents/git
#mkdir -p $base_dir/GitHub $base_dir/GitLab

#echo "Please add ssh agent to fish configuration"
