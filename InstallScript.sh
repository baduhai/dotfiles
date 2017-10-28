#!/bin/bash

#===============================================================================
#
#                                    NOTE!
#
# If you are not me and have come accross this script, I can't stop you from
# running it, but be ware that this was written for personal use, if any harm
# comes from you running this script, it's not my fault.
#
#===============================================================================

#===============================
# Welcome prompt & safety check
#===============================

echo -n "Welcome to the dofiles install script. Please make sure that this script is not being run as root. Continue? (y/N) ==> "; read answer
if [[ $answer = "N" ]] ; then
  echo "Please run this script as a normal user" && exit
else
  echo -n "Has the git repo been cloned in '~/Repos'? (y/N) ==> "; read answer2
  if [[ $answer2 = "N" ]] ; then
    echo "Please move the folder to its correct directory" && exit
  else
    echo "All conditions have been met, the script will now replace dotfiles"
  fi
fi

#===========
# Variables
#===========

dotfiles_dir=~/Repos/dotfiles
log_file=~/dofilesInstallScriptLog.txt

#================================
# Deleting pre-existing dotfiles
#================================

sudo rm -rf ~/.Xdefaults
sudo rm -rf ~/.Xresources
sudo rm -rf ~/.gitconfig
sudo rm -rf ~/.config/ignore-lid-switch-tweak.desktop
sudo rm -rf ~/.scripts/cpu
sudo rm -rf ~/.scripts/gnome-tweak-tool-lid-inhibitor
sudo rm -rf ~/.scripts/weather

#=============================
# Creating Folders & SymLinks
#=============================

cd
mkdir .config
mkdir .scripts
ln -sf $dotfiles_dir/.Xdefaults
ln -sf $dotfiles_dir/.Xresources
ln -sf $dotfiles_dir/.gitconfig
ln -sf $dotfiles_dir/.config/ignore-lid-switch-tweak.desktop ~/.config/
ln -sf $dotfiles_dir/.scripts/cpu ~/.scripts/
ln -sf $dotfiles_dir/.scripts/gnome-tweak-tool-lid-inhibitor ~/.scripts/
ln -sf $dotfiles_dir/.scripts/weather ~/.scripts/

#===================================
# Ask to run Package Install Script
#===================================
