#!/bin/sh

info() {
  printf "\r\n [ \033[00;34m..\033[0m ] $1\r\n"
}

user() {
  printf "\r\n [ \033[0;33m?\033[0m ] $1"
}

success() {
  printf "\r\033[2K [ \033[00;32mOK\033[0m ] $1\n"
}

fail() {
  printf "\r\033[2K [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit $?
}

symlinker() {
  info 'Symlinking dotfiles'

  local overwrite=true overwrite_all=true backup_all=false skip_all=false

  for file in $(find -H "$(pwd)" -maxdepth 3 -name '*.symlink'); do
    local dest="$HOME/.$(basename "${file%.*}")"

    ln -sf "$file" "$dest"
    success "linked $file to $dest"
  done
}
