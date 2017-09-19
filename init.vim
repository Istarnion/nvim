language en_GB.UTF-8

if !empty(glob("~/.config/nvim/bundle"))
  set nocompatible
  filetype off
  set runtimepath^=~/.config/nvim/bundle/neobundle.vim/
  call neobundle#begin(expand('~/.config/nvim/bundle/'))

  NeoBundleFetch 'Shougo/neobundle.vim'
  NeoBundle 'tpope/vim-surround'          " Commands to add/remove/change surrounding stuff
  NeoBundle 'jiangmiao/auto-pairs'        " Auto insert closing )}]' and so on
  NeoBundle 'flazz/vim-colorschemes'      " Make tons of colorschemes available
  NeoBundle 'Yggdroot/indentLine'         " display thin vertical lines at indentation
  NeoBundle 'mattn/emmet-vim'             " emmet plugin for html and css
  NeoBundle 'sheerun/vim-polyglot'        " syntax files for all languages I'll ever need
  NeoBundle 'ctrlpvim/ctrlp.vim'          " Fuzzy file finding
  NeoBundle 'SirVer/ultisnips'            " Snippet systems
  NeoBundle 'vim-airline/vim-airline'     " More fancy status line
  NeoBundle 'airblade/vim-gitgutter'      " Shows git diff in the gutter. Integrates also woth the statusline
  NeoBundle 'tpope/vim-commentary'        " Toggle comment on line with gcc, else with gc
  NeoBundle 'scrooloose/nerdtree'         " NERDTree file browser. Yes, I do know about netrw.
  NeoBundle 'Xuyuanp/nerdtree-git-plugin' " Shows git-info in NERDTree
  NeoBundle 'xolox/vim-misc'              " Misc scripts for plugins
  NeoBundle 'xolox/vim-notes'             " Note taking plugin

  call neobundle#end()
  filetype plugin indent on
  NeoBundleCheck

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

  " Settings for airline statusline
  let g:airline_powerline_fonts=1
  let g:airline_section_x='%r%{getcwd()}%h'
  let g:airline_section_z='%l/%L : %c'

  " vim-notes config
  let g:notes_directories = ['~/Dropbox/Notes']
endif

" Make the mouse work as we want to
set mouse=a

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

" Save with C-s
noremap <C-s> <Esc><Esc>:w<CR>

" make saving with :w case insensitive
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>

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

" Open file under cursor in last active window. Not working properly right now..
noremap <C-e> :let mycurf=expand("<cfile>")<cr> :wincmd p<cr> :execute("e ".mycurf)<cr>

" Resize current split
noremap <silent> <A-+> :vertical resize +2 <CR>
noremap <silent> <A--> :vertical resize -2 <CR>

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

" colorscheme
colorscheme Blackboard
set background=dark
highlight Pmenu     ctermfg=15  ctermbg=0 guifg=#ffffff guibg=#000000
highlight PmenuSel  ctermfg=226 ctermbg=0 guifg=#ffff00 guibg=#000000
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

" Search for struct definition
nmap <leader>s /struct 

" Break single line statement to block statement
nmap <leader>b ys$}a<CR><Esc>b%i<CR><Esc>0dt}%

" Run shell command and display result in other split
command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
    let expanded_cmdline = a:cmdline
    for part in split(a:cmdline, ' ')
        if part[0] =~ '\v[%#<]'
            let expanded_part = fnameescape(expand(part))
            let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
        endif
    endfor

    if winnr('$') > 1
        wincmd p
    else
        vsplit
        wincmd l
    endif

    enew
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
    call setline(1, 'Command:    ' . a:cmdline)
    call setline(2,substitute(getline(1),'.','=','g'))
    execute '$read !'. expanded_cmdline
    call append(line('$'), getline(2))
    call append(line('$'), 'Done.')
    setlocal nomodifiable
    call setpos(".", 1)
    wincmd p
endfunction

nmap <silent> <leader>c :Shell make<cr>

