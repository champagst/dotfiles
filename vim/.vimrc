" General

set nocompatible
set encoding=utf-8		         " Use unicode
set laststatus=2		            " Always display the status line
set hidden			               " Hide buffer instead of closing it
set relativenumber		         " Show relative line numbers on the side
set number                       " Show the line we are on
set backspace=indent,eol,start	" Allow backspace in insert mode
set history=1000		            " Store more history
set ttyfast			               " Faster scrolling
set visualbell			            " No sounds
set autoread			            " Reload files changed outside vim
set whichwrap+=h,l,<,>		      " Add more keys that can move between lines

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

" Fugitive

nnoremap <leader>ga :Git add %:p<cr><cr>
nnoremap <leader>gaa :Git add --all<cr><cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gc :Gcommit -v -q<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gh :Glog<cr>:bot copen<cr>
nnoremap <leader>gH :Glog<cr>:set nofoldenable<cr>
nnoremap <leader>gps :Git push<cr>
nnoremap <leader>gpl :Git pull<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>g- :Git stash<cr>:e<cr>
nnoremap <leader>g+ :Git stash pop<cr>:e<cr>

" Remap arrow keys to be text movement keys

function! DelEmptyLineAbove() 
   if line(".") == 1 
      return 
   endif 
   let l:line = getline(line(".") - 1) 
   if l:line =~ '^s*$' 
      let l:colsave = col(".") 
      .-1d 
      silent normal! <C-y> 
      call cursor(line("."), l:colsave) 
   endif 
endfunction 

function! AddEmptyLineAbove() 
   let l:scrolloffsave = &scrolloff 
   " Avoid jerky scrolling with ^E at top of window 
   set scrolloff=0 
   call append(line(".") - 1, "") 
   if winline() != winheight(0) 
      silent normal! <C-e> 
   endif 
   let &scrolloff = l:scrolloffsave 
endfunction 

function! DelEmptyLineBelow() 
   if line(".") == line("$") 
      return 
   endif 
   let l:line = getline(line(".") + 1) 
   if l:line =~ '^s*$' 
      let l:colsave = col(".") 
      .+1d 
      '' 
      call cursor(line("."), l:colsave) 
   endif 
endfunction 

function! AddEmptyLineBelow() 
   call append(line("."), "") 
endfunction 

" Arrow key remapping: Up/Dn = move line up/dn; Left/Right = indent/unindent 
function! SetArrowKeysAsTextShifters() 
   " normal mode 
   nmap <silent> <Left> << 
   nmap <silent> <Right> >> 
   nnoremap <silent> <Up> <Esc> :call DelEmptyLineAbove()<CR> 
   nnoremap <silent> <Down> <Esc>:call AddEmptyLineAbove()<CR> 
   nnoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR> 
   nnoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR> 
   
   " visual mode 
   vmap <silent> <Left> < 
   vmap <silent> <Right> > 
   vnoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>gv 
   vnoremap <silent> <Down> <Esc>:call AddEmptyLineAbove()<CR>gv 
   vnoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>gv 
   vnoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>gv 
   
   " insert mode 
   imap <silent> <Left> <C-D> 
   imap <silent> <Right> <C-T> 
   inoremap <silent> <Up> <Esc>:call DelEmptyLineAbove()<CR>a 
   inoremap <silent> <Down> <Esc>:call AddEmptyLineAbove()<CR>a 
   inoremap <silent> <C-Up> <Esc>:call DelEmptyLineBelow()<CR>a 
   inoremap <silent> <C-Down> <Esc>:call AddEmptyLineBelow()<CR>a 
   
   " disable modified versions we are not using 
   nnoremap <S-Up>    <NOP> 
   nnoremap <S-Down>  <NOP> 
   nnoremap <S-Left>  <NOP> 
   nnoremap <S-Right> <NOP> 
   vnoremap <S-Up>    <NOP> 
   vnoremap <S-Down>  <NOP> 
   vnoremap <S-Left>  <NOP> 
   vnoremap <S-Right> <NOP> 
   inoremap <S-Up>    <NOP> 
   inoremap <S-Down>  <NOP> 
   inoremap <S-Left>  <NOP> 
   inoremap <S-Right> <NOP> 
endfunction 

call SetArrowKeysAsTextShifters()

" Move by virtual lines instead of physical lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
