local Ui = require("hangman.ui")
local Game = require("hangman.game")

---@class Hangman
---@field game HangmanGame
---@field ui HangmanUI
local Hangman = {}
Hangman.__index = Hangman

---@return Hangman
function Hangman:new()
  return setmetatable({
    game = Game:new(),
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

---Toggle the hangman UI
function Hangman:toggle_ui()
  self.ui:toggle(self.game)
end

---Guess a char
function Hangman:guess(c)
  self.game:guess(c)
end

---Start a new game
function Hangman:new_game()
  self.game = Game:new()
  self.ui:toggle(self.game)
  self.ui:toggle(self.game)
end

return Hangman
