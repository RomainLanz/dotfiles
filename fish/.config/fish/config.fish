source ~/.asdf/asdf.fish

set fish_greeting

set -gx GPG_TTY (tty)
set -gx HOMEBREW_PREFIX "/opt/homebrew";
set -gx HOMEBREW_CELLAR "/opt/homebrew/Cellar";
set -gx HOMEBREW_REPOSITORY "/opt/homebrew";
set -gx DOCKER_HOST "unix://$HOME/.colima/default/docker.sock"
set -gx TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE "/var/run/docker.sock"

set -q PATH; or set PATH ''; set -gx PATH "/opt/homebrew/bin" "/opt/homebrew/sbin" $PATH;
set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/opt/homebrew/share/man" $MANPATH;
set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/opt/homebrew/share/info" $INFOPATH;

# Go
set -gx PATH "/Users/romainlanz/go/bin" $PATH;

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

alias k "kubectl"
alias kcc "kubectl config current-context"
alias kuc "kubectl config use-context"
