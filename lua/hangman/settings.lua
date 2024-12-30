local M = {}

---@alias HangmanUISettings vim.api.keyset.win_config

---@type HangmanUISettings
M.ui = {
  relative = "editor",
  width = 27,
  height = 15,
  border = "rounded",
  style = "minimal",
  zindex = 100,
  title = "Hangman",
  title_pos = "center",
}

---@class HangmanInputSettings
---@field win vim.api.keyset.win_config
M.input = {
  win = {
    relative = "editor",
    width = M.ui.width - 2,
    height = 2,
    style = "minimal",
    border = "rounded",
    zindex = 200,
  },
}

---@class HangmanWordSettings
---@field win vim.api.keyset.win_config
M.word = {
  win = {
    relative = "editor",
    width = M.ui.width - 2,
    height = 1,
    style = "minimal",
    border = "rounded",
    zindex = 200,
  },
}

---@class HangmanFigureSettings
---@field win vim.api.keyset.win_config
M.figure = {
  win = {
    relative = "editor",
    width = M.ui.width - 2,
    height = 6,
    style = "minimal",
    border = "rounded",
    zindex = 200,
  },
}

return M
