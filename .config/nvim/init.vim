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

"##### Search and replace words under cursor #####
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

"################################ Preferences ##################################
"##### Folds #####
augroup AutoSaveFolds
  autocmd!
  autocmd BufWinLeave * silent! mkview
  autocmd BufWinEnter * silent! loadview
augroup END

"##### Tab #####
set tabstop=2 softtabstop=2 shiftwidth=2 
set expandtab
set textwidth=80
