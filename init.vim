set nocompatible
filetype off
set runtimepath^=~/.config/nvim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.config/nvim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'tpope/vim-surround'          " Commands to add/remove/change surrounding stuff
NeoBundle 'jiangmiao/auto-pairs'        " Auto insert closing )}]' and so on
NeoBundle 'flazz/vim-colorschemes'      " Make tons of colorschemes available
NeoBundle 'Yggdroot/indentLine'         " display thin vertical lines at indentation
NeoBundle 'mattn/emmet-vim'             " emmet plugin ofr html and css
NeoBundle 'sheerun/vim-polyglot'        " syntax files for all languages I'll ever need
NeoBundle 'ctrlpvim/ctrlp.vim'          " Fuzzy file finding
NeoBundle 'SirVer/ultisnips'            " Snippet systems
NeoBundle 'honza/vim-snippets'          " Snippet library
NeoBundle 'Shougo/deoplete.nvim'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck

" Deoplete config
let g:deoplete#enable_at_startup=1
if has("gui_running")
    inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()
else
    inoremap <silent><expr><C-@> deoplete#mappings#manual_complete()
endif

" UltiSnips config
inoremap <silent><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Settings for emmet-vim
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" Settings for CtrlP
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" Use the system clipboard
set clipboard=unnamed,unnamedplus

" <Ctrl-d> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-d> :nohl<CR><C-l>
 
" indent automaticly depending on filetype
filetype plugin indent on
set autoindent
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set softtabstop=4
set expandtab

let mapleader = ","
let g:mapleader = ","

" Save with C-s in insert mode
inoremap <C-s> <Esc>:w<CR>

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
noremap <C-j> <C-W>
noremap <C-k> <C-W>k
noremap <BS> <C-W>h
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
    nnoremap j gj
    nnoremap k gk

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

