set nocompatible
filetype off                  " required!

" https://github.com/gmarik/Vundle.vim.git
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'bufexplorer.zip'
Bundle 'vundle'
Bundle 'SuperTab-continued'
Bundle 'bufkill.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/nerdcommenter'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'garbas/vim-snipmate'
Bundle 'honza/vim-snippets'
Bundle 'vimwiki'
Bundle 'taglist.vim'

filetype plugin indent on


if has('win32') || has ("win16")
    let Tlist_Ctags_Cmd = 'c:\ctags58\ctags.exe'
endif

let Tlist_Use_Right_Window = 1
let Tlist_Auto_Open = 1
let Tlist_Show_One_File = 1

syntax on
set autochdir

colorscheme elflord

if has("gui_running")

    " Hide toolbar
    set guioptions-=T  "remove toolbar
    set guioptions-=r  "remove right scrollbar
    set guioptions-=L  "remove right scrollbar
    set guioptions-=M

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

set cscopequickfix=s-,c-,d-,i-,t-,e-
set cst " use cscope for ctrl=] (tag search)


map <f5> qq
map <f6> q
map <f7> @q
map <C-up> 5k
map <C-down> 5j
map <leader>nt :NERDTreeToggle<CR>
map <leader>tl :Tlist<CR>

set tags=./tags;/

set ch=2
set tabstop=4
set shiftwidth=4
set expandtab
set number
set nowrap


let g:vimwiki_list = [{'path': '~/vimwiki/'}]
let g:vimwiki_html_header_numbering=0/1/2/3/4

"" Search for and load cscope file, starting from the current directory, going up.
function! LoadCscope()

    let db = findfile("cscope.out", ".;")
    if (!empty(db))
        let path = strpart(db, 0, match(db, "/cscope.out$"))
        set nocscopeverbose " suppress 'duplicate conneciton' error
        exec "cs add " . db . " " . path
        set cscopeverbose
    endif

endfunction
au BufEnter /* call LoadCscope() "Call for each buffer that is loaded.
map <leader>lc :call LoadCscope()<CR>



" Make android source from within Vim.
function! MakeAndroid(...)
    let cwd = getcwd()
    :echo cwd
    :echo a:000
    :cd /mnt/android_hd
    "make
    exec "cd  " . cwd
endfunction
command! Mandy :call MakeAndroid() <CR>
map <leader>ma :Mandy<CR>

function! DevSetup()
  :NERDTreeToggle<CR>
  :Tlist
endfunction

cd ~
