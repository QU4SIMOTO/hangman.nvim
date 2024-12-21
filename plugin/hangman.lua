local command = require("hangman.command")

vim.api.nvim_create_user_command("Hangman", command.cmd, {
    nargs = "*",
    desc = "Hangman command",
    complete = function(arg_lead, cmdline, _)
        local subcmd_key, subcmd_arg_lead = cmdline:match("^['<,'>]*Hangman[!]*%s(%S+)%s(.*)$")
        if subcmd_key
            and subcmd_arg_lead
            and command.subcommand_tbl[subcmd_key]
            and command.subcommand_tbl[subcmd_key].complete
        then
            -- The subcommand has completions. Return them.
            return command.subcommand_tbl[subcmd_key].complete(subcmd_arg_lead)
        end

        -- Check if cmdline is a subcommand
        if cmdline:match("^['<,'>]*Hangman[!]*%s+%w*$") then
            local subcommand_keys = vim.tbl_keys(command.subcommand_tbl)
            return vim.iter(subcommand_keys)
                :filter(function(key)
                    return key:find(arg_lead) ~= nil
                end)
                :totable()
        end
    end,
    bang = false,
})
