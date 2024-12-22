local auto = require("hangman.autocmd")

---Input UI component
---@class HangmanInput
---@field win integer?
---@field buf integer
---@field ns integer Namespace id for highlights
---@field settings any
local HangmanInput = {}
HangmanInput.__index = HangmanInput

---@param settings any
---@return HangmanInput
function HangmanInput:new(settings)
  return setmetatable({
    win = nil,
    buf = nil,
    ns = vim.api.nvim_create_namespace("hangmanLetters"),
    settings = settings,
  }, self)
end

---@param game HangmanGame
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

---@param game HangmanGame
---@param col integer Column position of the window
---@param row integer Row position of the window
function HangmanInput:create_window(game, col, row)
  self.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value("filetype", "hangman", { buf = self.buf })
  self:render(game)

  local window_config =
    vim.tbl_extend("force", self.settings.win, { col = col, row = row })
  self.win = vim.api.nvim_open_win(self.buf, true, window_config)

  vim.keymap.set("n", "<CR>", function()
    self:_selection()
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

---Get the char currently under the cursor
---@return string
function HangmanInput:_get_cursor_char()
  local pos = vim.api.nvim_win_get_cursor(self.win)
  local line =
    vim.api.nvim_buf_get_lines(self.buf, pos[1] - 1, pos[1], false)[1]
  return string.sub(line, pos[2] + 1, pos[2] + 1)
end

---Emit guess event with the char currently under the cursor
function HangmanInput:_selection()
  local c = self:_get_cursor_char()

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

---@param game HangmanGame
function HangmanInput:update(game)
  self:render(game)
end

return HangmanInput
