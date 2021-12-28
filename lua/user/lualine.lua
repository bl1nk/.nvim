local ok, lualine = pcall(require, "lualine")
if not ok then return end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

