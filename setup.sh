#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/.dotfiles
############################

#  Variables
dir=~/.dotfiles
templates=$dir/templates
extras=$dir/extras
olddir=~/.dotfiles_old
files="gitconfig zshrc zpreztorc gitignore_global npmrc"

# Install Homebrew
echo "> Installing Home Brew"
sh homebrew.sh

# Install Applications with Homebrew
echo "> brew bundle"
brew bundle

# create dotfiles_old in homedir
echo "> Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir

# change to the dotfiles directory
echo "> Changing to the $templates directory"
cd $templates

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
echo "> Moving existing dotfiles from ~ to $olddir \n"
for file in $files; do
    mv ~/.$file $olddir/
    ln -s $templates/$file ~/.$file
done

# Copy over Sublime Text 3 Settings
echo "> Copying Over Atom Info"
ln -sf $extras/config.cson ~/.atom
ln -sf $extras/keymap.cson ~/.atom
ln -sf $extras/package.cson ~/.atom
ln -sf $extras/snippets.cson ~/.atom
ln -sf $extras/styles.less ~/.atom
ln -sf $extras/init.coffee ~/.atom

# Create Packages.txt File
echo "> Creating Packages.txt file"
sh atom-package-backup.sh

# Install Atom packages
echo "> Install Atom Packages"
sh atom-package-install.sh

echo "--------->"
echo "Installation Complete"
echo "--------->"
