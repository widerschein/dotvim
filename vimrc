syntax on
filetype plugin indent on
set nocompatible

set shell=/bin/bash

set termguicolors



"-------------- Basics  -----------------------

"launch build script
set makeprg=~/bin_dev/optibuild.sh

set hidden
"
" Bracket pairs
set showmatch
set matchtime=10
set scrolloff=4


"current wd to current file
"set autochdir

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set autoindent

set nostartofline

set mouse=a

" Searching
set ignorecase
set smartcase

" display numbers
set relativenumber
set number

" display pum when tabbing
set wildmode=longest,full

" apppearance
set background=dark
color everforest

" no mode indicator
"set noshowmode

" limit popup height
set pumheight=15

" don't show completion preview popup
"set completeopt=menuone


" GVim setting
set guifont=Ubuntu\ Mono\ derivative\ Powerline\ 13
set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar


" ------------ My commands -----------------------
"command Check normal A ":exe "normal \<c-w>\<c-w>"

command! ProtosFind Ack <cword> $PROTOS_ROOT
command! ProjectsFind Ack <cword> $PROJECTS_ROOT


command! EditVimRC e ~/.vim/vimrc

command! RemoveTrailingWhitespace %s/\s\+$


" ------------ Auto nohlsearch -----------------------

augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END


" ------------ Jamfile Highlighting -----------------------

autocmd BufRead Jamroot,Jamfile,*.jam set syntax=bbv2

" ------------ Mappings -----------------------

let mapleader = ","
let maplocalleader = ","

" Search with Space
nmap <Space> /

" Quicker save
noremap <Leader>w :update<CR>

" Alternate buffer
nnoremap <BS> :buffer #<CR>

" scroll down with enter
"nnoremap <CR> <C-d>
"autocmd BufReadPost *.c,*.cpp,*.h,*.hpp,*.py nnoremap <CR> <C-d>

" Comfortable window switching
nnoremap <C-w>c :bp\|bd #<CR>
nnoremap <C-c> :bd<CR>
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

imap öö (
imap ää {
imap üü [

vmap öö S)
vmap ää S}
vmap üü S]

inoremap ,, <Esc>A;<Esc>

" leave various insert modes
inoremap jk <ESC>
cnoremap jk <C-c>
tnoremap jk <C-\><C-n>

" far better mapping for german layout
map ü <C-]>

" fast ag search
nnoremap <leader>a :Ack<Space>

" split line at coursor in normal mode
"nnoremap K i<CR><Esc>

" switch current dir to buffer's dir
nmap <leader>cd :cd %:p:h<CR>

"noremap <Leader>h :nohl<CR>

" quick g/s on buffer
nnoremap S :%<Space>

" quick command mode
nnoremap ä :

nnoremap <Leader>f :FZF $PROTOS_ROOT<CR>

" Alternate source <-> header
nnoremap <Leader>q :A<CR>

nnoremap <F3> :GitGutterToggle<CR>

" dispatch / make / quickfix
"nnoremap <Leader>m :Make!<CR>

function! MyMakeOpen()
    Copen
    nnoremap <buffer> o <CR>
    nnoremap <buffer> q :bd<CR>
    "nnoremap <buffer> n :cnext<CR>
    "nnoremap <buffer> p :cprevious<CR>
    nnoremap <buffer> n /error<CR>
    "buftype quickfix
endfunction

nnoremap <F5> :Make<CR>
nnoremap <F6> :wa<CR>:Make<CR>
inoremap <F6> <Esc>:wa<CR>:Make<CR>

nnoremap <Leader>mc :call MyMakeOpen()<CR>
nnoremap <Leader>mn :cnext<CR>
nnoremap <Leader>mp :cprevious<CR>


