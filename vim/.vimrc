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
let maplocalleader = "\\"

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
set shiftround

" Search

set ignorecase
set smartcase
set showmatch
set hlsearch

noremap <silent> <leader><space> :noh<cr>:call clearmatches()<cr>

" Use sane regexes

nnoremap / /\v
vnoremap / /\v

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

noremap <F5> :NERDTreeToggle<cr>
inoremap <F5> <esc>:NERDTreeToggle<cr>

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

" Markdown

augroup ft_markdown
   au!

   au BufNewFile,BufRead *.m*down setlocal filetype=markdown foldlevel=1

   " Use <localleader>1/2/3 to add headings.

   au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=:redraw<cr>
   au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-:redraw<cr>
   au Filetype markdown nnoremap <buffer> <localleader>3 mzI###<space><esc>`zllll
   au Filetype markdown nnoremap <buffer> <localleader>4 mzI####<space><esc>`zlllll
   au Filetype markdown nnoremap <buffer> <localleader>5 mzI#####<space><esc>`zllllll
   au Filetype markdown nnoremap <buffer> <localleader>6 mzI######<space><esc>`zlllllll
   au Filetype markdown nnoremap <buffer> <localleader>c o```<esc>yypO
augroup END

" http://blog.petrzemek.net/2016/04/06/things-about-vim-i-wish-i-knew-earlier/

function! DelEmptyLineAbove()
   if line(".") == 1
      return
   endif
   let l:line = getline(line(".") - 1)
   if l:line =~ '^s*$'
      let l:colsave = col(".")
      .-1d
      silent normal! <c-y>
      call cursor(line("."), l:colsave)
   endif
endfunction

function! AddEmptyLineAbove()
   let l:scrolloffsave = &scrolloff
   " Avoid jerky scrolling with ^E at top of window
   set scrolloff=0
   call append(line(".") - 1, "")
   if winline() != winheight(0)
      silent normal! <c-e>
   endif
   let &scrolloff = l:scrolloffsave
endfunction

nnoremap <silent> <left> <<
nnoremap <silent> <right> >>
nnoremap <silent> <up> <esc>:call DelEmptyLineAbove()<cr>
nnoremap <silent> <down> <esc>:call AddEmptyLineAbove()<cr>

vnoremap <silent> <left> <
vnoremap <silent> <right> >
vnoremap <silent> <up> <esc>:call DelEmptyLineAbove()<cr>gv
vnoremap <silent> <down> <esc>:call AddEmptyLineAbove()<cr>gv

" Move by virtual lines instead of physical lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Quickly select the text that was just pasted. This allows you to, e.g.,
" indent it after pasting.
noremap gV `[v`]

" Stay in visual mode when indenting. You will never have to run gv after
" performing an indentation.
vnoremap < <gv
vnoremap > >gv

" Make Y yank everything from the cursor to the end of the line. This makes Y
" act more like C or D because by default, Y yanks the current line (i.e. the
" same as yy).
noremap Y y$

" Make Ctrl-e jump to the end of the current line in the insert mode. This is
" handy when you are in the middle of a line and would like to go to its end
" without switching to the normal mode.
inoremap <C-e> <C-o>$

" Use jk to exit insert mode
inoremap jk <esc>
inoremap <esc> <nop>

nnoremap H 0
nnoremap L $
nnoremap 0 <nop>
nnoremap $ <nop>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

onoremap in( :<c-u>normal! f(vi(<cr>
onoremap il( :<c-u>normal! F)vi(<cr>
onoremap in' :<c-u>normal! f'vi'<cr>
onoremap il' :<c-u>normal! F'vi'<cr>
onoremap in[ :<c-u>normal! f[vi[<cr>
onoremap il[ :<c-u>normal! F]vi[<cr>
