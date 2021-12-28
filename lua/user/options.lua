local options = {
  backup = false,            -- no backup files
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  number = true,             -- set numbered lines
  relativenumber = true,     -- set relative numbered lines
  cmdheight = 2         ,    -- more space in the neovim command line for displaying messages
  conceallevel = 0       ,   -- so that `` is visible in markdown files
  fileencoding = "utf-8"  ,  -- the encoding written to a file
  hlsearch = true          , -- highlight all matches on previous search pattern
  mouse = "a"               ,-- allow the mouse to be used in neovim
  showmode = false    ,      -- we don't need to see things like -- INSERT -- anymore
  ignorecase = true    ,     -- ignore case in search patterns
  smartcase = true      ,    -- smart case
  smartindent = true     ,   -- make indenting smarter again
  splitbelow = true       ,  -- force all horizontal splits to go below current window
  splitright = true  ,       -- force all vertical splits to go to the right of current window
  swapfile = false    ,      -- no swapfiles
  timeoutlen = 1000    ,     -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true       ,    -- enable persistent undo
  updatetime = 250       ,   -- faster completion (4000ms default)
  writebackup = false     ,  -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  cursorline = true       ,  -- highlight the current line
  signcolumn = "yes"   ,     -- always show the sign column, otherwise it would shift the text each time
  wrap = false         ,     -- display lines as one long line
  scrolloff = 8        ,     -- is one of my fav
  sidescrolloff = 8,
  breakindent = true,
  hidden = true,

  winblend = 5,
  pumblend = 5,
  pumheight = 15,            -- pop up menu height
  termguicolors = true,
  background = "light",
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.cmd[[
au TextYankPost * silent! lua vim.highlight.on_yank()
]]
