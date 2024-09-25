set nocompatible
filetype off                  " required!


" I use vim-plug: https://github.com/junegunn/vim-plug
call plug#begin()

"Plug 'neoclide/coc.nvim'
Plug 'stevearc/oil.nvim'
Plug 'folke/zen-mode.nvim'
Plug 'aklt/plantuml-syntax'
Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'img-paste-devs/img-paste.vim'
Plug 'jlanzarotta/bufexplorer'
Plug 'jamessan/vim-gnupg'
Plug 'qpkorr/vim-bufkill'
Plug 'scrooloose/nerdcommenter'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'vimwiki/vimwiki'
if executable('ctags')
Plug 'yegappan/taglist'
endif
Plug 'duracrisis/vim-fern-utils'
Plug 'mileszs/ack.vim'
Plug 'bling/vim-airline'
if has('nvim')
Plug 'fboudreau/neovim-project-plugin'
endif
Plug 'SirVer/ultisnips'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'vim-scripts/vim-auto-save'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'rbgrouleff/bclose.vim'
"Plug 'rafaqz/ranger.vim'

call plug#end()


filetype plugin indent on

if has('win32') || has ("win16")
let Tlist_Ctags_Cmd = 'c:\ctags58\ctags.exe'
endif

let Tlist_Use_Right_Window = 1
let Tlist_Auto_Open = 0
let Tlist_Show_One_File = 1

let g:tlist_markdown_settings = 'markdown;h:Headlines'

syntax on
set autochdir

:colorscheme industry

if has("gui_running")

" Hide toolbar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right scrollbar
set guioptions-=L  "remove right scrollbar
set guioptions-=m
set tb=

" Set Editor Font
if exists(':GuiFont')
    " Use GuiFont! to ignore font errors
    GuiFont DejaVu Sans Mono:h20
endif

" Enable popup menu
set mousemodel=popup

" Add CSCOPE commands to popup menu
amenu PopUp.cscope.Find\ Symbol :cs f s <cword><CR>
amenu PopUp.cscope.Find\ Callers :cs f c <cword><CR>
amenu PopUp.cscope.Find\ Files :cs f f <cword><CR>

endif

set mouse=a

"set cscopequickfix=s-,c-,d-,i-,t-,e-,g-,f-
"set cscopetag
"set cst " use cscope for ctrl=] (tag search)
"set csto=0

set tags=./tags;/

set ch=2
set tabstop=4
set shiftwidth=4
set expandtab
set number
set nowrap

let g:vimwiki_table_mappings = 0

let g:vimwiki_list = [{'path': '~/vimwiki', 'syntax' : 'markdown'}, {'path': "~/ocean/vimwiki", 'syntax' : 'markdown'}]
let g:vimwiki_html_header_numbering=0/1/2/3/4

autocmd FileType vimwiki setlocal tw=79
autocmd FileType vimwiki setlocal noswapfile
autocmd FileType vimwiki setlocal spell
autocmd FileType markdown setlocal spell
autocmd FileType mail setlocal spell

" Move quickfix window to bottom. Works well when Tlist is open.
autocmd FileType qf wincmd J

" The Silver Searcher
if executable('ag')
" Use ag over grep
set grepprg=ag\ --nogroup\ --nocolor

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0
endif

nnoremap Q :qa<CR>
nnoremap W :Ack "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap GitkFile :!gitk %&<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


let g:netrw_usetab=1

set autoread

set path=.,*,,

highlight Normal ctermbg=none
highlight NonText ctermbg=none

" vim -b : edit binary using xxd-format!
augroup Binary
au!
au BufReadPre  *.bin let &bin=1
au BufReadPost *.bin if &bin | %!xxd
au BufReadPost *.bin set ft=xxd | endif
au BufWritePre *.bin if &bin | %!xxd -r
au BufWritePre *.bin endif
au BufWritePost *.bin if &bin | %!xxd
au BufWritePost *.bin set nomod | endif
augroup END

set nobackup
set noswapfile

let g:auto_save = 1  " enable AutoSave on Vim startup

if has('nvim')
" Allows pressing Esc to exit insert mode when in terminal (:h term)
tnoremap <Esc> <C-\><C-n>
endif

nmap cp : let @* = expand("%:p")<CR>

nmap pm :silent call PreviewMarkdown()<CR>

function! PreviewMarkdown()
:!pandoc -o /tmp/md_preview.html %
:!xdg-open /tmp/md_preview.html
endfunction

autocmd BufEnter *.cpp :setlocal cindent cino=j1,(0,ws,Ws
set spell

autocmd FileType gnupg :let g:auto_save = 0

set grepprg="ag --vimgrep $* set grepformat=%f:%l:%c:%m"
command! Make :silent make

function! SlideHeader()
   let lines = [ "---",
               \ "title: \"\"",
               \ "subtitle: \"\"",
               \ "author: Fernand Boudreau<br><fernand.boudreau@ienso.com>",
               \ "date: ",
               \ "description: |",
               \ "background-image:",
               \ "---"]

    call append("^", lines)
endfunction


function! ShowSlides()
   :! pandoc -s -f markdown -t revealjs --slide-level 3 -o /tmp/pandoc_reveal_tmp.html "%"
   :! google-chrome-beta /tmp/pandoc_reveal_tmp.html
endfunction

command! Slides :call ShowSlides()

set clipboard+=unnamedplus

noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

nmap <leader>zm :ZenMode<CR>

" Markdown image page plugin settings
let g:mdip_imgdir = 'img'
let g:mdip_imgname = 'image'

autocmd FileType vimwiki let g:PasteImageFunction = 'g:MarkdownPasteImage'
autocmd FileType vimwiki,markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>

lua require("oil").setup()
map <c-n> :Oil<CR>
