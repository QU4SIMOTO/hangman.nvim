local new_set = MiniTest.new_set
local expect = MiniTest.expect

local child = MiniTest.new_child_neovim()

local T = new_set({
  hooks = {
    pre_case = function()
      child.restart({ "-u", "scripts/minimal_init.lua" })
      child.lua([[M = require("hangman")]])
    end,
    post_once = child.stop,
  }
})

local function ui_move_right()
  child.type_keys(5, { "l", "l" })
end

local function ui_move_down()
  child.type_keys(5, { "j" })
end

local function ui_guess()
  child.type_keys(5, { "<CR>" })
end

T["input"] = function()
  child.lua("M.game.word = 'ABC'")
  child.cmd("Hangman")
  ui_guess() -- A
  ui_move_right()
  ui_guess() -- B
  ui_move_down()
  ui_guess() -- O
  expect.reference_screenshot(child.get_screenshot())
end

T["win"] = function()
  child.lua("M.game.word = 'ABC'")
  child.cmd("Hangman")
  expect.reference_screenshot(child.get_screenshot())

  child.cmd("Hangman guess a")
  expect.reference_screenshot(child.get_screenshot())

  child.cmd("Hangman guess b")
  expect.reference_screenshot(child.get_screenshot())

  child.cmd("Hangman guess c")
  expect.reference_screenshot(child.get_screenshot())
end

T["loss"] = function()
  child.lua("M.game.word = 'FOO'")
  child.cmd("Hangman")
  expect.reference_screenshot(child.get_screenshot())

  child.cmd("Hangman guess a")
  expect.reference_screenshot(child.get_screenshot())

  child.cmd("Hangman guess b")
  expect.reference_screenshot(child.get_screenshot())

  child.cmd("Hangman guess c")
  expect.reference_screenshot(child.get_screenshot())

  child.cmd("Hangman guess d")
  expect.reference_screenshot(child.get_screenshot())

  child.cmd("Hangman guess e")
  expect.reference_screenshot(child.get_screenshot())

  child.cmd("Hangman guess g")
  expect.reference_screenshot(child.get_screenshot())

  child.cmd("Hangman guess h")
  expect.reference_screenshot(child.get_screenshot())

  child.cmd("Hangman guess i")
  expect.reference_screenshot(child.get_screenshot())

  child.cmd("Hangman guess j")
  expect.reference_screenshot(child.get_screenshot())

  child.cmd("Hangman guess k")
  expect.reference_screenshot(child.get_screenshot())
end

T["toggle"] = function()
  child.lua("M.game.word = 'ABC'")
  child.cmd("Hangman")
  child.cmd("Hangman guess a")
  expect.reference_screenshot(child.get_screenshot())
  child.cmd("Hangman")
  expect.reference_screenshot(child.get_screenshot())
  child.cmd("Hangman")
  expect.reference_screenshot(child.get_screenshot())
end

T["closes on buf leave"] = function()
  child.lua("M.game.word = 'ABC'")
  child.cmd("Hangman")
  expect.reference_screenshot(child.get_screenshot())
  child.cmd("bn")
  expect.reference_screenshot(child.get_screenshot())
end

return T
