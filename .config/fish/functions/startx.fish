function startx
	set -q XDG_CONFIG_HOME; or set -l XDG_CONFIG_HOME "$HOME/.config/"
  command startx "$XDG_CONFIG_HOME/X11/xinitrc"
end
