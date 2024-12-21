local auto = require("hangman.autocmd")

local HangmanInput = {}
HangmanInput.__index = HangmanInput

function HangmanInput:new(settings)
  return setmetatable({
    win = nil,
    buf = nil,
    ns = vim.api.nvim_create_namespace("hangmanLetters"),
    settings = settings,
  }, self)
end

function HangmanInput:render(game)
  vim.api.nvim_set_option_value("modifiable", true, { buf = self.buf })
  local lines = {
    "A B C D E F G H I J K L M",
    "N O P Q R S T U V W X Y Z",
  }
  vim.api.nvim_buf_set_lines(self.buf, 0, 3, false, lines)
  for i, line in ipairs(lines) do
    for j, c in ipairs(vim.split(line, "")) do
      if game.guessed[c] ~= nil then
        vim.api.nvim_buf_add_highlight(
          self.buf,
          self.ns,
          "NonText",
          i - 1,
          j - 1,
          j
        )
      end
    end
  end
  vim.api.nvim_set_option_value("modifiable", false, { buf = self.buf })
end

function HangmanInput:create_window(game, col, row)
  self.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("filetype", "hangman", { buf = self.buf })
  self:render(game)

  local window_config =
    vim.tbl_extend("force", self.settings.win, { col = col, row = row })
  self.win = vim.api.nvim_open_win(self.buf, true, window_config)

  vim.keymap.set("n", "<CR>", function()
    self:selection()
  end, { buffer = self.buf })

  vim.api.nvim_create_autocmd("BufLeave", {
    buffer = self.buf,
    callback = function()
      vim.api.nvim_exec_autocmds("User", {
        group = auto.augroups.ui,
        pattern = "hangman",
        data = "close",
      })
    end,
  })
end

function HangmanInput:selection()
  local pos = vim.api.nvim_win_get_cursor(self.win)
  local line =
    vim.api.nvim_buf_get_lines(self.buf, pos[1] - 1, pos[1], false)[1]
  local c = string.sub(line, pos[2] + 1, pos[2] + 1)

  if c == " " then
    return
  end

  vim.api.nvim_exec_autocmds("User", {
    group = auto.augroups.guess,
    pattern = "hangman",
    data = { guess = c },
  })
end

function HangmanInput:close_window()
  vim.api.nvim_win_hide(self.win)
  self.win = nil
end

function HangmanInput:update(game)
  self:render(game)
end

return HangmanInput
