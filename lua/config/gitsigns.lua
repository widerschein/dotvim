local config = {
    on_attach = function()
        local gitsigns = require("gitsigns")

        vim.keymap.set("n", "<leader>hp", function()
            gitsigns.nav_hunk("prev", { preview = true })
        end)
        vim.keymap.set("n", "<leader>hn", function()
            gitsigns.nav_hunk("next", { preview = true })
        end)
    end
}

require("gitsigns").setup(config)
