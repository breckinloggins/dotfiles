" Lots of stuff needs a POSIX shell to work in VIM
if &shell =~# 'fish$'
    set shell=sh
endif

filetype off
execute pathogen#infect()

set nocompatible

syntax on
filetype plugin indent on

set hidden
set number
set timeoutlen=450 	" Time to wait after ESC
set ts=4
set sw=4
set softtabstop=4
set expandtab

" These seem useful (from
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/#making-vim-more-useful)
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile

" Most of the time we want relative line numbers, but let's make a quick toggle
" for that
function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc
nnoremap <leader>n :call NumberToggle()<cr>

" Default leader is '\', doesn't work so well in OS X
let mapleader=","

" Sane search
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" Handle long lines in a sane way
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85

" Useful torture (for learning vim the hard way)
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" I don't need F1 for help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" This avoids the need to press shift to enter command mode
nnoremap ; :

" Store swap files in fixed location, not current directory.
set dir=~/.vimswap//,/var/tmp//,/tmp//,.

" NERDS!!!
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " Quit nerd tree if it's the only buffer left
let g:miniBufExplModSelTarget = 1 " Try to keep MBE from dumping crap into nerd tree

" MiniBufExplorer
map <Leader>t :MBEToggle<cr>
let g:miniBufExplMapWindowNavVim = 1 " Cycle through buffers with C-h C-l 

" Make Ack.vim use Ag for must go faster
let g:ackprg = 'ag --nogroup --nocolor --column'

let filename = '.gitignore'
if filereadable(filename)
    let igstring = ''
    for oline in readfile(filename)
        let line = substitute(oline, '\s|\n|\r', '', "g")
        if line =~ '^#' | con | endif
        if line == '' | con  | endif
        if line =~ '^!' | con  | endif
        if line =~ '/$' | let igstring .= "," . line . "*" | con | endif
        let igstring .= "," . line
    endfor
    let execstring = "set wildignore=".substitute(igstring, '^,', '', "g")
    execute execstring
endif

" Oooh, look at the pretty colors!
set background=dark
set t_Co=256
colorscheme solarized 

