" Configure terminal type
if !has('gui_running')
    set t_Co=256 " always assume that we in 256-color terminal
endif

" Tags files: search tags in closest git directory (up to 3 levels up)
"   and then in current directory
set tags=./.git/tags,./../.git/tags,./../../.git/tags,./.tags

" Configure gui
if has("gui_running")
    set guioptions-=m  "remove menu bar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right-hand scroll bar
    set guioptions-=L  "remove left-hand scroll bar
    set guioptions-=e  "make gui tab line to look like console tabs
endif
set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10

" Configure gruvbox
set background=dark
let g:gruvbox_invert_selection=0 " change background for selection and not inversion
let g:gruvbox_contrast_dark="medium"

if !has('gui_running')
    let g:gruvbox_termcolors=16 " pick-up terminal's own colorscheme (instead of 256-colors scheme)
endif

" Setup VUNDLE plugin manager
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Gruvbox - color scheme and other stuff
Plugin 'morhetz/gruvbox'

" Lightline - status line plugin
Plugin 'itchyny/lightline.vim'

" sneak - jump to 'xy' via sxy
Plugin 'justinmk/vim-sneak'

" CtrlP - famous file search plugin
Plugin 'kien/ctrlp.vim'

" Tagbar - window of dynamic (in-memory) tag list
Plugin 'majutsushi/tagbar'

" Enhanced json highlighting
Plugin 'elzr/vim-json'

" incrementally highlights ALL pattern matches (+some features)
Plugin 'haya14busa/incsearch.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Enable syntax highlighting
syntax enable

" Use Gruvbox color scheme
colorscheme gruvbox
" Make status line and tabline to always appear
set laststatus=2
set showtabline=2
" Do not show mode, since we use Lightline
set noshowmode
" Configure Lightline
let g:lightline = {
    \ 'colorscheme': 'jellybeans',
    \ 'component': {
    \   'readonly': '%{&readonly?"\ue0a2":""}',
    \ },
    \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
    \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
    \}

" Quit on 'q' (as in less)
noremap q :q<CR>

" Allow move from unsaved buffer
set hidden

" treat .aliases as 'bash' file type
au BufNewFile,BufRead .aliases call SetFileTypeSH("bash")

" Show line numbers
set number

" Tab configuration: tab symbol shown as 4 spaces; <TAB> aligns to 4 columns;
" <TAB> produces 4 spaces; shift ('<', '>') shift 4 columns
:set tabstop=4 expandtab softtabstop=4 shiftwidth=4

"" Open buffer in same tab
"set switchbuf=usetab

" Don't use swp files, define special directory for backup files
set noswapfile
set backupdir=~/backup

" Set diff options: fill gaps with empty lines, ignore whitespace changes, use
" 3 lines of context
set diffopt=filler,iwhite,context:3

" Mappings
" TagBar:
nmap <F8> :TagbarToggle<CR>
" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Configure incsearch to automatically turn off highlight
set hlsearch
let g:incsearch#auto_nohlsearch = 1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
