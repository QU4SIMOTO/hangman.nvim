package.loaded["autocmd"] = nil
local auto = require("autocmd")

local states = {
  running = "RUNNING",
  won = "WON",
  lost = "LOST",
}

local HangmanGame = {}
HangmanGame.__index = HangmanGame

function HangmanGame:new(settings)
  local game = setmetatable({
    guessed = {},
    lives = 10,
    word = settings.word,
    state = states.running,
  }, self)

  vim.api.nvim_create_autocmd(auto.event, {
    group = auto.augroups.guess,
    pattern = "hangman",
    callback = function(e)
      game:guess(e.data.guess)
    end,
  })
  return game
end

function HangmanGame:guess(guess)
  if self.guessed[guess] ~= nil or self.state ~= states.running then
    return
  end
  local is_correct = vim.iter(vim.split(self.word, "")):find(function(c)
    return c == guess
  end) ~= nil

  self.guessed[guess] = is_correct

  if not is_correct then
    self.lives = self.lives == 0 and 0 or self.lives - 1
  end

  self:update_state()

  vim.api.nvim_exec_autocmds(auto.event, {
    group = auto.augroups.ui,
    pattern = "hangman",
    data = "update",
  })
end

function HangmanGame:update_state()
  if self.state ~= states.running then
    return
  end

  if self.lives == 0 then
    self.state = states.lost
    print("You lost")
  end

  local is_complete = vim
    .iter(vim.split(self.word, ""))
    :fold(true, function(acc, curr)
      return acc and self.guessed[curr] == true
    end)

  if is_complete then
    self.state = states.won
    print("You won")
  end
end

return HangmanGame
