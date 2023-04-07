--Helpers

-- Extensions

local dirvish_extension = {
    filetypes = {"dirvish"},
    sections = {
        lualine_c = {
            {
                "filename",
                newfile_status = true,
                path = 2
            }
        },
        lualine_z = {"filetype"}
    }
}

-- Configuration

local config = {
    options = {
        component_separators = "",
        section_separators = "",
        disabled_filetypes = {
            statusline = {"tagbar"}
        }
    },
    extensions = {
        "quickfix",
        "fugitive",
        "fzf",
        dirvish_extension,
        tagbar_extension
    },
    sections = {
        lualine_a = {
            {
                "mode",
                fmt = function(m) return m:sub(1,1) end
            }
        },
        lualine_b = {
            "'ॐ'",
            "location",
            "%L"
        },
        lualine_c = {
            {
                "filename",
                newfile_status = true,
                path = 3
            }
        },
        lualine_x = {},
        lualine_y = {"FugitiveHead"},
        lualine_z = {"filetype"}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {"filename"},
        lualine_x = {"location"},
        lualine_y = {},
        lualine_z = {}
    }
}

require("lualine").setup(config)
