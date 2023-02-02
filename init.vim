language en_GB.UTF-8
set nocompatible

let mapleader = ","
let g:mapleader = ","

" If we are neovim, we have lua, so we do plugins and such there.
" Try to load lua/config.lua
if has('nvim')
lua << EOF
  require "config"
EOF
endif

" This stuff should be as simple as possible, and preferably compatible with
" Vim

" Make the mouse work as we want to
set mouse=a

" Set scroll offset to redduce movement
set scrolloff=7

" Use the system clipboard
set clipboard=unnamed,unnamedplus

" <Ctrl-d> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-d> :nohl<CR><C-l>

" indent automaticly depending on filetype
set smartindent
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set softtabstop=4
set expandtab

" set syntax highlighting
syntax on

" Set to automaticly read file again if edited elsewhere
set autoread

set wildignorecase
set ignorecase
set smartcase

" Smart way to split windows
nmap <silent> <A-h> :vsplit<CR>
nmap <silent> <A-k> :split<CR>
nmap <silent> <A-l> :vsplit<CR> :wincmd l<CR>
nmap <silent> <A-j> :split<CR> :wincmd j<CR>

" Close all other windows
nmap <silent> <leader>o :wincmd o<CR>

" Smart way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l
tnoremap <C-j> <C-\><C-N><C-W>j
tnoremap <C-k> <C-\><C-N><C-W>k
tnoremap <C-h> <C-\><C-N><C-W>h
tnoremap <C-l> <C-\><C-N><C-W>l

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" colorscheme
colorscheme blackboard
set background=dark
highlight Pmenu      ctermfg=15  ctermbg=0 guifg=#ffffff guibg=#000000
highlight PmenuSel   ctermfg=226 ctermbg=0 guifg=#ffff00 guibg=#000000
highlight Comment    ctermfg=grey guifg=#aaaaaa
highlight CommentDoc ctermfg=grey guifg=#aaaaaa
set cursorline
highlight CursorLine cterm=NONE ctermbg=234 guibg=#2D2D2D
highlight Todo ctermfg=white ctermbg=black guifg=White guibg=Black
nnoremap <leader>l :set cursorline!<CR>

" Remap keys (!)
nnoremap j gj
nnoremap k gk

imap <A-k> <up>
imap <A-h> <left>
imap <A-j> <down>
imap <A-l> <right>

noremap ø o
noremap Ø O

cmap w!! w !sudo tee % >/dev/null

imap <c-e> <c-o>A;

nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

" Custom make runner, to get it in a split
function Make(...)
    if a:0 > 0
        silent make a:000
    else
        silent make
    endif

    if winnr('$') <= 1
        vsplit
    endif

    let l:oldwin = winnr()
    let l:newwin = l:oldwin + 1
    if l:newwin > winnr('$')
        let l:newwin = 1
    endif

    exe l:newwin . "wincmd w"

    enew
    setlocal buftype=quickfix bufhidden=wipe nobuflisted noswapfile nowrap
    setlocal nomodifiable
    copen
    exe l:oldwin . "wincmd w"
endfunction
nmap <silent> <leader>c :call Make()<CR>

" Open corresponding .h/.cpp file
function OpenCorrespondingFile()
    let l:suffix = fnamemodify(bufname("%"), ":e")
    let l:root_fn = fnamemodify(bufname("%"), ":r")
    if l:suffix == "h"
        exe "wincmd p"
        exe "edit " . l:root_fn . ".cpp"
    elseif l:suffix == "cpp" || l:suffix == "c"
        exe "wincmd p"
        exe "edit " . l:root_fn . ".h"
    endif
endfunction
nmap <silent> <leader>h :call OpenCorrespondingFile()<CR>

" Use clang-format to format C/C++ code.
function FormatFile()
  let l:lines="all"
  pyf ~/.config/nvim/clang-format.py
endfunction
nmap <silent> <leader>i :call FormatFile()<CR>

function! PythonWrapper(code)
    " Strip trailing newline
    let code = substitute(a:code, '\n\+$', '', '')

    " Import some utils
    python 'from math import *'

    try
        let result = pyeval(code)
        return result
    catch /.*/
        return code
    endtry
endfunction

" Replace the current selection with the result of evaluating it as python
vnoremap <silent> <leader>p c<C-R>=PythonWrapper(@")<CR><ESC>

