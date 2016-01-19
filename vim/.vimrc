" General

set nocompatible
set encoding=utf-8		" Use unicode
set laststatus=2		" Always display the status line
set hidden			" Hide buffer instead of closing it
set relativenumber		" Show relative line numbers on the side
set backspace=indent,eol,start	" Allow backspace in insert mode
set history=1000		" Store more history
set ttyfast			" Faster scrolling
set visualbell			" No sounds
set autoread			" Reload files changed outside vim
set whichwrap+=h,l,<,>		" Add more keys that can move between lines

" Key mappings

let mapleader = ","

" Load plugins

source $VIM/bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect('bundle/{}', '$VIM/bundle/{}')

" Swap file and backups

set backup
set noswapfile

set undodir=$VIM/tmp/undo//     " undo files
set backupdir=$VIM/tmp/backup// " backups
set directory=$VIM/tmp/swap//   " swap files

if !isdirectory(expand(&undodir))
   call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
   call mkdir(expand(&backupdir), "p")
endif
if !isdirectory(expand(&directory))
   call mkdir(expand(&directory), "p")
endif

" Indentation

set autoindent
set smartindent
set smarttab
set shiftwidth=3
set softtabstop=3
set tabstop=3
set expandtab

" Search

set ignorecase
set smartcase
set showmatch
set hlsearch

noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>

" Buffers

nnoremap <C-l> :bnext<cr>
nnoremap <C-h> :bprevious<cr>

" Colors

syntax on 
set t_Co=256
set background=dark
colorscheme badwolf
let g:badwolf_tabline=2

" Enable loading the plugin/indent files for specific file types

filetype plugin indent on

" NERDTree

nmap <leader>n :NERDTreeToggle<cr>
let NERDTreeShowHidden=1

" CtrlP

nmap <leader>m :CtrlP<cr>
