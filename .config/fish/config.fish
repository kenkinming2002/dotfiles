#!/bin/fish

bass source /etc/profile

for d in (find $HOME/.local/bin -type d)
	set PATH $PATH $d
end

alias ls='ls -lX --color=auto --group-directories-first'
umask 077

