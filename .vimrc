set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'bufexplorer.zip'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'taglist.vim'
Bundle 'vimwiki'
Bundle 'bufkill.vim'

set autoindent
set expandtab
set nowrap
syntax on
filetype plugin indent on
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

map <F5> qq
map <F6> q
map <F7> @q
map <leader>nt :NERDTreeToggle<CR>
map <leader>tl :Tlist<CR>

