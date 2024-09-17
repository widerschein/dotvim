local lspconfig = require("lspconfig")
local null_ls = require("null-ls")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local null_sources = {}

-- Lua

lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

-- C++

lspconfig.clangd.setup({
    capabilities = capabilities,
    cmd = { "clangd", "--header-insertion-decorators=false", "--log=error" } -- fix item indent
})

-- Bash

lspconfig.bashls.setup({
    capabilities = capabilities
})

-- TypeScript/JavaScript

lspconfig.ts_ls.setup({
    capabilities = capabilities
})

lspconfig.eslint.setup({})

table.insert(null_sources, null_ls.builtins.formatting.prettier)

-- CSS

lspconfig.cssls.setup({
    capabilities = capabilities
})

-- Python

lspconfig.pylsp.setup({
    capabilities = capabilities
})

table.insert(null_sources, null_ls.builtins.formatting.black)

-- Go

lspconfig.gopls.setup({
    capabilities = capabilities
})


null_ls.setup({
    sources = null_sources
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
