local Guy = require("hangman.ui.guy")
local Word = require("hangman.ui.word")
local Input = require("hangman.ui.input")
local auto = require("hangman.autocmd")
local default_settings = require("hangman.settings")

---@class Wrapper
---@field win integer?
---@field buf integer?

---Root UI component
---@class HangmanUI
---@field settings HangmanUISettings
---@field wrapper Wrapper
---@field guy HangmanGuy
---@field word HangmanWord
---@field input HangmanInput
local HangmanUI = {}
HangmanUI.__index = HangmanUI

---@param settings HangmanUISettings
---@return HangmanUI
function HangmanUI:new(settings)
  return setmetatable({
    settings = settings,
    wrapper = {
      win = nil,
      buf = nil,
    },
    guy = Guy:new(default_settings.guy),
    word = Word:new(default_settings.word),
    input = Input:new(default_settings.input),
  }, self)
end

function HangmanUI:close()
  if self.wrapper.win then
    vim.api.nvim_win_hide(self.wrapper.win)
    self.wrapper.win = nil
  end
  vim.api.nvim_clear_autocmds({
    event = "User",
    group = auto.augroups.ui,
  })
  self.guy:close_window()
  self.word:close_window()
  self.input:close_window()
end

function HangmanUI:open(game)
  if self.wrapper.win then
    return
  end
  self:create_window(game)
end

---@param game HangmanGame
function HangmanUI:create_window(game)
  local col = math.floor((vim.o.columns - self.settings.width) / 2)
  local row = math.floor((vim.o.lines - self.settings.height) / 2)

  self.wrapper.buf = self.wrapper.buf or vim.api.nvim_create_buf(false, true)
  vim.api.nvim_set_option_value(
    "filetype",
    "hangman",
    { buf = self.wrapper.buf }
  )

  vim.api.nvim_set_option_value("modifiable", false, { buf = self.wrapper.buf })
  local win_config = vim.tbl_extend("force", self.settings, {
    col = col,
    row = row,
    zindex = 100,
  })
  self.wrapper.win = vim.api.nvim_open_win(self.wrapper.buf, false, win_config)

  self.guy:create_window(game, col + 1, row + 1)
  self.word:create_window(game, col + 1, row + 9)
  self.input:create_window(game, col + 1, row + 12)

  vim.api.nvim_create_autocmd("User", {
    group = auto.augroups.ui,
    pattern = "hangman",
    callback = function(e)
      if e.data == "update" then
        self:update(game)
      elseif e.data == "close" then
        self:close()
      end
    end,
  })
end

---@param game HangmanGame
function HangmanUI:toggle(game)
  if self.wrapper.win then
    self:close()
  else
    self:open(game)
  end
end

---@param game HangmanGame
function HangmanUI:update(game)
  self.guy:update(game)
  self.word:update(game)
  self.input:update(game)
end

return HangmanUI
