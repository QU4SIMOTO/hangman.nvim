local Ui = require("hangman.ui")
local Game = require("hangman.game")

local Hangman = {}
Hangman.__index = Hangman

function Hangman:new()
  return setmetatable({
    game = Game:new({}),
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

function Hangman:toggle_ui()
  self.ui:toggle(self.game)
end

function Hangman:guess(c)
  self.game:guess(c)
end

function Hangman:new_game()
  self.game = Game:new()
  self.ui:toggle(self.game)
  self.ui:toggle(self.game)
end

local hangman = Hangman:new()

return hangman
