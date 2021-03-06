" Lots of stuff needs a POSIX shell to work in VIM
if &shell =~# 'fish$'
    set shell=sh
endif

filetype off
execute pathogen#infect()
execute pathogen#helptags()

set nocompatible

" Vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'Valloric/YouCompleteMe'

syntax on
filetype plugin indent on

" http://dysfunctionalprogramming.co.uk/blog/2013/08/15/fight-with-tools/
set hidden
set number
set timeoutlen=450 	" Time to wait after ESC
set ts=4
set sw=4
set softtabstop=4
set expandtab
set smarttab
set cindent
let indent_guides_enable_on_vim_startup = 1 

" These seem useful (from
" http://stevelosh.com/blog/2010/09/coming-home-to-vim/#making-vim-more-useful)
set encoding=utf-8
set scrolloff=14
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
set backupdir=~/.vimswap,.
set directory=~/.vimswap,.

" NERDS!!!
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif " Quit nerd tree if it's the only buffer left
let g:miniBufExplModSelTarget = 1 " Try to keep MBE from dumping crap into nerd tree

" MiniBufExplorer
map <Leader>t :MBEToggle<cr>
map <Leader>d :MBEbd<cr>
map <Leader>w :MBEbw<cr>
let g:miniBufExplMapWindowNavVim = 1 " Cycle through buffers with C-h C-l 
noremap <C-TAB>   :MBEbn<CR>
noremap <C-S-TAB> :MBEbp<CR>

" airline
"let g:airline#extensions#tabline#enabled = 1
"let g:airline_powerline_fonts = 1
"if !exists('g:airline_symbols')
"  let g:airline_symbols = {}
"endif
"let g:airline_symbols.space = "\ua0"
"set guifont=Source\ Code\ Pro\ for\ Powerline "make sure to escape the spaces in the name properly

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

" Folding by indent automatically (but preserves syntax folding if set on the
" mode)
" http://vim.wikia.com/wiki/Folding
augroup vimrc
  au BufReadPre * setlocal foldmethod=indent
  au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
augroup END

" YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:ycm_collect_identifiers_from_tags_files = 1

" Don't judge me
set mouse=n
set ttymouse=xterm2
set selectmode+=mouse

" Oooh, look at the pretty colors!
set background=dark
set t_Co=256
colorscheme solarized 

