# setup chezmoi dotfile
if not test -d ~/.local/share/chezmoi
	echo 'Chezmoi init file not available. Initializing file.'
	chezmoi init https://github.com/aquinjay/dotfiles.git
else
	echo 'Chezmoi file already exists.'
end

echo "Setup GitHub Identity"
git config --global user.email "afquinteroj@pm.me"
git config --global user.name "aquinjay"

# Create git management directories
echo "Create Git directories"
set base_dir $HOME/Documents/git
mkdir -p $base_dir/GitHub $base_dir/GitLab

echo "Please add ssh agent to fish configuration"
