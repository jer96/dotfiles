return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1001,
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("kanagawa").setup({
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = "none",
                        },
                    },
                },
            },
            overrides = function(colors)
                -- https://github.com/rebelot/kanagawa.nvim#color-palette
                return {
                    Statement = { fg = colors.palette.sakuraPink },
                    Keyword = { fg = colors.palette.sakuraPink },
                    Constant = { fg = colors.palette.oldWhite },
                }
            end,
        })
        vim.cmd("colorscheme kanagawa-dragon")
    end,
}
