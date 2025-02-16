return {
    "sindrets/diffview.nvim",
    lazy = false,
    keys = {
        { "<leader>df", "<cmd>DiffviewOpen<cr><cmd>DiffviewToggleFiles<cr>", desc = "Open Inline Diffview" },
        { "<leader>dx", "<cmd>DiffviewClose<cr>", desc = "Close Diffview" },
    },
    config = function()
        local colors = require("kanagawa.colors").setup()
        vim.api.nvim_set_hl(0, "DiffAdd", { bg = colors.palette.winterGreen })
        vim.api.nvim_set_hl(0, "DiffDelete", { bg = colors.palette.winterRed })
        vim.api.nvim_set_hl(0, "DiffChange", { bg = colors.palette.winterBlue })
        vim.api.nvim_set_hl(0, "DiffText", { bg = colors.palette.winterYellow, blend = 40 })
        require("diffview").setup({
            enhanced_diff_hl = true,
        })
    end,
}
