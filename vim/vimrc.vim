" Start pathogen
"filetype off
"call pathogen#infect()
"filetype plugin indent on

set nocompatible
set encoding=UTF-8
"set t_Co=256
set background=dark
set title
"colorscheme candycode 
"colorscheme darkblack
syntax on  
set number " Line numbering on

" Tabs and Indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab " Use spaces instead of tabs
set autoindent

set ignorecase
set smartcase

set incsearch
set showmatch
set hlsearch

set showmode
set showcmd
set wildmenu
set wildmode=list:longest
set hidden
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set statusline=%f%m%r%h%w\ %=\ [%l:%v]\ %y\ [%{(&fenc==\"\"?&enc:&fenc)}]\ [%{&ff}]
set laststatus=2
set paste
set pastetoggle=<F6>

" Source files in conf.d directory
let vimrc_dir = fnamemodify(resolve($MYVIMRC), ':h')
let confd_dir = vimrc_dir . '/conf.d'
for file in split(glob(confd_dir . '/*.vim'), '\n')
    execute 'source' . file
endfor
