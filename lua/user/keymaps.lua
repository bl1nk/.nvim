local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local map = vim.api.nvim_set_keymap
local g = vim.g

--Remap space as leader key
map("", "<Space>", "<Nop>", opts)
g.mapleader = " "
g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Press jk or fd to exit insert mode
map("i", "jk", "<ESC>", opts)
map("i", "fd", "<ESC>", opts)
map("t", "fd", "<C-\\><C-n>", opts)
map("t", "jk", "<C-\\><C-n>", opts)
-- cycle through buffers with tab/S-tab
map("n", "<tab>", "<cmd>bn<cr>",opts)
map("n", "<S-tab>", "<cmd>bp<cr>",opts)

-- open terminal with <leader>t
map("n", "<leader>ts", ":split +te<cr>", opts)
map("n", "<leader>tv", ":vsplit +te<cr>", opts)
vim.cmd [[
augroup neovim_terminal
  autocmd!
  " Enter Terminal-mode (insert) automatically
  autocmd TermOpen * startinsert
  " Disable number lines on terminal buffers
  autocmd TermOpen * :set nonumber norelativenumber
  " Enable C-c in normal mode
  autocmd TermOpen * nnoremap <buffer> <C-c> i<C-c>
augroup END
]]

--map("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader><tab>", "<cmd>Telescope buffers<cr>",opts)
map("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
map("n", "<c-t>", "<cmd>Telescope live_grep<cr>", opts)

