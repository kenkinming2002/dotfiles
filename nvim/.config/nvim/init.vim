"############################## Set Shell to sh ################################
if &shell =~# 'fish$'
	set shell=sh
endif

"############################ Initialize vim-plug #############################
call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'

Plug 'dag/vim-fish'
Plug 'dcharbon/vim-flatbuffers'
Plug 'cstrahan/vim-capnp'
Plug 'tikhomirov/vim-glsl'
Plug 'matze/vim-meson'

Plug 'vim-latex/vim-latex'

Plug 'scrooloose/nerdtree'
Plug 'Valloric/YouCompleteMe'

call plug#end()

"################################ Setup plugin #################################
"##### color scheme #####
colorscheme gruvbox
set background=dark

"##### NERDTree #####
let NERDTreeIgnore = ['\.hpp\.d$', '\.o$', '\.o\.d$','\.so$', '\.so\.d$','\.a$', '\.a\.d$']

"############################### Useful Keymap #################################
"##### Clear Highlight Search #####
noremap <Leader>c :noh<cr>

"##### NERDTree #####
nnoremap <Leader>n :NERDTree<cr>

"##### FZF #####
nnoremap <Leader>f :FZF -i<cr>

"##### YCM #####
nnoremap <Leader>g :YcmCompleter GoTo<cr>

"##### Search and replace words under cursor #####
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

"#################################### fzf ######################################

"################################ Preferences ##################################
set softtabstop=2 shiftwidth=2
set expandtab
set textwidth=80

set nowrap

augroup TrailingWhitespace
  autocmd BufWritePre * %s/\s\+$//e
augroup END

augroup Folds
  autocmd!
  autocmd BufWinLeave * mkview
  autocmd BufWinEnter * silent! loadview
augroup END
