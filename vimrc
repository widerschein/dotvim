syntax on
filetype plugin indent on
set nocompatible

set shell=/bin/bash

set termguicolors

set hidden

" Bracket pairs
set showmatch
set matchtime=10
set scrolloff=4


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

" appearance
set background=dark
color everforest

" no mode indicator
"set noshowmode

" limit popup height
set pumheight=15

" don't show completion preview popup
"set completeopt=menuone

" Neovide
if exists("g:neovide")
    set guifont=Ubuntu\ Mono:h13
    let g:neovide_cursor_trail_size = 0.4
    let g:neovide_position_animation_length = 0.01
    let g:neovide_scroll_animation_length = 0.15
    let g:neovide_cursor_vfx_mode = "pixiedust"
endif


" ------------ My commands -----------------------

command! SandboxFind Ack! <cword> $SANDBOX

command! EditVimRC e ~/.vim/vimrc

command! RemoveTrailingWhitespace %s/\s\+$


" ------------ Auto nohlsearch -----------------------

augroup vimrc-incsearch-highlight
  autocmd!
  autocmd CmdlineEnter /,\? :set hlsearch
  autocmd CmdlineLeave /,\? :set nohlsearch
augroup END


" ------------ Custom Highlighting -----------------------

autocmd BufRead Jamroot,Jamfile,*.jam set syntax=bbv2
autocmd BufRead *.qrc set filetype=xml

" ------------ Mappings -----------------------

let mapleader = ","
let maplocalleader = ","

" Search with Space
nmap <Space> /

" Quicker save
noremap <Leader>w :update<CR>

" Alternate buffer
nnoremap <BS> :buffer #<CR>

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

" finder
if executable('fzf')
    nnoremap <Leader>f :FZF $PROTOS_ROOT<CR>
else
    nnoremap <Leader>f :Telescope find_files cwd=$PROTOS_ROOT<CR>
endif
nnoremap <Leader>g :Telescope live_grep cwd=$SANDBOX<CR>

" Alternate source <-> header
nnoremap <Leader>q :A<CR>

nnoremap <F3> :Gitsigns toggle_signs<CR>

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

set sessionoptions=buffers,curdir,resize,terminal,winpos,winsize

let g:default_session_file = ""

function! SessionRestore()
    let l:started_with_stdin = len(getbufinfo({'bufmodified':1})) > 0
    if !argc() && !l:started_with_stdin && empty(v:this_session)
        let g:default_session_file = expand("~/.vim/sessions/default.vim")
        if filereadable(g:default_session_file)
            execute "source" g:default_session_file
        endif
    endif
endfunction

function! SessionSave()
    if len(g:default_session_file)
        execute "mksession!" g:default_session_file
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

if executable('rg')
  let g:ackprg = 'rg --vimgrep --smart-case'
elseif executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif
"let g:ack_use_dispatch = 1

"---------------------------------------------------------------------------
" Dirvish
"---------------------------------------------------------------------------

command! Shell Dirvish ~/bin/
command! Utils Dirvish ~/bin_dev/

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
" gitsigns
"---------------------------------------------------------------------------

lua require("config.gitsigns")

"---------------------------------------------------------------------------
" Codecompanion
"---------------------------------------------------------------------------

lua require("config.codecompanion")

"---------------------------------------------------------------------------
" Diagnostics
"---------------------------------------------------------------------------

lua << EOF
vim.diagnostic.config({virtual_text = true})
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "🔥",
            [vim.diagnostic.severity.WARN] = "👀",
            [vim.diagnostic.severity.INFO] = "💡",
            [vim.diagnostic.severity.HINT] = "H"
        }
    }
})
EOF

"---------------------------------------------------------------------------
" Plugins
"---------------------------------------------------------------------------

lua require("packages")
