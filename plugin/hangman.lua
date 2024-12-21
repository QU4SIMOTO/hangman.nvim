vim.api.nvim_create_user_command("Hangman", function()
  local hangman = require"hangman"
  hangman:toggleUI()
end, {})
