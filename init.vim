" Environment settings
set noshowmode
set nu
set ts=4 sw=4 expandtab
set mouse=a

" Set colors
if $TERM == "xterm-256color"
    set t_Co=256
endif

" Highlight colors
hi Search cterm=NONE ctermfg=grey ctermbg=NONE

" Plugin Install
call plug#begin('~/.local/share/nvim/plugged')
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
call plug#end()

" Color Schemes
colorscheme dracula
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

" Open file tree with control n
map <C-n> :NERDTreeToggle<CR>

" [,][c][ ] comments / uncomments a line
let mapleader=","
set timeout timeoutlen=1500

" Bindings
" [,][v] splits screen vertically
noremap <leader>v :vsp<CR>
noremap <leader>h :sp<CR>
" hit s to replace tabs (for python nonsense)
noremap <leader>s :%s/\t/    /g<CR>


