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
Plug 'nvim-treesitter/nvim-treesitter', {'branch': '0.5-compat', 'do': ':TSUpdate'} " Better syntax highlighting
Plug 'nvim-lua/plenary.nvim' " Needed by lewis6991/gitsigns.nvim
Plug 'lewis6991/gitsigns.nvim' " Git indicators in signcolumn
Plug 'neovim/nvim-lspconfig' " LSP support
Plug 'hrsh7th/nvim-compe' " Autocompletion
Plug 'L3MON4D3/LuaSnip' " Snippets
Plug 'folke/tokyonight.nvim' " Theme
call plug#end()

" Enable absolute and relative line numbers
set number
set relativenumber

" Incremental live completion on commands
set inccommand=nosplit

" Add padding to cursor position
set scrolloff=10
set sidescrolloff=10

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
set winblend=5

" Transparent popup-menu
set pumblend=5

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
inoremap fd <Esc>
inoremap jk <Esc>
tnoremap <Esc> <C-\><C-n>

" Exit terminal with fd and jk
tnoremap fd <C-\><C-n>
tnoremap jk <C-\><C-n>

" Open terminal with <leader>t
nnoremap <Leader>t :terminal<cr>
" Split terminal with <leader>T
nnoremap <Leader>T :split +te<cr>
augroup neovim_terminal
  autocmd!
  " Enter Terminal-mode (insert) automatically
  autocmd TermOpen * startinsert
  " Disable number lines on terminal buffers
  autocmd TermOpen * :set nonumber norelativenumber
  " C-c works in normal mode
  autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
augroup END

" Theme
set termguicolors

let g:tokyonight_style = "night"
colorscheme tokyonight

" Show trailing whitespace
hi EoLSpace ctermbg=8 guibg=#292e42
match EoLSpace /\s\+$/

" Highlight yanked areas
au TextYankPost * silent! lua require'vim.highlight'.on_yank()

" nvim-treesitter/nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
      "bash", "fish",
      "c", "cpp",
      "css", "scss",
      "dockerfile",
      "go", "gomod",
      "hcl",
      "html",
      "java",
      "javascript", "svelte", "typescript", "tsx",
      "jsdoc",
      "json", "jsonc", "toml", "yaml",
      "kotlin",
      "ledger",
      "lua",
      "nix",
      "php",
      "python",
      "regex",
      "rust",
    }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}
EOF

" lewis6991/gitsigns.nvim
lua require('gitsigns').setup()

" neovim/nvim-lspconfig
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

--Enable completion triggered by <c-x><c-o>
buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

-- Mappings.
local opts = { noremap=true, silent=true }

-- See `:help vim.lsp.*` for documentation on any of the below functions
buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>', opts)
buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>', opts)
buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>', opts)
buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>', opts)
buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>', opts)
buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<cr>', opts)
buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', opts)
buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'gopls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    },
  }
end
EOF

" hrsh7th/nvim-compe, L3MON4D3/LuaSnip
set completeopt=menuone,noselect

lua <<EOF
require('compe').setup {
  source = {
    path = true,
    nvim_lsp = true,
    luasnip = true,
    buffer = false,
    calc = false,
    nvim_lua = false,
    vsnip = false,
    ultisnips = false,
  },
}

-- Utility functions for compe and luasnip
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
  local col = vim.fn.col '.' - 1
  if col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' then
    return true
  else
    return false
  end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
local luasnip = require 'luasnip'

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-n>'
  elseif luasnip.expand_or_jumpable() then
    return t '<Plug>luasnip-expand-or-jump'
  elseif check_back_space() then
    return t '<Tab>'
  else
    return vim.fn['compe#complete']()
  end
end

_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t '<C-p>'
  elseif luasnip.jumpable(-1) then
    return t '<Plug>luasnip-jump-prev'
  else
    return t '<S-Tab>'
  end
end

-- Map tab to the above tab complete functiones
vim.api.nvim_set_keymap('i', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<Tab>', 'v:lua.tab_complete()', { expr = true })
vim.api.nvim_set_keymap('i', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })
vim.api.nvim_set_keymap('s', '<S-Tab>', 'v:lua.s_tab_complete()', { expr = true })

-- Map compe confirm and complete functions
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
vim.api.nvim_set_keymap('i', '<c-space>', 'compe#complete()', { expr = true })
EOF

