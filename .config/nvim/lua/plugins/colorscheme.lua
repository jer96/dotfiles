return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1001,
    config = function()
        require("kanagawa").setup({
            theme = "dragon",
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
        vim.o.background = ""
        vim.cmd("colorscheme kanagawa")

        local colors = require("kanagawa.colors").setup()
        local palette_colors = colors.palette
        vim.api.nvim_set_hl(0, "CursorLine", { bg = palette_colors.sumiInk3 })
        vim.api.nvim_set_hl(0, "Visual", { bg = palette_colors.winterGreen, fg = "NONE", bold = true })
    end,
}
