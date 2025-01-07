return {
    {
        dir = "~/nvim-plugins/agent.nvim",
        dev = true,
        build = ":UpdateRemotePlugins",
        config = function()
            require("agent").setup({})
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<leader>aa", ":lua vim.fn.AgentToggle()<CR>", opts)
        end,
    },
    {
        dir = "~/nvim-plugins/present.nvim",
    },
    {
        dir = "~/nvim-plugins/molten-nvim",
        -- "benlubas/molten-nvim",
        -- version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_output_win_max_height = 200
            vim.g.molten_image_provider = "image.nvim"
            local palette = require("kanagawa.colors").setup({ theme = "wave" }).palette
            vim.api.nvim_set_hl(0, "MoltenCell", { bg = palette.sumiInk3 })
            vim.keymap.set("v", "<leader>m", function()
                -- Get start and end positions of the visual selection
                local start_line = vim.fn.line("'<")
                local end_line = vim.fn.line("'>")
                vim.fn.MoltenEvaluateRange(start_line, end_line)
            end)

            vim.keymap.set("n", "<leader>mb", function()
                local last_line = vim.api.nvim_buf_line_count(0)
                vim.fn.MoltenEvaluateRange(1, last_line)
            end)
            vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
            vim.keymap.set(
                "n",
                "<localleader>me",
                ":MoltenEvaluateOperator<CR>",
                { silent = true, desc = "run operator selection" }
            )
            vim.keymap.set("n", "<localleader>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
            vim.keymap.set(
                "n",
                "<localleader>rr",
                ":MoltenReevaluateCell<CR>",
                { silent = true, desc = "re-evaluate cell" }
            )
            vim.keymap.set("n", "<localleader>rd", ":MoltenDelete<CR>", { silent = true, desc = "molten delete cell" })
            vim.keymap.set("n", "<localleader>mh", ":MoltenHideOutput<CR>", { silent = true, desc = "hide output" })
            vim.keymap.set(
                "n",
                "<localleader>mo",
                ":noautocmd MoltenEnterOutput<CR>",
                { silent = true, desc = "show/enter output" }
            )
        end,
    },
}
