#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
<<<<<<< HEAD
files="bashrc vimrc vim zshrc oh-my-zsh xinitrc i3 Xresources fonts"    # list of files/folders to symlink in homedir
=======
files="bashrc vimrc vim fonts zshrc oh-my-zsh xinitrc i3 Xresources"    # list of files/folders to symlink in homedir
>>>>>>> 6d97bed64dc0c57af13a308b86450b9ea36d5d34

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
     echo "Moving any existing dotfiles from ~ to $olddir"
     mv ~/.$file ~/dotfiles_old/
     echo "Creating symlink to $file in home directory."
     ln -s $dir/$file ~/.$file
done
