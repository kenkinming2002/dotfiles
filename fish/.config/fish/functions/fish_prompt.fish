## GIT
# git branch color
set __fish_git_prompt_color_branch yellow

# git dirty state
set __fish_git_prompt_showdirtystate 'yes'

# dirty state
set __fish_git_prompt_color_dirtystate red
set __fish_git_prompt_char_dirtystate '●'

# staged state
set __fish_git_prompt_color_stagedstate yellow
set __fish_git_prompt_char_stagedstate '●'

# invalid state
set __fish_git_prompt_color_invalidstate magenta
set __fish_git_prompt_char_invalidstate '●'

# git untracked file
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_color_untrackedfiles red
set __fish_git_prompt_char_untrackedfiles '●'

# git upstream
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_upstream yellow

# git clean state
set __fish_git_prompt_show_informative_status
set __fish_git_prompt_color_cleanstate green
set __fish_git_prompt_char_cleanstate '●'

## PWD
set fish_prompt_pwd_dir_length 0

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
