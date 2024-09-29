#!/usr/bin/fish

# setup chezmoi dotfile
if not test -d ~/.local/share/chezmoi
	echo 'Chezmoi init file not available. Initializing file.'
	chezmoi init https://github.com/aquinjay/dotfiles.git

	chezmoi apply
else
	echo 'Chezmoi file already exists.'
end

echo "Setup GitHub Identity"
set github_email "103866978+aquinjay@users.noreply.github.com"
set github_username

if test -z "$github_username"
  echo "Error: GitHub username is not set. Exiting..."
  exit 1
end

git config --global user.email $github_email
git config --global user.name $github_username

# Create git management directories
echo "Create Git directories"
set base_dir $HOME/Documents/git
mkdir -p $base_dir/GitHub $base_dir/GitLab

# Generate SSH Key if it doesn't exist
if not test -f ~/.ssh/id_ed25519
    echo "Generating ed25519 SSH Key"
    ssh-keygen -t ed25519 -C $github_email -f ~/.ssh/id_ed25519 -N ''
end

# Print SSH public key (add to GitHub manually)
echo "Here is your SSH public key, add this to your GitHub account:"
cat ~/.ssh/id_ed25519.pub

echo "GitHub setup complete"


