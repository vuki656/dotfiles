filetype plugin on

" #####################################################################################
" #-------------------------------------- SETS ---------------------------------------#
" #####################################################################################

set clipboard=unnamedplus                                   " Sync nvim clipboard with sys clipboard
set number                                                  " Show current line number
set relativenumber                                          " Show line number relative to line you are on
set incsearch                                               " Enables search results as you type
set smartindent                                             " Enable smart indenting
set nohlsearch                                              " Don't highlight search after search finished
set signcolumn=yes                                          " Auto show sign column (for git diff)
set updatetime=50                                           " Time after the buffer is saved
set hidden                                                  " Preserve closed buffers with changes
set scrolloff=10                                            " When 10 lines from top/bottom start scrolling
set termguicolors                                           " Set the given color scheme from init file
set nowrap                                                  " Don't wrap text if it goes out of view
set mouse=a                                                 " Enables mouse scrolling
set noswapfile                                              " Disable swap files
set undodir=~/.vim/undodir                                  " Set undodir location
set undofile                                                " Enable undo files
set scroll=15                                               " Set number of lines to scroll 
set tabstop=4                                               " Convert tab to 4 spaces
set shiftwidth=4                                            " Correctly indent lines inside blocks
set expandtab                                               " Convert tab to spaces
set splitright                                              " Open new buffers to the right
set splitbelow                                              " Open new buffers to the bottom
set notermguicolors t_Co=256

" Use | in insert mode
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q"

" #####################################################################################
" #------------------------------------ REMAPS ---------------------------------------#
" #####################################################################################

" Enter command mode
inoremap jj <ESC>

" Enter command mode
inoremap kk <ESC>
