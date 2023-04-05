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
color base16-eighties

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

" leave insert mode easier
inoremap jk <ESC>

" leave command mode easier
cnoremap jk <C-c>

" far better mapping for german layout
map ü <C-]>

" fast ag search
nnoremap <leader>a :Ack<Space>

" split line at coursor in normal mode
nnoremap K i<CR><Esc>

" switch current dir to buffer's dir
nmap <leader>cd :cd %:p:h<CR>

"noremap <Leader>h :nohl<CR>

" Leave terminal-mode with Esc
tnoremap <Esc> <C-\><C-n>

" quick g/s on buffer
nnoremap S :%<Space>

" quick command mode
nnoremap ä :

nnoremap <Leader>f :FZF $PROTOS_ROOT<CR>
nnoremap <Leader>r :FZF $PROJECTS_ROOT<CR>

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


" remove trailing whitespace
nnoremap <leader>dws :%s/\s\+$<CR>


function! CppSettings()
    setlocal cindent
    setlocal cinoptions=(0,w1
endfunction
autocmd FileType cpp call CppSettings()

" ------- Plugins ---------------

" ALE
"---------------------------------------------------------------------------
let g:ale_linters = {
            \ "cpp": [""],
            \ "javascript": ["eslint"],
            \ "python": ["mypy"]
            \}

let g:ale_fixers = {
            \ "python": ["black"],
            \ "cpp": ["clang-format"]
            \}

let g:ale_completion_enabled = 0
let g:ale_hover_to_floating_preview = 1
let g:ale_floating_preview = 1

let g:ale_c_clangformat_style_options=expand($PROTOS_ROOT) .. "/_clang_format"

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
" Deoplete
"---------------------------------------------------------------------------

if has('nvim')
    let g:deoplete#enable_at_startup=1
    let g:deoplete#tag#cache_limit_size = 10000000

    call deoplete#custom#option({
    \ 'max_list': 200,
    \ 'smart_case': v:true,
    \ })

    autocmd CompleteDone * silent! pclose!

    ""call deoplete#custom#var('omni', 'input_patterns', { 'javascript': '[^. *\t]\.\w*' })
endif

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

"---------------------------------------------------------------------------
" a.vim (alternate)
"---------------------------------------------------------------------------
let g:alternateNoDefaultAlternate = 1
" append to script default
let g:alternateSearchPath = 'sfr:../source,sfr:../src,sfr:../include,sfr:../inc'
            \ . ',sfr:../src,sfr:../public_include'
            \ . ',sfr:../../src,sfr:../../public_include'

"---------------------------------------------------------------------------
" Sessions
"---------------------------------------------------------------------------
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
"
"---------------------------------------------------------------------------
" Jedi Vim
"---------------------------------------------------------------------------
"let g:jedi#completions_command = ""
"let g:jedi#use_splits_not_buffers ="top"
"let g:jedi#use_tabs_not_buffers=0

"---------------------------------------------------------------------------
" Denite
"---------------------------------------------------------------------------

nnoremap <Leader>t :Denite outline -start-filter<CR>

nnoremap <leader><CR> :DeniteCursorWord -auto-resize tag<cr>

nnoremap <leader>y :Denite -cursor-pos=+3 -split=floating register<cr>

autocmd FileType denite call s:denite_settings()
function! s:denite_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <Space>
  \ denite#do_map('toggle_select').'j'
endfunction

"---------------------------------------------------------------------------
" Sneak colors
"---------------------------------------------------------------------------
augroup SneakPluginColors
    autocmd!
    autocmd ColorScheme * hi SneakPluginTarget guifg=black guibg=red ctermfg=red ctermbg=black
    autocmd ColorScheme * hi SneakPluginScope  guifg=black guibg=yellow ctermfg=black ctermbg=yellow
augroup END
nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S
xmap f <Plug>Sneak_s
xmap F <Plug>Sneak_S
omap f <Plug>Sneak_s
omap F <Plug>Sneak_S
let g:sneak#s_next = 1

"---------------------------------------------------------------------------
" easy motion
"---------------------------------------------------------------------------
map s <Plug>(easymotion-s)
let g:EasyMotion_keys = 'asdghklqwertyuiopzxcvbnmfj'

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
" incsearch
"---------------------------------------------------------------------------

" handled by vim now
" see is.vim

"---------------------------------------------------------------------------
" Lualine
"---------------------------------------------------------------------------

lua << EOF
require("lualine").setup {
    options = {
        component_separators = "",
        section_separators = ""
    },
    sections = {
        lualine_a = { {
            'mode', fmt = function(m) return m:sub(1,1) end } },
        lualine_b = {"'ॐ'", 'location'},
        lualine_c = {'filename'},
        lualine_x = {},
        lualine_y = {'FugitiveHead'},
        lualine_z = {'filetype'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    } }
EOF
