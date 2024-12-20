local HangmanWord = {}
HangmanWord.__index = HangmanWord

function HangmanWord:new(settings)
  return setmetatable({
    win = nil,
    buf = nil,
    offset = 0,
    settings = settings
  }, self)
end

function HangmanWord:render(game)
  vim.api.nvim_set_option_value("modifiable", true, { buf = self.buf, })
  local chars = vim.tbl_map(function(c)
    if game.guessed[c] then
      return c
    else
      return "_"
    end
  end, vim.split(game.word, ""))
  local line = vim.iter(chars):join(" ")
  vim.api.nvim_buf_set_lines(self.buf, 0, 1, false, { line })
  vim.api.nvim_set_option_value("modifiable", false, { buf = self.buf, })
end

function HangmanWord:create_window(game, col, row)
  self.buf = vim.api.nvim_create_buf(false, true)
  self.offset = math.floor(self.settings.win.width / 2) - 5
  self:render(game)
  local window_config = vim.tbl_extend("force", self.settings.win, { col = col, row = row })
  self.win = vim.api.nvim_open_win(self.buf, false, window_config)
end

function HangmanWord:close_window()
  vim.api.nvim_win_hide(self.win)
  self.win = nil
end

function HangmanWord:update(game)
  self:render(game)
end

return HangmanWord
