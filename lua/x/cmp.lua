local ok, cmp = pcall(require, "cmp")
if not ok then return end

local ok, luasnip = pcall(require, "luasnip")
if not ok then return end

require("luasnip/loaders/from_vscode").lazy_load()

-- via: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup{
  mapping = {
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-3), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(3), { "i", "c" }),
    ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-e>"] = cmp.mapping {
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    },
    ["<CR>"] = cmp.mapping.confirm { select = true },

    -- via: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#luasnip
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
	cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
	luasnip.expand_or_jump()
      elseif has_words_before() then
	cmp.complete()
      else
	fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
	cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
	luasnip.jump(-1)
      else
	fallback()
      end
    end, { "i", "s" }),
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.menu = ({
	nvim_lsp = "[LSP]",
	buffer = "[Buffer]",
	luasnip = "[LuaSnip]",
	nvim_lua = "[Lua]",
	path = "[Path]"
      })[entry.source.name]
      return vim_item
    end
  },
  sources =  {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }
}

