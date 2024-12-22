local new_set = MiniTest.new_set
local eq = MiniTest.expect.equality
local pad_and_center = require("hangman.util").pad_and_center

local T = new_set()

T["pad_and_center()"] = new_set()

T["pad_and_center()"]["empty"] = function()
  eq(pad_and_center("", 1), "")
  eq(pad_and_center("", 3), " ")
end

T["pad_and_center()"]["single"] = function()
  eq(pad_and_center("a", 1), "a")
  eq(pad_and_center("a", 2), "a")
  eq(pad_and_center("a", 3), " a")
  eq(pad_and_center("a", 4), " a")
  eq(pad_and_center("a", 5), "  a")
end

T["pad_and_center()"]["double"] = function()
  eq(pad_and_center("ab", 1), "ab")
  eq(pad_and_center("ab", 2), "ab")
  eq(pad_and_center("ab", 3), "ab")
  eq(pad_and_center("ab", 4), " ab")
  eq(pad_and_center("ab", 5), " ab")
  eq(pad_and_center("ab", 6), "  ab")
end

return T
