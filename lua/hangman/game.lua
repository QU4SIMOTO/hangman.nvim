local auto = require("hangman.autocmd")
local data = require("hangman.data")

---@class HangmanGame
---@field guessed table<string, boolean>
---@field lives number defaults to 0
---@field word string
---@field state "RUNNING"|"WON"|"LOST"
local HangmanGame = {}
HangmanGame.__index = HangmanGame

---@return HangmanGame
function HangmanGame:new()
  local game = setmetatable({
    guessed = {},
    lives = 10,
    word = data.get_random_word(),
    state = "RUNNING",
  }, self)

  vim.api.nvim_create_autocmd("User", {
    group = auto.augroups.guess,
    pattern = "hangman",
    callback = function(e)
      game:guess(e.data.guess)
    end,
  })
  return game
end

---@param guess string The char to guess
function HangmanGame:guess(guess)
  if self.guessed[guess] ~= nil or self.state ~= "RUNNING" then
    return
  end
  local is_correct = vim.iter(vim.split(self.word, "")):find(function(c)
    return c == guess
  end) ~= nil

  self.guessed[guess] = is_correct

  if not is_correct then
    self.lives = self.lives == 0 and 0 or self.lives - 1
  end

  self:_update_state()

  vim.api.nvim_exec_autocmds("User", {
    group = auto.augroups.ui,
    pattern = "hangman",
    data = "update",
  })
end

---Update the internal state of the game
function HangmanGame:_update_state()
  if self.state ~= "RUNNING" then
    return
  end

  if self.lives == 0 then
    self.state = "LOST"
    print("You lost")
  end

  local is_complete = vim
    .iter(vim.split(self.word, ""))
    :fold(true, function(acc, curr)
      return acc and self.guessed[curr] == true
    end)

  if is_complete then
    self.state = "WON"
    print("You won")
  end
end

return HangmanGame
