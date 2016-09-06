" Configure terminal type
if !has('gui_running')
    set t_Co=256 " always assume that we in 256-color terminal
endif

" Tags files: search tags in closest git directory (up to 3 levels up)
"   and then in current directory
set tags=./.git/tags,./../.git/tags,./../../.git/tags,./.tags

" Configure gruvbox
let g:gruvbox_invert_selection=0 " change background for selection and not inversion

" Setup VUNDLE plugin manager
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

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

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

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
set backupdir=~/backups

" Set diff options: fill gaps with empty lines, ignore whitespace changes, use
" 3 lines of context
set diffopt=filler,iwhite,context:3

" Mappings
" TagBar:
nmap <F8> :TagbarToggle<CR>