function! CppSettings()
    setlocal cindent
    setlocal cinoptions=(0,w1
endfunction
autocmd FileType cpp call CppSettings()


" ------- Plugins ---------------

"---------------------------------------------------------------------------
" Simple Bookmarks
"---------------------------------------------------------------------------

let g:bookmark_show_warning = 1
let g:bookmark_save_per_working_dir = 0
let g:bookmark_manage_per_buffer = 0

"---------------------------------------------------------------------------
" Git Gutter
"---------------------------------------------------------------------------
set updatetime=100

"---------------------------------------------------------------------------
" Buffer Explorer
"---------------------------------------------------------------------------
"let g:bufExplorerSplitOutPathName = 0
let g:bufExplorerReverseSort=1
nnoremap ö :ToggleBufExplorer<CR>

"---------------------------------------------------------------------------
" Tagbar
"---------------------------------------------------------------------------
nmap <F8> :TagbarToggle<CR>
let g:tagbar_sort = 0
let g:tagbar_compact = 1
"let g:tagbar_show_data_type = 1

"---------------------------------------------------------------------------
" Ultisnips
"---------------------------------------------------------------------------
"let g:UltiSnipsExpandTrigger="<CR>"
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsSnippetsDir=$HOME .. "/.vim/Ultisnips"
let g:UltiSnipsSnippetDirectories=["Ultisnips"]


"---------------------------------------------------------------------------
" Fugitive mapping
"---------------------------------------------------------------------------

nnoremap <Leader>gg :Git<Space>
nnoremap <Leader>gs :Git<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gl :Git log<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gb :Git blame<CR>


"---------------------------------------------------------------------------
" LSP
"---------------------------------------------------------------------------

lua require("config.lsp")

"---------------------------------------------------------------------------
" nvim-cmp
"---------------------------------------------------------------------------

lua require("config.cmp")

"---------------------------------------------------------------------------
" a.vim (alternate)
"---------------------------------------------------------------------------
let g:alternateNoDefaultAlternate = 1
" append to script default
let g:alternateSearchPath = 'sfr:../source,sfr:../src,sfr:../include,sfr:../inc'
            \ . ',sfr:../src,sfr:../public_include'
            \ . ',sfr:../../src,sfr:../../public_include'
            \ . ',reg:/src/public_include/g'
            \ . ',reg:/public_include/src/g'

"---------------------------------------------------------------------------
" Sessions
"---------------------------------------------------------------------------

set sessionoptions=buffers,curdir,help,resize,tabpages,terminal,winpos,winsize

let s:session_file = expand("~/.vim/sessions/default.vim")

function! SessionRestore()
    if !argc() && empty(v:this_session) && filereadable(s:session_file)
        execute "source" s:session_file
    endif
endfunction

function! SessionSave()
    if !argc()
        execute "mksession!" s:session_file
    endif
endfunction


augroup sessions
    autocmd!
    autocmd VimEnter * nested call SessionRestore()
    autocmd VimLeave,BufAdd * call SessionSave()
augroup END



"---------------------------------------------------------------------------
" Telescope
"---------------------------------------------------------------------------


nnoremap <leader>y :lua require("telescope.builtin").registers({initial_mode="normal"})<cr>
nnoremap <leader>t :lua require("telescope.builtin").lsp_document_symbols({initial_mode="insert"})<cr>


"---------------------------------------------------------------------------
" Sneak
"---------------------------------------------------------------------------
nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S
xmap f <Plug>Sneak_s
xmap F <Plug>Sneak_S
omap f <Plug>Sneak_s
omap F <Plug>Sneak_S
let g:sneak#s_next = 1


"---------------------------------------------------------------------------
" fzf
"---------------------------------------------------------------------------
set runtimepath+=~/Programme/fzf

autocmd FileType fzf set laststatus=0 noshowmode noruler | autocmd BufLeave <buffer> set laststatus=2 showmode ruler


"---------------------------------------------------------------------------
" Ack / Ag
"---------------------------------------------------------------------------
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif
"let g:ack_use_dispatch = 1

"---------------------------------------------------------------------------
" Dirvish
"---------------------------------------------------------------------------

command! Shell Dirvish ~/bin/
command! Utils Dirvish ~/bin_dev/

augroup dirvish_config
    autocmd!
    autocmd FileType dirvish map <buffer> q gq
augroup END

"---------------------------------------------------------------------------
" Fugitive
"---------------------------------------------------------------------------

augroup fugitive_config
    autocmd!
    autocmd FileType fugitive map <buffer><silent> q gq
augroup END

"---------------------------------------------------------------------------
" Dispatch
"---------------------------------------------------------------------------

let g:dispatch_tmux_height = 6
let g:dispatch_quickfix_height = 16

"---------------------------------------------------------------------------
" Lualine
"---------------------------------------------------------------------------

lua require("config.lualine")

"---------------------------------------------------------------------------
" Diagnostics
"---------------------------------------------------------------------------
sign define DiagnosticSignError text=🔥 texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text=👀 texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text=💡 texthl=DiagnosticSignInfo linehl= numhl=

