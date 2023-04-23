local plugin_script_source = "~/.vim/plugins.py"

vim.api.nvim_create_user_command(
    "PluginsInit",
    function()
        vim.cmd("te " .. plugin_script_source .. " init")
    end, {}
)

vim.api.nvim_create_user_command(
    "PluginsUpdate",
    function()
        vim.cmd("te " .. plugin_script_source .. " update")
    end, {}
)
