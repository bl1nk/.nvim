local ok, gh = pcall(require, "github-theme")
if not ok then return end

gh.setup{
  hide_inactive_statusline = false,
  hide_end_of_buffer = false
}

vim.cmd [[
try
  colorscheme github_dark_default
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
