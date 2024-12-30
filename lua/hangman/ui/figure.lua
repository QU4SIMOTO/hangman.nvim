local util = require("hangman.util")

---@type string[][] Ascii images of the hangman figure
local images = {
  {
    " +---+",
    " |   |",
    " O   |",
    "/|\\  |",
    "/ \\  |",
    "======",
  },
  {
    " +---+",
    " |   |",
    " O   |",
    "/|\\  |",
    "/    |",
    "======",
  },
  {
    " +---+",
    " |   |",
    " O   |",
    "/|\\  |",
    "     |",
    "======",
  },
  {
    " +---+",
    " |   |",
    " O   |",
    "/|   |",
    "     |",
    "======",
  },
  {
    " +---+",
    " |   |",
    " O   |",
    " |   |",
    "     |",
    "======",
  },
  {
    " +---+",
    " |   |",
    " O   |",
    "     |",
    "     |",
    "======",
  },
  {
    " +---+",
    " |   |",
    "     |",
    "     |",
    "     |",
    "======",
  },
  {
    " +---+",
    "     |",
    "     |",
    "     |",
    "     |",
    "======",
  },
  {
    "     +",
    "     |",
    "     |",
    "     |",
    "     |",
    "======",
  },
  {
    "      ",
    "      ",
    "      ",
    "      ",
    "      ",
    "======",
  },
  {
    "      ",
    "      ",
    "      ",
    "      ",
    "      ",
    "      ",
  },
}

---@class HangmanFigure UI component displaying the hangman figure
---@field win integer?
---@field buf integer?
---@field settings HangmanFigureSettings
local HangmanFigure = {}
HangmanFigure.__index = HangmanFigure

---@param settings HangmanFigureSettings
---@return HangmanFigure
function HangmanFigure:new(settings)
  return setmetatable({
    win = nil,
    buf = nil,
    settings = settings,
  }, self)
end

---Render the hangman figure from game state
---@param game HangmanGame
function HangmanFigure:render(game)
  vim.api.nvim_set_option_value("modifiable", true, { buf = self.buf })
  local image_id = game.lives > 0 and game.lives + 1 or 1
  local lines = vim
    .iter(images[image_id])
    :map(function(line)
      return util.pad_and_center(line, self.settings.win.width)
    end)
    :totable()
  vim.api.nvim_buf_set_lines(self.buf, 0, 1, false, lines)
  vim.api.nvim_set_option_value("modifiable", false, { buf = self.buf })
end

---Create the component window and render
---@param game HangmanGame
---@param col integer Column position of the window
---@param row integer Row position of the window
function HangmanFigure:create_window(game, col, row)
  self.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("filetype", "hangman", { buf = self.buf })
  self:render(game)
  local window_config =
    vim.tbl_extend("force", self.settings.win, { col = col, row = row })
  self.win = vim.api.nvim_open_win(self.buf, false, window_config)
end

---Close the component window
function HangmanFigure:close_window()
  vim.api.nvim_win_hide(self.win)
  self._win = nil
end

---Update the component
---@param game HangmanGame
function HangmanFigure:update(game)
  self:render(game)
end

return HangmanFigure
