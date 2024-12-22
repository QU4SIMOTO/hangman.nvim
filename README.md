<h1 align="center">
  Hangman.nvim
  <br>
</h1>

<h4 align="center">A simple <a href="https://neovim.io/" target="_blank">Neovim</a> plugin to play hangman</h4>

[![Lua](https://img.shields.io/badge/Lua-blue.svg?style=for-the-badge&logo=lua)](http://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim%200.8+-green.svg?style=for-the-badge&logo=neovim)](https://neovim.io)

![screenshot](https://github.com/QU4SIMOTO/hangman.nvim/blob/main/assets/hangman.gif)

## Install

Install example using [lazy.nvim](https://github.com/folke/lazy.nvim)
```lua
{ "QU4SIMOTO/hangman.nvim" },
```

## How To Use

Run the hangman command to open the UI and begin playing:
```
:Hangman
```
Move the cursor to your desired char and the press `<CR>` to select it.

To start a new game and generate a new word use
```
:Hangman new
```

## Testing
Uses [mini.test](https://github.com/echasnovski/mini.test) for testing.

Run all tests:
```shell
$make test
nvim --headless --noplugin -u ./scripts/minimal_init.lua -c "lua MiniTest.run()"
Total number of cases: 20
Total number of groups: 4

tests/test_command.lua: ooooooooooo
tests/test_hangman.lua: o
tests/test_ui.lua: ooooo
tests/test_util.lua: ooo

Fails (0) and Notes (0)
```

Run linter:
```shell
make lint
```

Run formatter:
```shell
make fmt
```

## License

MIT

## TODO
- add help page
