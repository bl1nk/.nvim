local ok, telescope = pcall(require, "telescope")
if not ok then return end

local ok, actions = pcall(require, "telescope.actions")
if not ok then return end

telescope.setup {
  defaults = {
    path_display = { "shorten" },
    sorting_strategy = "ascending",
    layout_strategy = "center",
    layout_config = {
      prompt_position = "top",
    },
    winblend = 5,
  },
  mappings = {},
  pickers = {
    find_files = {
      theme = "dropdown",
      previewer = false,
    },
    buffers = {
      theme ="dropdown",
      previewer = false,
    }
  }
}
