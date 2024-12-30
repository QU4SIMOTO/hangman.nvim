<h1 align="center">
  Hangman.nvim
  <br>
</h1>

<h4 align="center">A simple <a href="https://neovim.io/" target="_blank">Neovim</a> plugin to play hangman</h4>

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim%200.8+-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)

![screenshot](https://github.com/QU4SIMOTO/hangman.nvim/blob/main/assets/hangman.gif)

## Installation

### Using [lazy.nvim](https://github.com/folke/lazy.nvim)

To install `hangman.nvim`, you can add the following to your Neovim configuration:

```lua
{ "QU4SIMOTO/hangman.nvim" }
```

### Using [Packer](https://github.com/wbthomason/packer.nvim)

Alternatively, if you use Packer, you can install the plugin like this:

```lua
use 'QU4SIMOTO/hangman.nvim'
```

## How to Use

### Starting the Game

To start a game of Hangman in Neovim, run the following command:

```vim
:Hangman
```

This will toggle the the Hangman game interface open in a floating window inside Neovim, where you can start playing!

- Game Interface: The game will display a series of underscores (_) representing the letters of the word you need to guess.
- Guessing Letters: Use your cursor keys (`h`, `j`, `k`, `l`) or arrow keys to move to a letter of your choice, then press `<CR>` (Enter) to select that letter.
- Incorrect Guesses: Each time you make an incorrect guess, a part of the hangman figure will be drawn. Be careful not to let it complete!
- Correct Guesses: When you guess a letter correctly, it will appear in the word, helping you narrow down your guesses.

### Minimizing the Game

To minimize the Hangman game interface either unfocus the window or use the command:

```vim
:Hangman
```

To reopen the game run the same command and the game will resume from where you were.

### Starting a New Game

To start a new game with a completely random word, use:

```vim
:Hangman new
```

This command resets the game, generates a new word to guess, and starts the game over with a fresh hangman figure.

## Testing

### Overview
Hangman.nvim uses [MiniTest](https://github.com/echasnovski/mini.test) to run unit tests and ensure that the plugin works as expected. This section will guide you on how to run the tests, lint the code, and format it for consistency.

### Running the Tests

1. **Install Dependencies**: Make sure you have Neovim and the necessary dependencies installed, including make and lua.
2. **Run the Tests**: Use the following command to run the full test suite:

```shell
make test
```

This command will run Neovim in headless mode, meaning without any user interface, and execute the tests defined in the plugin. The output will be displayed in your terminal.

### Test Output

When the tests complete, you will see output similar to this:
```
Total number of cases: 20
Total number of groups: 4

tests/test_command.lua: ooooooooooo
tests/test_hangman.lua: o
tests/test_ui.lua: ooooo
tests/test_util.lua: ooo

Fails (0) and Notes (0)
```

## License

MIT

## TODO
- add help page
- add healtcheck
- support guessing full word
