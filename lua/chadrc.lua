-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {
  base46 = {
    hl_override = {
      Comment = { italic = true },
      NvimTreeOpenedFolderName = { bold = true },
      NvimTreeGitDirty = { fg = "yellow" },
      NvimTreeGitNew = { fg = "green" },
    },
    theme = "gruvchad",
    theme_toggle = { "gruvchad", "blossom_light" },
  },
  ui = {
    cmp = {
      style = "atom",
      lspkind_text = true,
    },
    statusline = {
      separator_style = "round",
      theme = "minimal",
    },
    telescope = {
      style = "bordered",
    },
  },
}

return M
