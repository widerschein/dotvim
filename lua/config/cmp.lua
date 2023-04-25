local cmp = require("cmp")

-- Helpers

-- Get loaded buffers of max line count
local get_buffers_max_lines = function(max_lines)
    return vim.tbl_filter(
        function(buf)
            local line_count = vim.api.nvim_buf_line_count(buf)
            return line_count > 0 and line_count < max_lines
        end,
        vim.api.nvim_list_bufs()
    )
end

-- Configuration

cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<C-e>"] = cmp.mapping.abort(),
    }),
    sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "ultisnips" },
        },
        {
            {
                name = "buffer",
                option = {
                    get_bufnrs = function()
                        return get_buffers_max_lines(8000)
                    end
                }
            },
            { name = "path" }
        }),
    preselect = cmp.PreselectMode
})
