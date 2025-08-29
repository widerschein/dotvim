require("codecompanion").setup({
    adapters = {
        http = {
            llama3 = function()
                return require("codecompanion.adapters").extend("ollama", {
                    name = "llama3",
                    schema = {
                        model = {
                            default = "llama3.2:latest"
                        }
                    }
                })
            end
        }
    },
    strategies = {
        chat = {
            adapter = "llama3"
        }
    }
})
