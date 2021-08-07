" Remove all `autocmd`s
autocmd!

" Automatically download vim-plug and install plugins
let data_dir = stdpath('data') . '/site'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \| PlugInstall --sync | source $MYVIMRC
      \| endif

call plug#begin(stdpath('config') . '/plugged')
Plug 'ludovicchabant/vim-gutentags' " Automatic tag management
Plug 'tpope/vim-fugitive' " Git integration
Plug 'tpope/vim-commentary' " `gc` to comment visual regions/lines
Plug 'tpope/vim-surround' " Surround selections with anything using `S`
Plug 'tpope/vim-repeat' " Make . work with more motions
Plug 'tpope/vim-sleuth' " Auto-detect indent style

Plug 'folke/tokyonight.nvim' " Theme
call plug#end()

" Enable absolute and relative line numbers
set number
set relativenumber

" Incremental live completion on commands
set inccommand=nosplit

" Add padding to cursor position
set scrolloff=10

" Do not wrap long lines
set nowrap

" Indent on line breaks
set breakindent

" Do not save when switching buffers
set hidden

" Enable mouse mode
set mouse=a

" Save undo history
set undofile

" Case insensitive search unless capital in search
set ignorecase
set smartcase

" Always show signcolumn
set signcolumn=yes

" Write swap files quicker after stopping to type
set updatetime=250

" Transparent floating windows
set winblend=15

" Transparent popup-menu
set pumblend=15

" Popup-menu width and height
set pumwidth=20
set pumheight=15

" Always use clipboard for all operations
set clipboard+=unnamedplus

" Open new split below and right of the current window
set splitbelow
set splitright

" Ignore in searches
set wildignore+=node_modules/**,.*.swp,.git/**

" Exit insert mode with fd and jk
imap fd <Esc>
imap jk <Esc>

" Theme
set termguicolors

let g:tokyonight_style = "night"
colorscheme tokyonight

