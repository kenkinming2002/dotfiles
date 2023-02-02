function fish_prompt
		# return status of last command
    and set retc green
    or set retc red

		# username
    echo -n (set_color -o yellow)$USER
		# separator
    echo -n (set_color white)@
		# hostname e.g. on SSH
    echo -n (set_color -o blue)(prompt_hostname)
    # separator
    echo -n (set_color -o white):
		# current working directory
    echo -n (set_color -o white)(prompt_pwd)

		# git info
    echo -n (set_color normal)(__fish_git_prompt)

		# job info
    echo
    for job in (jobs)
        echo (set_color brown)$job
    end

		# visual
    echo -n (set_color -o $retc)'$ '

    set_color normal
end
