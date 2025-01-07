return {
    {
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

            -- markdown specific highlights
            local colors = require("kanagawa.colors").setup()
            vim.api.nvim_set_hl(0, "RenderMarkdownH1Bg", { fg = colors.palette.sakuraPink, bold = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownH2Bg", { fg = colors.palette.crystalBlue, bold = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownH3Bg", { fg = colors.palette.autumnYellow, bold = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownH4Bg", { fg = colors.palette.springViolet1, bold = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownH5Bg", { fg = colors.palette.boatYellow2, bold = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownH6Bg", { fg = colors.palette.autumnRed, bold = true })
            vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = colors.palette.dragonBlack1 })
        end,
    },
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
        ---@module 'render-markdown'
        ---@type render.md.UserConfig
        opts = {

            enabled = true,
            heading = {
                sign = false,
                icons = {},
            },
        },
    },
}
