
    set nocompatible
    filetype off                  " required!


    " https://github.com/gmarik/Vundle.vim.git
    set rtp+=~/.vim/bundle/Vundle.vim/
    call vundle#begin()

    Plugin 'gmarik/Vundle.vim'
    Plugin 'bufexplorer.zip'
    Plugin 'jamessan/vim-gnupg'
    Plugin 'bufkill.vim'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'MarcWeber/vim-addon-mw-utils'
    Plugin 'tomtom/tlib_vim'
    Plugin 'vimwiki/vimwiki'
    if executable('ctags')
        Plugin 'taglist.vim'
    endif
    Plugin 'duracrisis/vim-fern-utils'
    Plugin 'mileszs/ack.vim'
    Plugin 'qfn'
    Plugin 'bling/vim-airline'
    Plugin 'Shougo/neocomplcache'
    if has('nvim')
        Plugin 'fboudreau/neovim-ebook-writter'
        Plugin 'fboudreau/neovim-project-plugin'
    endif
    Plugin 'Shougo/neosnippet'
    Plugin 'Shougo/neosnippet-snippets'
    Plugin 'JamshedVesuna/vim-markdown-preview'
    Plugin 'joshdick/onedark.vim'
    Plugin 'wincent/command-t'
    Plugin 'tpope/vim-fugitive'
    Plugin 'vim-scripts/vim-auto-save'
    Plugin 'MattesGroeger/vim-bookmarks'
    Plugin 'tpope/vim-vinegar'
    Plugin 'rbgrouleff/bclose.vim'
    Plugin 'francoiscabrol/ranger.vim'

    call vundle#end()


    filetype plugin indent on

    "setglobal cm=blowfish2 


    if has('win32') || has ("win16")
        let Tlist_Ctags_Cmd = 'c:\ctags58\ctags.exe'
    endif

    let Tlist_Use_Right_Window = 1
    let Tlist_Auto_Open = 0
    let Tlist_Show_One_File = 1

    let g:tlist_markdown_settings = 'markdown;h:Headlines'


    syntax on
    set autochdir

    colorscheme elflord
    "olorscheme onedark

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

    set mouse=a

    set cscopequickfix=s-,c-,d-,i-,t-,e-,g-,f-
    set cscopetag
    set cst " use cscope for ctrl=] (tag search)
    set csto=0


    set tags=./tags;/

    set ch=2
    set tabstop=4
    set shiftwidth=4
    set expandtab
    set number
    set nowrap

    "autocmd FileType vimwiki let g:UltiSnipsExpandTrigger="<c-p>"

    let g:vimwiki_table_mappings = 0

    let g:ranger_choice_file = '/tmp/ranger-choice.tmp'
    let g:vimwiki_list = [{'path': '/mnt/ienso/shared/Fernand/vimwiki/', 'syntax': 'markdown'},{'path': "~/ocean/vimwiki"}]
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

    " bind K to grep word under cursor
    nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
    "nnoremap Q :NERDTreeClose \| qa<CR>
    nnoremap Q :qa<CR>
    nnoremap W :Ack "\b<C-R><C-W>\b"<CR>:cw<CR>

    " Plugin key-mappings.
    " Note: It must be "imap" and "smap".  It uses <Plug> mappings.
    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
    xmap <C-k>     <Plug>(neosnippet_expand_target)

    nnoremap <C-h> <C-w>h
    nnoremap <C-j> <C-w>j
    nnoremap <C-k> <C-w>k
    nnoremap <C-l> <C-w>l


    let g:netrw_usetab=1

    "autocmd StdinReadPre * let s:std_in=1
    "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    "autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

    set autoread
    au CursorHold,CursorHoldI * checktime

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

    "let g:netrw_banner = 0
    "let g:netrw_liststyle = 3
    "let g:netrw_browse_split = 4
    "let g:netrw_altv = 1
    "let g:netrw_winsize = 15

    let g:ranger_replace_netrw = 1 " open ranger when vim open a directory

    nmap cp : let @* = expand("%:p")<CR>

    " let sessionoptions=

    nmap pm :silent call PreviewMarkdown()<CR>

    function! PreviewMarkdown()
        :!pandoc -o /tmp/md_preview.html %
        :!xdg-open /tmp/md_preview.html
    endfunction

autocmd BufEnter *.cpp :setlocal cindent cino=j1,(0,ws,Ws
set spell
