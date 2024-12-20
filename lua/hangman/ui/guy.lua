local image_cols = 6
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

local HangmanGuy = {}
HangmanGuy.__index = HangmanGuy

function HangmanGuy:new(settings)
  return setmetatable({
    win = nil,
    buf = nil,
    offset = 0,
    settings = settings,
  }, self)
end

function HangmanGuy:render(game)
  vim.api.nvim_set_option_value("modifiable", true, { buf = self.buf })
  local image_id = game.lives > 0 and game.lives + 1 or 1
  local lines = vim
    .iter(images[image_id])
    :map(function(line)
      return string.rep(" ", self.offset) .. line
    end)
    :totable()
  vim.api.nvim_buf_set_lines(self.buf, 0, 1, false, lines)
  vim.api.nvim_set_option_value("modifiable", false, { buf = self.buf })
end

function HangmanGuy:create_window(game, col, row)
  self.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("filetype", "hangman", { buf = self.buf })
  self.offset = math.floor(self.settings.win.width / 2) - (image_cols / 2)
  self:render(game)
  local window_config =
    vim.tbl_extend("force", self.settings.win, { col = col, row = row })
  self.win = vim.api.nvim_open_win(self.buf, false, window_config)
end

function HangmanGuy:close_window()
  vim.api.nvim_win_hide(self.win)
  self.win = nil
end

function HangmanGuy:update(game)
  self:render(game)
end

return HangmanGuy
