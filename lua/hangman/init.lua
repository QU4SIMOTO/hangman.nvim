local Ui = require("hangman.ui")
local Game = require("hangman.game")

local Hangman = {}
Hangman.__index = Hangman

function Hangman:new()
  return setmetatable({
    game = Game:new({
      word = "HANGMAN",
    }),
    ui = Ui:new({
      relative = "editor",
      width = 27,
      height = 15,
      border = "rounded",
      style = "minimal",
      zindex = 100,
      title = "Hangman",
      title_pos = "center",
    }),
  }, self)
end

function Hangman:toggleUI()
  self.ui:toggle(self.game)
end

local hangman = Hangman:new()

-- todo remove this
vim.keymap.set("n", "<leader>t", function()
  hangman:toggleUI()
end)

return hangman