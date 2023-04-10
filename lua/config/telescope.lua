-- Configuration

local config = {
    defaults = {
        mappings = {
            i = {
                ["jk"] = {"<esc>", type = "command"}
            },
            n = {
                ["q"] = {"<esc>", type = "command"}
            }
        }
    }
}

require("telescope").setup(config)
