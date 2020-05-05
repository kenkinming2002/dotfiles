#!/bin/fish

bass source /etc/profile

set PATH ~/.local/bin $PATH

alias ls='ls -lX --color=auto --group-directories-first'
umask 077

