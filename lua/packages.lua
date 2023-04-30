local plugin_script_source = "~/.vim/plugins.py"

local args = {"fetch", "prune"}

vim.api.nvim_create_user_command(
    "Plugins",
    function(opt)
        if opt.args == "" then
            vim.cmd("Dirvish ~/.vim/pack/plugins/start")
        elseif vim.tbl_contains(args, opt.args) then
            vim.cmd("te " .. plugin_script_source .. " " .. opt.args)
        end
    end,
    {
        nargs = "?",
        complete = function(_, _, _)
            return args
        end
    }
)
