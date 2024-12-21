local new_set = MiniTest.new_set
local Hangman = require("hangman.hangman")

local T = new_set({})

T["new game random word"] = function()
  -- TODO test random word generation better than this
  local hangman = Hangman:new()
  local word = Hangman:new().game.word
  local tries = 500
  for _ = 1, tries do
    hangman:new_game()
    if word ~= hangman.game.word then
      return
    end
  end
  error(
    "Didn't get a new word after "
    .. tries ..
    ", word: "
    .. word
  )
end

return T
