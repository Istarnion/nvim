set nocompatible
filetype off
set runtimepath^=~/.config/nvim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.config/nvim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'gmarik/vundle'
NeoBundle 'tpope/vim-surround'
NeoBundle 'jiangmiao/auto-pairs'
NeoBundle 'flazz/vim-colorschemes'
NeoBundle 'Valloric/YouCompleteMe'
" NeoBundle 'lilydjwg/colorizer'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'sheerun/vim-polyglot'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" Custom setting for YouCompleteMe
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" Settings for emmet-vim
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Use the system clipboard
set clipboard=unnamed,unnamedplus

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-d> :nohl<CR><C-l>
 
" indent automaticly depending on filetype
filetype plugin indent on
set autoindent
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab

let mapleader = ","
let g:mapleader = ","

" enable line numbers
set number

" Use relative linenumbers
set relativenumber
" Toggle the linenumber style
nnoremap <leader>r :set relativenumber!<cr>

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
nmap <silent> <A-j> :botright split<CR> :wincmd j<CR>

" Smart way to move between windows
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l

" Hide window
map <A-0> :hide<CR>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="A-o"

let g:UltiSnipsJumpForwardTrigger="<c-o>"
let g:UltiSnipsJumpBackwardTrigger="<c-u>"

" colorscheme
" colors asu1dark
set background=dark
highlight Pmenu     ctermfg=15  ctermbg=0 guifg=#ffffff guibg=#000000
highlight PmenuSel  ctermfg=226 ctermbg=0 guifg=#ffff00 guibg=#000000
set cursorline
highlight CursorLine cterm=NONE ctermbg=black guibg=black
nnoremap <leader>c :set cursorline!<CR>

" Remap keys (!)
let kbl="qwerty"
if kbl == "qwerty"
    " EEEEEVIIIILLLL!!!
    imap <A-k> <up>
    imap <A-h> <left>
    imap <A-j> <down>
    imap <A-l> <right>

    noremap ø o
    noremap Ø O

else
	noremap n j
	noremap e k
	noremap i l

endif

cmap w!! w !sudo tee % >/dev/null

imap <c-e> <c-o>A;

nmap <S-Enter> O<Esc>
nmap <CR> o<Esc>

