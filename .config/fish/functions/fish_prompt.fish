function fish_prompt
  and set retc green
  or set retc red

  echo -n (set_color -o yellow)$USER
  echo -n (set_color white)@
  echo -n (set_color -o blue)(prompt_hostname)
  echo -n (set_color -o white):
  echo -n (set_color -o white)(prompt_pwd)
  echo -n (set_color normal)(__fish_git_prompt)

  echo
  for job in (jobs)
    echo (set_color brown)$job
  end

  echo -n (set_color -o $retc)'$ '

  set_color normal
end
