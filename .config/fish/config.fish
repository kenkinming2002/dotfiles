#!/bin/fish

if type -q bass
  bass source /etc/profile
else
  echo (set_color red)"Warning:"(set_color white)" Bass is not installed. /etc/profile will not be sourced"
end

set PATH ~/.local/bin $PATH

alias ls='ls -lX --color=auto --group-directories-first'
umask 077

