return {
  augroups = {
    game_update = vim.api.nvim_create_augroup("HangmanGameUpdate", {}),
    guess = vim.api.nvim_create_augroup("HangmanGuess", {})
  },
  event = "User",
}

