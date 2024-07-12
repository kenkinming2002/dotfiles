#!/bin/fish
export VISUAL=nvim
export SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)

mkdir -p $XDG_RUNTIME_DIR
chmod 700 $XDG_RUNTIME_DIR

umask 077

