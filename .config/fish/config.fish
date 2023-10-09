#!/bin/fish
set PATH ~/.local/bin ~/.cargo/bin $PATH

export SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)
export XDG_RUNTIME_DIR=/tmp/users/kenkwok

mkdir -p $XDG_RUNTIME_DIR
chmod 700 $XDG_RUNTIME_DIR

alias l='command ls -lvh --color=auto --ignore=lost+found'
alias t='tree'

umask 077

