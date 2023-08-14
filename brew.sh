#!/bin/sh

source helpers.sh

echo 'Welcome to @romainlanz installation script'
echo 'This script is used to install a lot of dependencies and application'
echo 'to setup my computer.'

user 'Are you sure to continue? (y/N) '
read -n 1 choice
choice=${choice:-N}
printf "\n"

if [[ $choice =~ ^[nN]$ ]]; then
  exit $?
fi

sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


if test ! $(which brew); then
  info 'Installing Homebrew for you'
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh | bash
fi

info "Making sure we’re using the latest Homebrew"
brew update

info 'Upgrade any already-installed formulae'
brew upgrade


if test ! $(which fish); then
  info 'Installing fish shell'
  brew install fish > /dev/null
  echo $(which fish) >> /etc/shells
  chsh -s $(which fish)
  success 'Done'
fi

info 'Installing GNU core utilities (those that come with OS X are outdated)'
brew install coreutils > /dev/null
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum
success 'Done'

info "Installing some other useful utilities like 'sponge'"
brew install moreutils > /dev/null
success 'Done'

info "Installing GNU 'find', 'locate', 'updatedb', and 'xargs', 'g'-prefixed"
brew install findutils > /dev/null
success 'Done'

info "Installing GNU 'sed', overwriting the built-in 'sed'"
brew install gnu-sed > /dev/null
success 'Done'

info 'Installing dev tools'
brew install nvim > /dev/null
brew install git > /dev/null
brew install fzf > /dev/null
brew install fd > /dev/null
brew install lazygit > /dev/null
brew install ripgrep > /dev/null
success 'Done'

info 'Installing some CTF tools'
brew install aircrack-ng > /dev/null
brew install bfg > /dev/null
brew install binutils > /dev/null
brew install binwalk > /dev/null
brew install cifer > /dev/null
brew install dex2jar > /dev/null
brew install dns2tcp > /dev/null
brew install ettercap > /dev/null
brew install fcrackzip > /dev/null
brew install foremost > /dev/null
brew install hashpump > /dev/null
brew install hydra > /dev/null
brew install john > /dev/null
brew install knock > /dev/null
brew install netpbm > /dev/null
brew install nmap > /dev/null
brew install pngcheck > /dev/null
brew install radare2 > /dev/null
brew install socat > /dev/null
brew install sqlmap > /dev/null
brew install tcpflow > /dev/null
brew install tcpreplay > /dev/null
brew install tcptrace > /dev/null
brew install ucspi-tcp > /dev/null
brew install xz > /dev/null
success 'Done'

info 'Installing other useful binaries'
brew install pinentry > /dev/null
brew install ack > /dev/null
brew install wget > /dev/null
brew install bat > /dev/null
brew install imagemagick > /dev/null
brew install ffmpeg > /dev/null
brew install yt-dlp > /dev/null
success 'Done'

info 'Remove outdated versions from the cellar'
brew cleanup > /dev/null

info 'Installing asdf'
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0
mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add ruby https://github.com/asdf-vm/asdf-ruby.git
asdf plugin-add python
info 'Done'

user 'Do you want to install applications? (y/N) '
read -n 1 choice
choice=${choice:-N}
printf "\n"

if [[ $choice =~ ^[nN]$ ]]; then
  exit $?
fi

info 'Installing Raycast'
brew install raycast > /dev/null
success 'Done'

info 'Installing Kitty'
brew install kitty > /dev/null
success 'Done'

info 'Installing AppCleaner'
brew install appcleaner > /dev/null
success 'Done'

info 'Installing Arc Browser'
brew install arc > /dev/null
success 'Done'

info 'Installing Übersicht'
brew install ubersicht > /dev/null
source ubersicht/bootstrap
success 'Done'

info 'Installing mpv'
brew install mpv > /dev/null
success 'Done'

info 'Installing cryptomator'
brew install cryptomator > /dev/null
success 'Done'

info 'Installing Bartender'
brew install bartender > /dev/null
success 'Done'

info 'Installing BlockBlock'
brew install blockblock > /dev/null
success 'Done'

info 'Installing Cleanshot X'
brew install cleanshot > /dev/null
success 'Done'

info 'Installing Cyberduck'
brew install cyberduck > /dev/null
success 'Done'

info 'Installing DaisyDisk'
brew install daisydisk > /dev/null
success 'Done'

info 'Installing Discord'
brew install discord > /dev/null
success 'Done'

info 'Installing Figma'
brew install figma > /dev/null
success 'Done'

info 'Installing HyperKey'
brew install hyperkey > /dev/null
success 'Done'

info 'Installing JetBrains Toolbox'
brew install jetbrains-toolbox > /dev/null
success 'Done'

info 'Installing KnockKnock'
brew install knockknock > /dev/null
success 'Done'

info 'Installing Little Snitch'
brew install little-snitch > /dev/null
success 'Done'

info 'Installing Numi'
brew install numi > /dev/null
success 'Done'

info 'Installing Table Plus'
brew install tableplus > /dev/null
success 'Done'

info 'Installing TopNotch'
brew install topnotch > /dev/null
success 'Done'
