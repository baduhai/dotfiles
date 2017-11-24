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

echo -n -e "Welcome to the dofiles install script. Please make sure that this script is not being run as root. Continue? \n(y/N) ==> "; read answer
if [[ $answer = "N" ]] ; then
  echo "Please run this script as a normal user!" && exit
else
  echo -n -e "Has the git repo been cloned in '~/Repos'? \n(y/N) ==> "; read answer2
  if [[ $answer2 = "N" ]] ; then
    echo "Please move the folder to its correct directory!" && exit
  else
    echo "All conditions have been met, the script will begin replacing dotfiles in 5 seconds." && sleep 5
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
sudo rm -rf ~/.config
sudo rm -rf ~/.scripts
sudo rm -rf ~/.vimrc

#=============================
# Creating Folders & SymLinks
#=============================

cd
mkdir .config
mkdir .scripts
mkdir .config/nvim
ln -sf $dotfiles_dir/.Xdefaults
ln -sf $dotfiles_dir/.Xresources
ln -sf $dotfiles_dir/.gitconfig
ln -sf $dotfiles_dir/.vimrc
ln -sf $dotfiles_dir/.config/ ~/.config/
ln -sf $dotfiles_dir/.scripts ~/.scripts/
ln -sf ~.vimrc ~/.config/nvim/init.vim

#===================================
# Ask to run Package Install Script
#===================================

echo -n -e "The script was successful, congratulations! Would you like to run the Package Install Script? \n(y/N)==>"; read answer3
if [[ $answer3 = "N" ]] ; then
  echo "Goodbye." && exit
else
  bash PInstallScript.sh
fi
