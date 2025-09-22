local null_ls = require("null-ls")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Lua

vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})
vim.lsp.enable("lua_ls")

-- C++

vim.lsp.config("clangd", {
    capabilities = capabilities,
    cmd = { "clangd", "--header-insertion-decorators=false", "--log=error" } -- fix item indent
})
vim.lsp.enable("clangd")

-- Bash

vim.lsp.config("bashls", {
    capabilities = capabilities
})
vim.lsp.enable("bashls")

-- TypeScript/JavaScript

vim.lsp.config("ts_ls", {
    capabilities = capabilities
})
vim.lsp.enable("ts_ls")

vim.lsp.config("eslint", {})
vim.lsp.enable("eslint")

-- CSS

vim.lsp.config("cssls", {
    capabilities = capabilities
})
vim.lsp.enable("cssls")

-- Python

vim.lsp.config("pylsp", {
    capabilities = capabilities
})
vim.lsp.enable("pylsp")

-- Go

vim.lsp.config("gopls", {
    capabilities = capabilities
})
vim.lsp.enable("gopls")


null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.prettier,
    }
})


vim.keymap.set("n", "<leader>d", vim.diagnostic.setloclist)

-- Buffer-local mappings after LSP attach
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),

    callback = function(ev)
        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>lw", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, opts)
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, opts)
        vim.keymap.set({ "n", "v" }, "<leader>lf", function()
            vim.lsp.buf.format { async = true }
        end, opts)

        vim.api.nvim_buf_create_user_command(
            ev.buf,
            "Rename",
            function(opt)
                vim.lsp.buf.rename(opt.args)
            end,
            { nargs = 1 })
    end
})
