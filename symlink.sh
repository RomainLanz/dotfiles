#!/bin/sh

source helpers.sh

echo 'This script will symlink my dotfiles to their correct location'

user 'Are you sure to continue? (y/N) '
read -n 1 choice
choice=${choice:-N}
printf "\n"

if [[ $choice =~ ^[nN]$ ]]; then
  exit $?
fi

stow gnupg
stow asdf
stow git
stow nvim
stow fish
stow kitty
stow omf
