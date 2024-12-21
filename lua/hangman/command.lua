local hangman = require("hangman")

local M = {}
local default_key = "toggle"

---@class HangmanSubcommand
---@field impl fun(args:string[], opts: table) The command implementation
---@field complete? fun(subcmd_arg_lead: string): string[] (optional) Command completions callback, taking the lead of the subcommand's arguments

---@type table<string, HangmanSubcommand>
M.subcommand_tbl = {
  toggle = {
    impl = function()
      hangman:toggle_ui()
    end,
  },
  guess = {
    impl = function(args)
      if #args == 0 then
        vim.notify("Hangman guess: missing argument", vim.log.levels.ERROR)
        return
      end
      if #args > 1 then
        vim.notify("Hangman guess: too many arguments", vim.log.levels.ERROR)
        return
      end

      local c = args[1]
      if #c ~= 1 then
        vim.notify("Hangman guess: invalid guess must be a single char", vim.log.levels.ERROR)
        return
      end
      if c:match("%A") then
        vim.notify("Hangman guess: guess must be a char", vim.log.levels.ERROR)
        return
      end
      hangman:guess(c:upper())
    end
  },
  new = {
    impl = function()
      hangman:new_game()
    end
  }
}

---@param opts table :h lua-guide-commands-create
M.cmd = function(opts)
  local fargs = opts.fargs
  local subcommand_key = fargs[1] or default_key
  local args = #fargs > 1 and vim.list_slice(fargs, 2, #fargs) or {}
  local subcommand = M.subcommand_tbl[subcommand_key]
  if not subcommand then
    vim.notify("Hangman: Unknown command: " .. subcommand_key, vim.log.levels.ERROR)
    return
  end
  subcommand.impl(args, opts)
end

return M
