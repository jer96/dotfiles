return {
    "echasnovski/mini.nvim",
    version = "main",
    config = function()
        require("mini.ai").setup({})
        require("mini.surround").setup({})
        require("mini.comment").setup({})
        require("mini.pairs").setup({})
        require("mini.move").setup({
            mappings = {
                left = "<M-C-h>",
                right = "<M-C-l>",
                down = "<M-C-j>",
                up = "<M-C-k>",

                -- Move current line in Normal mode
                line_left = "<M-C-h>",
                line_right = "<M-C-l>",
                line_down = "<M-C-j>",
                line_up = "<M-C-k>",
            },
        })
    end,
}
