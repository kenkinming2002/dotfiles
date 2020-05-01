# ls all files in a pretty way
function lsap
  ls -lA --color=always | grep -v '^l'; ls -lA --color=always | grep '^l' --color=never
end
