#!/bin/fish

if type -q bass
  bass source /etc/profile
else
  echo (set_color red)"Warning:"(set_color white)" Bass is not installed. /etc/profile will not be sourced"
end

set PATH ~/.local/bin $PATH

alias l='command ls -lh --sort=extension --group-directories-first --color=auto'
alias t='tree'

umask 077

