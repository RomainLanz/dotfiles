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

if [[ ! $(pwd) == "$HOME/.dotfiles" ]]; then
  info 'Symlinking dotfile folder'
  ln -sf $(pwd) "$HOME/.dotfiles"
  success "linked $(pwd) to $HOME/.dotfiles"
fi

symlinker() {
  info 'Symlinking dotfiles'

  local overwrite=true overwrite_all=true backup_all=false skip_all=false

  for file in $(find -H "$(pwd)" -maxdepth 5 -name '*.sym'); do
    local path=$(grealpath --relative-to=$PWD $file)
    mkdir -p "$HOME/$(dirname $path)"
    local dest="$HOME/$(dirname $path)/$(basename "${file%.*}")"

    ln -sf "$file" "$dest"	
    success "linked $file to $dest"
  done
}

symlinker

