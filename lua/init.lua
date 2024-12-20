
package.loaded["game"] = nil
package.loaded["ui"] = nil
package.loaded["autocmd"] = nil

local Ui = require("ui")
local Game = require("game")

local Hangman = {}
Hangman.__index = Hangman

function Hangman:new()
  return setmetatable({
    game = Game:new({
      word = "COUCH",

    }),
    ui = Ui:new({
      relative = "editor",
      width = 50,
      height = 20,
      border = "rounded",
      style = "minimal",
      zindex = 100,
      title = "Hangman",
      title_pos = "center",
    }),
  }, self)
end

function Hangman:toggleUI()
  self.ui:toggle(self.game)
end

local hangman = Hangman:new()

vim.api.nvim_create_user_command("Hangman", function()
  hangman:toggleUI()
end, {})

vim.keymap.set("n", "<leader>t", function()
  hangman:toggleUI()
end)
