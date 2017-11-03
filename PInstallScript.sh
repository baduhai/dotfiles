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
# Welcome prompt & distro check
#===============================

echo -n -e "Welcome to the package install script, please choose your distro base: \n Arch linux(1) \n OpenSUSE(2) \n Solus(3) \n Ubuntu(4) \n Other(5) \n==>" read answer
if [[ $answer = 1 ]] ; then
  sudo pacman -Ssy
  sudo pacman -Syu
  echo -n -e "Please choose your environment: \n [Wayland/Xorg]Gnome(1) \n [Xorg]OpenBox(2) \n [Wayland]Sway(3) \n [Wayland]Way Cooler(4) \n [Wayland/Xorg]KDE(5) \n [Xorg]Budgie(6) \n==>" read answer
  if [[ $answer = 1 ]] ; then
    sudo pacman -S --noconfirm gnome gnome-extras gnome-tweak-tool jshon
    curl -O "https://raw.githubusercontent.com/oshazard/apacman/master/apacman"
    bash ./apacman -S --noconfirm apacman
    rm -rf apacman
  fi
  if [[ $answer = 2 ]] ; then
    sudo pacman -S --noconfirm openbox tint2 menumaker lxappearance feh jshon
    curl -O "https://raw.githubusercontent.com/oshazard/apacman/master/apacman"
    bash ./apacman -S --noconfirm apacman
    rm -rf apacman
  fi
  if [[ $answer = 3 ]] ; then
    sudo pacman -S --noconfirm sway jshon
    curl -O "https://raw.githubusercontent.com/oshazard/apacman/master/apacman"
    bash ./apacman -S --noconfirm apacman
    rm -rf apacman
  fi
  if [[ $answer = 4 ]] ; then
    curl -O "https://raw.githubusercontent.com/oshazard/apacman/master/apacman"
    bash ./apacman -S --noconfirm apacman
    rm -rf apacman
    apacman -S --noconfirm way-cooler way-cooler-bg
  fi
  if [[ $answer = 5 ]] ; then
    sudo pacman -S --noconfirm plasma-desktop latte-dock plasma-wayland-session
    curl -O "https://raw.githubusercontent.com/oshazard/apacman/master/apacman"
    bash ./apacman -S --noconfirm apacman
    rm -rf apacman
  fi
  if [[ $answer = 6 ]] ; then
    sudo pacman -S --noconfirm budgie-desktop
    curl -O "https://raw.githubusercontent.com/oshazard/apacman/master/apacman"
    bash ./apacman -S --noconfirm apacman
    rm -rf apacman
  fi
fi
if [[ $answer = 2 ]] ; then
  repos upate command for OpenSUSE
  repos upgrade command for OpenSUSE
  echo -n -e "Please choose your environment: \n [Wayland/Xorg]Gnome(1) \n [Xorg]OpenBox(2) \n [Wayland]Sway(3) \n [Wayland]Way Cooler(4) \n [Wayland/Xorg]KDE(5) \n [Xorg]Budgie(6) \n==>" read answer
  if [[ $answer = 1 ]] ; then
    Gnome
  fi
  if [[ $answer = 2 ]] ; then
    OpenBox
  fi
  if [[ $answer = 3 ]] ; then
    Sway
  fi
  if [[ $answer = 4 ]] ; then
    Way Cooler
  fi
  if [[ $answer = 5 ]] ; then
    KDE
  fi
  if [[ $answer = 6 ]] ; then
    Budgie
  fi
fi
if [[ $answer = 3 ]] ; then
  sudo eopkg up -y
  echo -n -e "Please choose your environment: \n [Wayland/Xorg]Gnome(1) \n [Xorg]OpenBox(2) \n [Wayland]Sway(3) \n [Wayland]Way Cooler(4) \n [Xorg]KDE(5) \n [Xorg]Budgie(6) \n==>" read answer
  if [[ $answer = 1 ]] ; then
    sudo eopkg install -y gnome-shell
  fi
  if [[ $answer = 2 ]] ; then
    sudo eopkg install -y openbox
  fi
  if [[ $answer = 3 ]] ; then
    sudo eopkg install -y sway
  fi
  if [[ $answer = 4 ]] ; then
    curl https://way-cooler.github.io/way-cooler-release-i3-default.sh -sSLf | bash -s  way-cooler-bg  wc-grab  wc-lock
  if [[ $answer = 5 ]] ; then
    sudo eopkg install -y plasma-desktop
  fi
  if [[ $answer = 6 ]] ; then
    echo -n -e "Are you sure Budgie is not already installed? (y/N) \n==>" read banswer
    if [[ $banswer = "y" ]]; then
      sudo eopkg install -y budgie-desktop
    else
      echo "Get out of here!" && sleep 2 && exit
    fi
  fi
fi
if [[ $answer = 4 ]] ; then
  repos upate command for Ubuntu
  repos upgrade command for Ubuntu
  echo -n -e "Please choose your environment: \n [Wayland/Xorg]Gnome(1) \n [Xorg]OpenBox(2) \n [Wayland]Sway(3) \n [Wayland]Way Cooler(4) \n [Wayland/Xorg]KDE(5) \n [Xorg]Budgie(6) \n==>" read answer
  if [[ $answer = 1 ]] ; then
    Gnome
  fi
  if [[ $answer = 2 ]] ; then
    OpenBox
  fi
  if [[ $answer = 3 ]] ; then
    Sway
  fi
  if [[ $answer = 4 ]] ; then
    Way Cooler
  fi
  if [[ $answer = 5 ]] ; then
    KDE
  fi
  if [[ $answer = 6 ]] ; then
    Budgie
  fi
fi
if [[ $answer = 5 ]] ; then
  echo -n -e "Please understand that I don't know which package manager to use, I can only build Way Cooler from source, would you like to continue? (y/N) \n==>" read answer
  if [[ $answer = "y" ]] ; then
    curl https://way-cooler.github.io/way-cooler-release-i3-default.sh -sSLf | bash -s  way-cooler-bg  wc-grab  wc-lock
  else
    echo -n "Sorry not much I can do, bye." && sleep 2 && exit
  fi
fi
echo -n -e "Would you like to install additional packages? (y/N) \n==>" read panswer
if [[ $panswer = "N" ]] ; then
  echo "My work here is done, goodbye." && sleep 1 && exit
else
  echo -n -e "What distro were you using again? \n Arch linux(1) \n OpenSUSE(2) \n Solus(3) \n Ubuntu(4) \n Other(5) \n==>"read answer
    if [[ $answer = 1 ]] ; then
      arch additional packages
    fi
    if [[ $answer = 2 ]] ; then
      arch additional packages
    fi
    if [[ $answer = 3 ]] ; then
      arch additional packages
    fi
    if [[ $answer = 4 ]] ; then
      arch additional packages
    fi
    if [[ $answer = 5 ]] ; then
      echo "Sorry, I don't know what to do, exiting." && sleep 2 && exit
    fi
  fi
fi
