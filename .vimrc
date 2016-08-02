set nocompatible
filetype off                  " required!

" https://github.com/gmarik/Vundle.vim.git
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'bufexplorer.zip'
Plugin 'jamessan/vim-gnupg'
"Plugin 'SuperTab--Van-Dewoestine'
Plugin 'bufkill.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
"Plugin 'garbas/vim-snipmate'
Plugin 'honza/vim-snippets'
Plugin 'vimwiki/vimwiki'
Plugin 'taglist.vim'
Plugin 'duracrisis/vim-fern-utils'
Plugin 'mileszs/ack.vim'
Plugin 'qfn'
Plugin 'Shougo/vimshell.vim'
Plugin 'SirVer/ultisnips'



call vundle#end()

filetype plugin indent on

setglobal cm=blowfish2 

if has('win32') || has ("win16")
    let Tlist_Ctags_Cmd = 'c:\ctags58\ctags.exe'
endif

let Tlist_Use_Right_Window = 1
let Tlist_Auto_Open = 0
let Tlist_Show_One_File = 1

syntax on
set autochdir

colorscheme elflord

if has("gui_running")

    " Hide toolbar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right scrollbar
    set guioptions-=L  "remove right scrollbar
    set guioptions-=m

    set tb=
    if has("gui_win32")
        set guifont=Courier\ New:h12:cANSI
    endif

    " Enable popup menu
    set mousemodel=popup

    " Add CSCOPE commands to popup menu
    amenu PopUp.cscope.Find\ Symbol :cs f s <cword><CR>
    amenu PopUp.cscope.Find\ Callers :cs f c <cword><CR>
    amenu PopUp.cscope.Find\ Files :cs f f <cword><CR>

endif

set cscopequickfix=s-,c-,d-,i-,t-,e-,g-,f-
set cst " use cscope for ctrl=] (tag search)


set tags=./tags;/

set ch=2
set tabstop=4
set shiftwidth=4
set expandtab
set number
set nowrap

let g:UltiSnipsExpandTrigger="<c-p>"

let g:vimwiki_list = [{'path': '/mnt/ienso/shared/Fernand/vimwiki/'},{'path': "~/ocean/vimwiki"}]
let g:vimwiki_html_header_numbering=0/1/2/3/4
autocmd FileType vimwiki setlocal tw=79
autocmd FileType vimwiki setlocal noswapfile
