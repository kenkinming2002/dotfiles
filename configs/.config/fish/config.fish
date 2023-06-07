#!/bin/fish

if type -q bass
  bass source /etc/profile
else
  echo (set_color red)"Warning:"(set_color white)" Bass is not installed. /etc/profile will not be sourced"
end

set PATH ~/.local/bin ~/.cargo/bin $PATH

export XDG_RUNTIME_DIR=/tmp/users/kenkwok
mkdir -p $XDG_RUNTIME_DIR
chmod 700 $XDG_RUNTIME_DIR

alias l='command ls -lvh --color=auto --ignore=lost+found'
alias t='tree'

umask 077

