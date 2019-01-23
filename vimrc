execute pathogen#infect()
syntax on
filetype plugin indent on
set nocompatible

set shell=/bin/bash

" Python3 workaround (calls :python after startup)
"python 3

"if !has('nvim')
    "python 2
"endif

" omni completion
filetype plugin on
set omnifunc=syntaxcomplete#Complete


"-------------- Basics  -----------------------
"launch osl build script
set makeprg=~/bin/optibuild_stop.sh

set hidden
" Bracket pairs
set showmatch
set matchtime=10
set scrolloff=4

set hlsearch
set incsearch

"current wd to current file
"set autochdir

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

set nostartofline

set mouse=a

" Searching
" Search with Space
nmap <Space> /
set ignorecase
set smartcase

" display numbers
set relativenumber
set number

" display results when tabbing
set wildmode=list:longest,full

" apppearance
syntax enable
set background=dark
color apprentice

" no mode indicator
set noshowmode

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
"command! Ref UniteWithCursorWord gtags/ref

command! ProtosFind Ack <cword>


command! EditVimRC e ~/.vim/vimrc


" ------------ Jamfile Highlighting -----------------------

autocmd BufRead Jamfile set syntax=bbv2

" ------------ Mappings -----------------------

let mapleader = ","
let maplocalleader = ","

"Quicker save
noremap <Leader>w :update<CR>

"alternate buffer
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

" quick g/s on buffer
"nnoremap S :%<Space>

" quick command mode
nnoremap ä :

nnoremap <Leader>f :CtrlP ~/<CR>
nnoremap <Leader>o :CtrlPBufTag<CR>

"nnoremap <C-q> :A<CR>
nnoremap <Leader>q :A<CR>

" Toggle Gundo Undo Tree
nnoremap <F4> :GundoToggle<CR>

nnoremap <F3> :GitGutterToggle<CR>

" dispatch / make / quickfix
"nnoremap <Leader>m :Make!<CR>


function MyMakeOpen()
    Copen
    nnoremap <buffer> o <CR> 
    nnoremap <buffer> q :bd<CR> 
    nnoremap <buffer> n :cnext<CR> 
    nnoremap <buffer> p :cprevious<CR> 
    "buftype quickfix
endfunction

nnoremap <F5> :Make<CR>
nnoremap <F6> :wa<CR>:Make<CR>
inoremap <F6> <Esc>:wa<CR>:Make<CR>

nnoremap <Leader>mc :call MyMakeOpen()<CR>
nnoremap <Leader>mn :cnext<CR>
nnoremap <Leader>mp :cprevious<CR>


function! CKeysInit()
    " C++ append semicolon
    imap öö (
    imap ää {
    imap üü [
    inoremap ,, <Esc>A;<Esc>

    vmap öö S)
    vmap ää S}
    vmap üü S]

endfunction
autocmd BufRead *.cpp,*.hpp,*.h,*.ipp,*.py,*.sh,*.html,*.js call CKeysInit()

" ------------ Temporary Mappings -----------------------
nnoremap <F2> :!./run.sh<CR>


" remove trailing whitespace
nnoremap <leader>dws :%s/\s\+$<CR>

" ------- Plugins ---------------

"---------------------------------------------------------------------------
" Syntastic
"---------------------------------------------------------------------------

"let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_compiler = 'g++'
let g:syntastic_cpp_compiler_options = ' -std=c++11'
" Syntastic toggle
"nnoremap <leader>sy :SyntasticToggleMode<CR>:Errors<CR>
"let g:syntastic_error_symbol = '✗'
"let g:syntastic_warning_symbol = '⚠'

"---------------------------------------------------------------------------
" ALE
"---------------------------------------------------------------------------
"let g:ale_linters = {'cpp': ['clang', 'cppcheck', 'cpplint']}
"let g:ale_linters = {'cpp': ['g++']}
"let g:ale_cpp_gcc_options='-std=c++11 -Wall'

"---------------------------------------------------------------------------
" Clang complete
"---------------------------------------------------------------------------
let g:clang_library_path="/usr/lib64/llvm"
"let g:clang_auto_select=1
let g:clang_snippets=1
let g:clang_snippets_engine='ultisnips'
"let g:clang_close_preview=1
let g:clang_user_options='-std=c++11'
let g:clang_jumpto_declaration_key = '<C-1>'
let g:clang_jumpto_back_key = '<C-2>'

"let g:clang_complete_auto = 0
"let g:clang_auto_select = 0
"let g:clang_default_keymappings = 0


"---------------------------------------------------------------------------
" Simple Bookmarks
"---------------------------------------------------------------------------

let g:bookmark_show_warning = 1
let g:bookmark_save_per_working_dir = 0
let g:bookmark_manage_per_buffer = 0

"---------------------------------------------------------------------------
" Git Gutter
"---------------------------------------------------------------------------
set updatetime=150


"---------------------------------------------------------------------------
" Airline stuff
"---------------------------------------------------------------------------
let g:airline_theme="distinguished"
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#syntastic#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''

function! AirlineInit()
    "let g:airline_section_a = airline#section#create(['mode', ' ', 'foo'])
    let g:airline_section_b = airline#section#create(['%3v%  ॐ  %3L%'])
    let g:airline_section_x = airline#section#create(['branch'])
    let g:airline_section_y = airline#section#create(['tagbar'])
    let g:airline_section_z = airline#section#create(['filetype'])
    let g:airline_section_warning  = airline#section#create([''])

endfunction
autocmd User AirlineAfterInit call AirlineInit()


