local util = require("hangman.util")

---Target word UI component
---@class HangmanWord
---@field win integer?
---@field buf integer?
---@field settings any
local HangmanWord = {}
HangmanWord.__index = HangmanWord

---@param settings any
---@return HangmanWord
function HangmanWord:new(settings)
  return setmetatable({
    win = nil,
    buf = nil,
    settings = settings,
  }, self)
end

---@param game HangmanGame
function HangmanWord:render(game)
  vim.api.nvim_set_option_value("modifiable", true, { buf = self.buf })
  local chars = vim.tbl_map(function(c)
    if game.guessed[c] then
      return c
    else
      return "_"
    end
  end, vim.split(game.word, ""))
  local line =
    util.pad_and_center(vim.iter(chars):join(" "), self.settings.win.width)
  vim.api.nvim_buf_set_lines(self.buf, 0, 1, false, { line })
  vim.api.nvim_set_option_value("modifiable", false, { buf = self.buf })
end

---@param game HangmanGame
---@param col integer Column position of the window
---@param row integer Row position of the window
function HangmanWord:create_window(game, col, row)
  self.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("filetype", "hangman", { buf = self.buf })
  self:render(game)
  local window_config =
    vim.tbl_extend("force", self.settings.win, { col = col, row = row })
  self.win = vim.api.nvim_open_win(self.buf, false, window_config)
end

function HangmanWord:close_window()
  vim.api.nvim_win_hide(self.win)
  self.win = nil
end

---@param game HangmanGame
function HangmanWord:update(game)
  self:render(game)
end

return HangmanWord
