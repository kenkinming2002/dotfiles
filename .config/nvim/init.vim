"############################## Set Shell to sh ################################
if &shell =~# 'fish$'
	set shell=sh
endif

"############################ Initialize vim-plug #############################
call plug#begin('~/.local/share/nvim/plugged')

Plug 'dag/vim-fish'

Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'dcharbon/vim-flatbuffers'
Plug 'cstrahan/vim-capnp'
Plug 'tikhomirov/vim-glsl'
Plug 'matze/vim-meson'

Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'

Plug 'drmikehenry/vim-headerguard'
Plug 'Valloric/YouCompleteMe'

call plug#end()

"################################ Setup plugin #################################
"##### vim-latex #####
filetype plugin on
set shellslash
filetype indent on
let g:tex_flavor='latex'

"##### color scheme #####
colorscheme gruvbox
set background=dark

"##### fuzzy file finder #####
nnoremap <leader>o :FZF<cr>

"############################### Useful Keymap #################################
"##### Search and replace words under cursor #####
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

"##### centre comment #####
function! MakeHeading()
  let comment_char = split(&commentstring, "%s")[0]
  if len(comment_char) == 0
    let comment_char = "#" " default to # for comment sign
  endif

  let current_line = getline(".")
  let words = substitute(current_line, '^\(' . comment_char . '\)\?#* *', "", "") " remove preceding # sign and space and comment char
  let words = substitute(words       , ' \+#\+$'                    , "", "") " remove following # sign and space
  let words = substitute(words       , '\n'                         , "", "g") " remove newline

  let words_width = len(words)
  let length_surround = ( &textwidth - words_width ) / 2
  let comment_begin = comment_char . repeat('#', length_surround - 2) . ' '
  let comment_end   = ' ' . repeat('#', length_surround - 1)
  let heading = comment_begin . words . comment_end 
  
  set paste
  execute "normal! S\<esc>0i" . heading
  set nopaste
endfunction

function! MakeSubHeading()
  let comment_char = split(&commentstring, "%s")[0]
  if len(comment_char) == 0
    let comment_char = "#" " default to # for comment sign
  endif

  let current_line = getline(".")
  let words = substitute(current_line, '^\(' . comment_char . '\)\?#* *', "", "") " remove preceding # sign and space and comment char
  let words = substitute(words       , ' \+#\+$'                    , "", "") " remove following # sign and space
  let words = substitute(words       , '\n'                         , "", "g") " remove newline

  let words_width = len(words)
  let length_surround = ( 80 - words_width ) / 2
  let comment_begin = comment_char . repeat('#', 5) . " "
  let comment_end   = " " . repeat('#', 5)
  let heading = comment_begin . words . comment_end 
  
  set paste
  execute "normal! S\<esc>0i" . heading
  set nopaste
endfunction

nnoremap <leader>H :call MakeHeading()<CR>
nnoremap <leader>h :call MakeSubHeading()<CR>

"################################ Preferences ##################################
"##### Tab #####
set tabstop=2 softtabstop=2 shiftwidth=2 
set expandtab
set textwidth=80
