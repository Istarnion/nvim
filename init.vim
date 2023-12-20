""" This tries to be compatible with (modern) vim, not just neovim.
""" Plugins are configured in lua/config.lua, and are neovim specific.

" Set locale
language en_GB.UTF-8

" This is for vim/neovim, don't bother with vi compat
set nocompatible

" Use , as leader key
let mapleader = ","
let g:mapleader = ","

" Open new horizontal splits below
set splitbelow

" If we are neovim, we have lua, so we do plugins and such there.
" Try to load lua/config.lua
if has('nvim')
lua << EOF
  require("config")
EOF
endif

""""""""""""""""""""""""""""""
" Misc
""""""""""""""""""""""""""""""
" Make the mouse work as we want to
set mouse=a

" Use relative line numbers
set number
set relativenumber

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

" Set to automaticly read file again if edited elsewhere
set autoread

" Ignore case when completing file names
set wildignorecase
" Also ignore case in other completions
set ignorecase
" ...except when we actually type upper case in the pattern
set smartcase

"" Remap keys (!)
" Move in wrapped lines
nnoremap j gj
nnoremap k gk

" hjkl in insert mode while holding alt
imap <A-k> <up>
imap <A-h> <left>
imap <A-j> <down>
imap <A-l> <right>

" For when we forget to open a file with sudo
cmap w!! w !sudo tee % >/dev/null

""""""""""""""""""""""""""""""
" Windows / splits
""""""""""""""""""""""""""""""
" Smart way to split windows
nmap <silent> <A-h> :vsplit<CR> :wincmd h<CR>
nmap <silent> <A-k> :split<CR> :wincmd k<CR>
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
" netrw customization
""""""""""""""""""""""""""""""
" Sort plainly by name, no grouping on extensions
let g:netrw_sort_sequence = ''
" Open with shortcut
nnoremap <silent> <leader>e :Explore<CR>

""""""""""""""""""""""""""""""
" Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

""""""""""""""""""""""""""""""
" Colors
""""""""""""""""""""""""""""""
" set syntax highlighting
syntax on

" Use 24-bit colors
set termguicolors

" Customize colors (scheme independent, sortof. Won't look nice with a light
" one!
set background=dark
highlight Pmenu         ctermfg=white   ctermbg=black   guifg=#ffffff   guibg=#000000
highlight PmenuSel      ctermfg=yellow  ctermbg=black   guifg=#ffff00   guibg=#000000
highlight Comment       ctermfg=grey                    guifg=#aaaaaa
highlight CommentDoc    ctermfg=grey                    guifg=#aaaaaa
highlight Todo          ctermfg=white   ctermbg=black   guifg=#ffffff   guibg=#000000
set cursorline
highlight CursorLine cterm=NONE ctermbg=234 guibg=#1D1D1D
nnoremap <leader>l :set cursorline!<CR>
" show vertical lines as indent guides
set list
highlight Whitespace    ctermfg=grey    ctermbg=black   guifg=#2D2D2D   guibg=#000000
set listchars=tab:¦\ ,leadmultispace:¦\ \ \ 
nnoremap <leader>g :set list!<CR>


""""""""""""""""""""""""""""""
" Custom vim functions
""""""""""""""""""""""""""""""
" Run make and open the quickfix window in a split
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

" Use python as a glorified calculator
command -nargs=* Calc !python3 -c "from math import *; print(<args>)"
command -nargs=* CalcInsert read !python3 -c "from math import *; print(<args>)"

