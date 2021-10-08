# Color Scheme
set fish_color_autosuggestion FFC473
set fish_color_cancel \x2dr
set fish_color_command FF9400
set fish_color_comment A63100
set fish_color_cwd green
set fish_color_cwd_root red
set fish_color_end FF4C00
set fish_color_error FFDD73
set fish_color_escape bryellow\x1e\x2d\x2dbold
set fish_color_history_current \x2d\x2dbold
set fish_color_host normal
set fish_color_host_remote yellow
set fish_color_match \x2d\x2dbackground\x3dbrblue
set fish_color_normal normal
set fish_color_operator bryellow
set fish_color_param FFC000
set fish_color_quote BF9C30
set fish_color_redirection BF5B30
set fish_color_search_match bryellow\x1e\x2d\x2dbackground\x3dbrblack
set fish_color_selection white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
set fish_color_status red
set fish_color_user brgreen
set fish_color_valid_path \x2d\x2dunderline
set fish_greeting Welcome\x20to\x20fish\x2c\x20the\x20friendly\x20interactive\x20shell
set fish_pager_color_completion \x1d
set fish_pager_color_description B3A06D\x1eyellow
set fish_pager_color_prefix white\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
set fish_pager_color_progress brwhite\x1e\x2d\x2dbackground\x3dcyan

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
