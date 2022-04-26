-- Bootstrapping config copied from
-- https://github.com/wbthomason/packer.nvim/blob/4dedd3b08f8c6e3f84afbce0c23b66320cd2a8f2/README.md#bootstrapping
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})

  -- Regression after nvim 0.6.1, workaround copied from
  -- https://github.com/wbthomason/packer.nvim/issues/750#issuecomment-1006070458
  vim.o.runtimepath = vim.fn.stdpath("data") .. "/site/pack/*/start/*," .. vim.o.runtimepath
  vim.cmd([[ packadd packer.nvim ]])
end

-- Run :PackerCompile if this file is updated. Copied from
-- https://github.com/wbthomason/packer.nvim/blob/4dedd3b08f8c6e3f84afbce0c23b66320cd2a8f2/README.md#quickstart
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Auto-detect indent style
  use 'tpope/vim-sleuth'

  -- Make . work with more motions
  use 'tpope/vim-repeat'

  -- Surround selections with anything using `S`
  use 'tpope/vim-surround'

  -- Comment with `gc`
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  use {
    'junegunn/fzf.vim',
    requires = {
      {'junegunn/fzf', run = 'fzf#install'},
      {"folke/which-key.nvim"},
      {'nvim-lua/popup.nvim'},
      {'nvim-lua/plenary.nvim'},
    },
    config = function()
      require('which-key').register({
        f = { "<cmd>Files<cr>", "Find File" },
        b = { "<cmd>Buffers<cr>", "Switch buffers" },
      },
      { prefix = "<leader>", noremap = true })
    end
  }

  -- TODO: enable again
  -- use {
  --   'nvim-telescope/telescope.nvim',
  --   requires = {
  --     {'nvim-lua/popup.nvim'},
  --     {'nvim-lua/plenary.nvim'},
  --     {"folke/which-key.nvim"},
  --   },
  --   config = function()
  --     require('telescope').setup {
  --       extensions = {
  --         -- TODO: enable fzf or fzy
  --         -- fzf = {
  --         --   fuzzy = true,                    -- false will only do exact matching
  --         --   override_generic_sorter = true,  -- override the generic sorter
  --         --   override_file_sorter = true,     -- override the file sorter
  --         --   case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
  --         -- },
  --       },
  --     }
  --
  --     require('which-key').register({
  --       f = { "<cmd>Telescope find_files<cr>", "Find File" },
  --       b = { "<cmd>Telescope buffers<cr>", "Switch buffers" },
  --     },
  --     { prefix = "<leader>", noremap = true })
  --   end
  -- }

  use {
    'projekt0n/github-nvim-theme',
    config = function()
      vim.opt.background = 'dark'
      require('github-theme').setup({
        theme_style = "dark_default",
        dark_float = true,
      })
    end
  }

  use {
    'nvim-lualine/lualine.nvim',
    after = 'github-nvim-theme',
    config = function()
      require('lualine').setup {
        options = {
          -- Powerline
          section_separators = { left = '', right = ''},
          component_separators = { left = '', right = ''},

          -- Disabled & Simple
          -- section_separators = '',
          -- component_separators = '|',

          -- Slant
          -- component_separators = { left = '', right = '' },
          -- section_separators = { left = '', right = '' },

          icons_enabled = true,
          theme = 'auto',
        },
        extensions = {'fugitive','quickfix'},
        sections = {
          lualine_a = {
            {
              'mode',
              -- fmt = function(str)
              --   return str:sub(1,1)
              -- end
            }
          },
          lualine_b = {'branch'},
          lualine_c = {
            {
              'filename',
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1,           -- 0 = just filename, 1 = relative path, 2 = absolute path
            }
          },
          lualine_x = {'location', 'progress', 'filetype'},
          lualine_y = {},
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = {{ 'filename', file_status = true, path = 1 }},
          lualine_x = {'location','progress', 'filetype'},
          lualine_y = {},
          lualine_z = {}
        },
      }
    end
  }

  use 'tpope/vim-fugitive'

  use {
    'lewis6991/gitsigns.nvim',
    -- tag = 'release' -- To use the latest release
    config = function()
      require('gitsigns').setup{}
    end
  }

  use {
    'neovim/nvim-lspconfig',
    requires = {
      {"folke/which-key.nvim"},
    },
    config = function()
      local wk = require('which-key')
      local on_attach = function (client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        local opts = { noremap=true, silent=true, buffer=bufnr }
        wk.register({
          K = {'<cmd>lua vim.lsp.buf.hover()<cr>',"Hover help"},
          g ={
            d = {'<cmd>lua vim.lsp.buf.definition()<cr>',"Go to definition"},
            r = {'<cmd>lua vim.lsp.buf.references()<cr>',"Go to references"},
            i = {'<cmd>lua vim.lsp.buf.implementation()<cr>', "Go to implementation"},
          },
          ["<leader>"] = {
            a = {'<cmd>lua vim.lsp.buf.code_action()<cr>', "Apply code action"},
            k = {'<cmd>lua vim.lsp.buf.hover()<cr>', "Hover help"},
            K = {'<cmd>lua vim.lsp.buf.signature_help()<cr>', "Signature help"},
            r = {'<cmd>lua vim.lsp.buf.rename()<cr>', "Rename symbol"},
            ["="] = {'<cmd>lua vim.lsp.buf.formatting()<cr>', "Format buffer"},
            s = {'<cmd>lua vim.lsp.buf.document_symbol()<cr>','List symbols in current buffer'},
          },
        }, opts)
      end

      vim.lsp.set_log_level("debug")

      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      -- from nvim-cmp
      local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

      local servers = { 'gopls', 'rnix', 'sumneko_lua' }
      for _,lsp in pairs(servers) do
        require('lspconfig')[lsp].setup{
          on_attach = on_attach,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 150,
          },
          settings = {
            Lua = {
              runtime = {
                version = 'LuaJIT',
                path = runtime_path,
              },
              diagnostics = {
                globals = { 'vim' },
              },
            },
          },
        }
      end
    end
  }

  use {
    "hrsh7th/nvim-cmp",
    requires = {
      'neovim/nvim-lspconfig',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',

      -- vsnip
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip'
    },
    config = function()
      local cmp = require'cmp'

      cmp.setup({
        snippet = {
          expand = function(args) vim.fn["vsnip#anonymous"](args.body) end,
        },
        window = {},
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'vsnip' }, -- For vsnip users.
        }, {
          { name = 'buffer' },
        })
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      cmp.setup.cmdline('/', {
        sources = {
          { name = 'buffer' }
        }
      })
    end,
  }

  use {
    "preservim/vim-markdown",
    requires = {
      {"godlygeek/tabular"},
    },
    config = function()
      local opts = {
        vim_markdown_math = 1,
        vim_markdown_frontmatter = 1,
        vim_markdown_toml_frontmatter = 1,
        vim_markdown_json_frontmatter = 1,
        vim_markdown_new_list_item_indent = 2,
        vim_markdown_folding_disabled = 1
      };
      for k,v in pairs(opts) do
        vim.g[k]=v
      end
    end
  }

  use {
    "folke/which-key.nvim",
    config = function()
      local wk = require('which-key')
      wk.setup {}
      wk.register({
        g = {
          n = {"<cmd>bnext<cr>", "Next buffer"},
          p = {"<cmd>bprev<cr>", "Previous buffer"},
        },
      }, {noremap = true})
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

