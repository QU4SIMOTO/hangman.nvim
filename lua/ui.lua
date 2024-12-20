package.loaded["guy"] = nil
package.loaded["word"] = nil
package.loaded["letters"] = nil
package.loaded["autocmd"] = nil

local Guy = require("guy")
local Word = require("word")
local Letters = require("letters")

local HangmanUI = {}
HangmanUI.__index = HangmanUI

function HangmanUI:new(settings)
  return setmetatable({
    settings = settings,
    wrapper = {
      win = nil,
      buf = nil,
    },
    guy = Guy:new({
      win = {
        relative = "editor",
        width = settings.width - 2,
        height = 6,
        style = "minimal",
        border = "rounded",
        zindex = 200,
      },
    }),
    word = Word:new({
      win = {
        relative = "editor",
        width = settings.width - 2,
        height = 1,
        style = "minimal",
        border = "rounded",
        zindex = 200,
      }
    }),
    letters = Letters:new({
      win = {
        relative = "editor",
        width = settings.width - 2,
        height = 2,
        style = "minimal",
        border = "rounded",
        zindex = 200,
      }
    }),
  }, self)
end

function HangmanUI:close()
  if self.wrapper.win then
    vim.api.nvim_win_hide(self.wrapper.win)
    self.wrapper.win = nil
  end
  vim.api.nvim_clear_autocmds({ event = require"autocmd".event_update })
  self.guy:close_window()
  self.word:close_window()
  self.letters:close_window()
end

function HangmanUI:open(game)
  if self.wrapper.win then
    return
  end
  self:create_window(game)
end

function HangmanUI:create_window(game)
  local col = math.floor((vim.o.columns - self.settings.width) / 2)
  local row = math.floor((vim.o.lines - self.settings.height) / 2)

  self.wrapper.buf = self.wrapper.buf or vim.api.nvim_create_buf(false, true)

  vim.api.nvim_set_option_value("modifiable", false, { buf = self.wrapper.buf, })
  local win_config = vim.tbl_extend("force", self.settings, {
    col = col,
    row = row,
    zindex = 100,
  })
  self.wrapper.win = vim.api.nvim_open_win(self.wrapper.buf, false, win_config)

  self.guy:create_window(game, col + 1, row + 1)
  self.word:create_window(game, col + 1, row + 9)
  self.letters:create_window(game, col + 1, row + 12)

  vim.api.nvim_create_autocmd(require"autocmd".event_update, {
    callback = function()
      self:update(game)
    end
  })
end

function HangmanUI:toggle(game)
  if self.wrapper.win then
    self:close()
  else
    self:open(game)
  end
end

function HangmanUI:update(game)
  self.guy:update(game)
  self.word:update(game)
  self.letters:update(game)
end

return HangmanUI