"---------------------------------------------------------------------------
" Tagbar
"---------------------------------------------------------------------------
nmap <F8> :TagbarToggle<CR>
let g:tagbar_sort = 0
let g:tagbar_compact = 1

"---------------------------------------------------------------------------
" Ultisnips
"---------------------------------------------------------------------------
"let g:UltiSnipsExpandTrigger="<CR>"
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"


"---------------------------------------------------------------------------
" Futigive mapping
"---------------------------------------------------------------------------

nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>ge :Gedit<CR>
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>gb :Gblame<CR>

"---------------------------------------------------------------------------
" Neocomplete / Deoplete
"---------------------------------------------------------------------------

if has('nvim')
    let g:deoplete#enable_at_startup=1
    let g:deoplete#enable_smart_case = 1
    let g:deoplete#tag#cache_limit_size = 10000000
    let g:deoplete#auto_complete_delay = 75
    "TODO
    command! Comp let g:deoplete#sources.cpp = ['buffer']
endif

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"let g:neocomplete#enable_auto_select=1

      "
let g:clang_complete_auto = 1
let g:clang_auto_select = 0



"---------------------------------------------------------------------------
" Sessions
"---------------------------------------------------------------------------
:let g:session_autosave = 'yes'
:let g:session_autoload = 'yes'
"
"---------------------------------------------------------------------------
" Jedi Vim
"---------------------------------------------------------------------------
"let g:jedi#completions_command = ""
"let g:jedi#use_splits_not_buffers ="top"
"let g:jedi#use_tabs_not_buffers=0

"---------------------------------------------------------------------------
" Unite / Denite
"---------------------------------------------------------------------------

nnoremap ö :Unite -direction=dynamicbottom -no-resize -buffer-name=buffers buffer<cr>
"if has('nvim')
    "nnoremap ö :Denite -winheight=12 -highlight-matched-char=underlined -cursor-wrap -mode=normal -buffer-name=buffers buffer<cr>
"else
    "nnoremap ö :Unite -direction=dynamicbottom -no-resize -buffer-name=buffers buffer<cr>
"endif

command! Shell Unite file file/new -buffer-name=Shellscripts -start-insert -input=~/bin/
nnoremap <leader>u :UniteResume<cr>

nnoremap <leader><CR> :UniteWithCursorWord -auto-resize -auto-preview tag<cr>

nnoremap <leader>ag :Unite grep:%<cr>

nnoremap <Leader>t :Unite outline -start-insert<CR>

"
"let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_history_yank_limit=25
nnoremap <leader>y :Denite -mode=normal -cursor-pos=+3 register<cr>


call unite#filters#matcher_default#use(['matcher_fuzzy'])

 "Use ag in unite grep source.
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--line-numbers --nocolor --nogroup --hidden --ignore ' .  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
let g:unite_source_grep_recursive_opt = ''

let g:unite_source_tag_max_fname_length=60

"Vimwiki
map <leader>W :Unite file file/new -buffer-name=notes -start-insert -input=~/vimwiki/<CR>
map <leader>wg :Unite grep:~/vimwiki/<CR>


autocmd FileType unite call s:unite_keymaps()

function! s:unite_keymaps()
    " Enable navigation with control-j and control-k in insert mode
    imap <buffer> <C-j>   <Plug>(unite_select_next_line)
    imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
endfunction``"

"---------------------------------------------------------------------------
" Denite
"---------------------------------------------------------------------------


"nnoremap ö :Denite -reversed -mode=normal -direction=dynamicbottom -auto-resize -buffer-name=buffers buffer<cr>
"nnoremap <Leader>t :Denite outline<CR>

"nnoremap <leader>ü :DeniteCursorWord -auto-resize -auto-preview tag<cr>

"nnoremap <leader>y :Denite -mode=normal neoyank<cr>

call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ 'jk',
      \ '<denite:enter_mode:normal>',
      \ 'noremap'
      \)

"" Ag command on grep source
"call denite#custom#var('grep', 'command', ['ag'])
"call denite#custom#var('grep', 'default_opts',
        "\ ['-i', '--vimgrep'])
"call denite#custom#var('grep', 'recursive_opts', [])
"call denite#custom#var('grep', 'pattern_opt', [])
"call denite#custom#var('grep', 'separator', ['--'])
"call denite#custom#var('grep', 'final_opts', [])

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
" ctrlp
"---------------------------------------------------------------------------
"let g:ctrlp_show_hidden = 1
let g:ctrlp_extensions = ['tag', 'quickfix']
"if executable('ag')
    "let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
    "let g:ctrlp_use_caching = 0
"endif


"---------------------------------------------------------------------------
" Ack / Ag
"---------------------------------------------------------------------------
if executable('ag')
  let g:ackprg = 'ag --vimgrep --smart-case'
endif
let g:ack_use_dispatch = 1

"---------------------------------------------------------------------------
" Dirvish
"---------------------------------------------------------------------------

noremap - :Dirvish %<CR>

"---------------------------------------------------------------------------
" Dispatch
"---------------------------------------------------------------------------

let g:dispatch_tmux_height = 6
let g:dispatch_quickfix_height = 16

"---------------------------------------------------------------------------
"incsearch
"---------------------------------------------------------------------------

" handled by vim now
" see is.vim

 
"---------------------------------------------------------------------------
" Own functions
"---------------------------------------------------------------------------
"function SVNRevert()
    "echo "Reverting file..."
    "!svn revert %
    "edit %
"endfunction
"command SRevert call SVNRevert()
