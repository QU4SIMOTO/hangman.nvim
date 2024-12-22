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

T["default"] = new_set()
T["default"]["works"] = function()
  expect.no_error(function()
    child.cmd("Hangman")
  end)
end

T["toggle"] = new_set()
T["toggle"]["works"] = function()
  expect.no_error(function()
    child.cmd("Hangman toggle")
  end)
end
T["toggle"]["args"] = function()
  expect.error(function()
    child.cmd("Hangman toggle foo")
  end)
  expect.error(function()
    child.cmd("Hangman toggle foo bar")
  end)
end

T["new"] = new_set()
T["new"]["works"] = function()
  expect.no_error(function()
    child.cmd("Hangman new")
  end)
end
T["new"]["args"] = function()
  expect.error(function()
    child.cmd("Hangman new foo")
  end)
  expect.error(function()
    child.cmd("Hangman new foo bar")
  end)
end

T["guess"] = new_set()
T["guess"]["works"] = function()
  expect.no_error(function()
    child.cmd("Hangman guess a")
  end)
  expect.no_error(function()
    child.cmd("Hangman guess b")
  end)
  expect.no_error(function()
    child.cmd("Hangman guess c")
  end)
end
T["guess"]["no args"] = function()
  expect.error(function()
    child.cmd("Hangman guess")
  end)
end
T["guess"]["arg single digit"] = function()
  expect.error(function()
    child.cmd("Hangman guess 1")
  end)
  expect.error(function()
    child.cmd("Hangman guess 2")
  end)
end
T["guess"]["arg single special"] = function()
  expect.error(function()
    child.cmd("Hangman guess @")
  end)
  expect.error(function()
    child.cmd("Hangman guess !")
  end)
end
T["guess"]["arg multiple"] = function()
  expect.error(function()
    child.cmd("Hangman guess abc")
  end)
  expect.error(function()
    child.cmd("Hangman guess 123")
  end)
  expect.error(function()
    child.cmd("Hangman guess a13~")
  end)
end
T["guess"]["args"] = function()
  expect.error(function()
    child.cmd("Hangman guess a a")
  end)
  expect.error(function()
    child.cmd("Hangman guess 1 a")
  end)
  expect.error(function()
    child.cmd("Hangman guess a13~ afd")
  end)
end

return T
