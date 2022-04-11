local options = {
  -- no backup files
  backup = false,
  -- allows neovim to access the system clipboard
  clipboard = "unnamedplus",
  -- set numbered lines
  number = true,
  -- set relative numbered lines
  relativenumber = true,
  -- more space in the neovim command line for displaying messages
  cmdheight = 2,
  -- so that `` is visible in markdown files
  conceallevel = 0,
  -- the encoding written to a file
  fileencoding = "utf-8",
  -- highlight all matches on previous search pattern
  hlsearch = true,
  -- allow the mouse to be used in neovim
  mouse = "a",
  -- we don't need to see things like -- INSERT -- anymore
  showmode = false,
  -- ignore case in search patterns
  ignorecase = true,
  -- smart case
  smartcase = true,
  -- make indenting smarter again
  smartindent = true,
  -- force all horizontal splits to go below current window
  splitbelow = true,
  -- force all vertical splits to go to the right of current window
  splitright = true,
  -- no swapfiles
  swapfile = false,
  -- time to wait for a mapped sequence to complete (in milliseconds)
  timeoutlen = 1000,
  -- enable persistent undo
  undofile = true,
  -- faster completion (4000ms default)
  updatetime = 250,
  -- if a file is being edited by another program (or was written to file while
  -- editing with another program), it is not allowed to be edited
  writebackup = false,
  -- highlight the current line
  cursorline = true,
  -- always show the sign column, otherwise it would shift the text each time
  signcolumn = "number",
  wrap = false,
  scrolloff = 8,
  sidescrolloff = 8,
  breakindent = true,
  hidden = true,

  listchars = { trail='·', eol='↲', tab='▸ ' },
  list = true,

  -- Pop up menu
  winblend = 5,
  pumblend = 5,
  -- pop up menu height
  pumheight = 15,
  termguicolors = true,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.g.mapleader = ' '
vim.cmd[[au TextYankPost * silent! lua vim.highlight.on_yank()]]

require('plugins')
