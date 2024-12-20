return {
  augroups = {
    ui = vim.api.nvim_create_augroup("HangmanUI", {}),
    guess = vim.api.nvim_create_augroup("HangmanGuess", {}),
  },
  event = "User",
}
