#!/bin/bash
#|---/ /+-----------------------------------+---/ /|#
#|--/ /-| Script to install aur helper, paru |--/ /-|#
#|/ /---+-----------------------------------+/ /---|#

source global_fn.sh
if [ $? -ne 0 ] ; then
    echo "Error: unable to source global_fn.sh, please execute from $(dirname $(realpath $0))..."
    exit 1
fi

if pkg_installed paru
then
    exit 0
fi

if [ -d ~/Clone ]
then
    echo "~/Clone directory exists..."
    rm -rf ~/Clone/paru
else
    mkdir ~/Clone
    echo "~/Clone directory created..."
fi

if pkg_installed git
then
    git clone https://aur.archlinux.org/paru.git ~/Clone/paru
else
    echo "git dependency is not installed..."
    exit 1
fi

cd ~/Clone/paru
makepkg -si

if [ $? -eq 0 ]
then
    cd ~
    echo "aur helper installed, yayyy..."
    exit 0
else
    cd ~
    echo "paru installation failed..."
    exit 1
fi

