local new_set = MiniTest.new_set
local expect, eq = MiniTest.expect, MiniTest.expect.equality

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

local function move_right()
  child.type_keys(5, { "l", "l" })
end

local function guess()
  child.type_keys(5, { "<CR>" })
end


T["updates UI on correct guess"] = function()
  child.lua("M.game.word = 'ABC'")
  child.cmd("Hangman")
  expect.reference_screenshot(child.get_screenshot())

  guess() -- A
  expect.reference_screenshot(child.get_screenshot())

  move_right()
  guess() -- B
  expect.reference_screenshot(child.get_screenshot())

  move_right()
  guess() -- C
  expect.reference_screenshot(child.get_screenshot())
  eq(child.lua("return M.game.state"), "WON")
end
vim.cmd("messages")

T["updates UI on wrong guess"] = function()
  child.lua("M.game.word = 'FOO'")
  child.cmd("Hangman")
  expect.reference_screenshot(child.get_screenshot())

  guess() -- A
  expect.reference_screenshot(child.get_screenshot())

  move_right()
  guess() -- B
  expect.reference_screenshot(child.get_screenshot())

  move_right()
  guess() -- C
  expect.reference_screenshot(child.get_screenshot())

  move_right()
  guess() -- D
  expect.reference_screenshot(child.get_screenshot())

  move_right()
  guess() -- E
  expect.reference_screenshot(child.get_screenshot())

  move_right()
  move_right()
  guess() -- G
  expect.reference_screenshot(child.get_screenshot())

  move_right()
  guess() -- H
  expect.reference_screenshot(child.get_screenshot())

  move_right()
  guess() -- I
  expect.reference_screenshot(child.get_screenshot())

  move_right()
  guess() -- J
  expect.reference_screenshot(child.get_screenshot())

  move_right()
  guess() -- K
  expect.reference_screenshot(child.get_screenshot())

  eq(child.lua("return M.game.state"), "LOST")
end

T["toggles and remembers state"] = function ()
  child.lua("M.game.word = 'ABC'")
  child.cmd("Hangman")
  guess()
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
