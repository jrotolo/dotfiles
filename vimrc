"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITOR CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set background=dark
set nocompatible

execute pathogen#infect()
syntax on
filetype plugin indent on

set number " show line numbers
set tabstop=2 softtabstop=2 shiftwidth=2 expandtab
set autoindent
set laststatus=2
colorscheme jellybeans

set showcmd " Show last command entered in status bar
set cursorline
" Always show tab bar at the top
set showtabline=2
" If a file is changed outside of vim, automatically reload it without asking
set autoread

"" SEARCHING
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
set incsearch " search as characters are entered
set hlsearch " highlight matches

" Don't make backups
set nobackup
set nowritebackup
" Emacs style tab completion when selecting files
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
" Highlight matching [{()}]
set showmatch

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MAPPINGS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=","

" Moves the current line down one line
nnoremap _ ddp
" Moves the current line up one line
nnoremap - ddkP
" Remap Esc key
imap jk <Esc>
" turn off search highlight
nnoremap <leader><space> :nohlsearch<cr>
" Opens vimrc file in a split window
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" Sources the vimrc file
nnoremap <leader>sv :source $MYVIMRC<cr>
" Toggles the file explorer in a vertical split using the current working
" directory as a starting point
nnoremap <leader><Tab> :call VexToggle(getcwd())<cr>
nnoremap <leader>` :call VexToggle("")<cr>
" Surround word with quotes
nnoremap <leader>" viw<Esc>a"<Esc>bi"<Esc>lel 
nnoremap <leader>' viw<Esc>a'<Esc>bi'<Esc>lel

"" Git Specific Mappings
nnoremap <leader>gs :!clear && git status<cr>
nnoremap <leader>ga :!clear && git add . && git status<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FUNCTIONS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Clear trailing whitespaces from current file
function! <SID>StripTrailingWhitespaces()
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  call cursor(l, c)
endfun

" Toggle Vim's netrw directory tree split
function! VexToggle(dir)
  if exists("t:vex_buf_nr")
    call VexClose()
  else
    call VexOpen(a:dir)
  endif
endf

function! VexOpen(dir)
  let g:netrw_browse_split=4 " open files in previous window
  let vex_width = 25

  execute "Vexplore " . a:dir
  let t:vex_buf_nr = bufnr("%")
  wincmd H

  call VexSize(vex_width)
endf

function! VexClose()
  let cur_win_nr = winnr()
  let target_nr = ( cur_win_nr == 1 ? winnr("#") : cur_win_nr )

  1wincmd w
  close
  unlet t:vex_buf_nr " Clear reference to open vex buffer

  execute (target_nr - 1) . "wincmd w"
  call NormalizeWidths()
endf

function! VexSize(vex_width)
  execute "vertical resize" . a:vex_width
  set winfixwidth
  call NormalizeWidths()
endf

" Helper function used in VexClose to fix window width
function! NormalizeWidths()
  let eadir_pref = &eadirection
  set eadirection=hor
  set equalalways! equalalways!
  let &eadirection = eadir_pref
endf

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AUTOCMD
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd BufWritePre *.js,*.rb,*.jsx,*.json,*.es6,*.cjsx :call <SID>StripTrailingWhitespaces()

" Normalize window widths when opened in vertical split from netrw
augroup NetrwGroup
  autocmd! BufEnter * call NormalizeWidths()
augroup END

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PLUGIN CONFIG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" CTRL-P Fuzzy File Finder Config
" Set CtrlP to the projects working directory
let g:ctrlp_working_path_mode = 'ra'
" Exclude directories from CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
jet g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
" Open files in a new vim tab
let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")' : ['<2-LeftMouse>'],
  \ 'AcceptSelection("t")': ['<cr>'],
  \ }

"" JSX Syntax Plugin
let g:jsx_ext_required = 0 " Don't require .jsx file extension

"" Native Vim's Netrw file directory tree
let g:netrw_liststyle=3
let g:netrw_banner=0
let g:netrw_altv=1 " open files on right
let g:netrw_preview=1 " open previews vertically
let g:netrw_browse_split=3
