local Ui = require("hangman.ui")
local Game = require("hangman.game")
local default_settings = require("hangman.settings")

---@class Hangman
---@field game HangmanGame
---@field ui HangmanUI
local Hangman = {}
Hangman.__index = Hangman

---@return Hangman
function Hangman:new()
  return setmetatable({
    game = Game:new(),
    ui = Ui:new(default_settings.ui),
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
