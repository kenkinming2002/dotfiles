#!/bin/fish
set PATH ~/.local/bin ~/.cargo/bin ~/.local/share/gem/ruby/3.0.0/bin $PATH

export VISUAL=nvim
export SSH_AUTH_SOCK=(gpgconf --list-dirs agent-ssh-socket)

mkdir -p $XDG_RUNTIME_DIR
chmod 700 $XDG_RUNTIME_DIR

alias l='command ls -lvh --color=auto --ignore=lost+found'
alias t='tree'

umask 077

