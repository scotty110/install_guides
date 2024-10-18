" Set Indent Correctly
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
"set smartindent

" Other
set exrc
set guicursor=
set relativenumber
set nu
set hidden "Allows for fast swapping, keeps buffer in ram
set noerrorbells
set nowrap
set scrolloff=6

" Columns to let know when going over 80 chars
set signcolumn=yes
set colorcolumn=80

" How do you keep history
set noswapfile
set nobackup
set undodir=~/.vim/undodir "need to make dir when installing
set undofile

" Search
set nohlsearch
set incsearch

" More spacing for messages
set cmdheight=2

" Installed Color Scheme above
set background=dark

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

let mapleader = " "
"  nnoremap <Leader>ps : command
