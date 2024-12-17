return {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    opts = {
        -- See `:help gitsigns.txt`
        signs = {
            add = { text = "▎" },
            change = { text = "▎" },
            delete = { text = "_" },
            topdelete = { text = "‾" },
            changedelete = { text = "▎" },
        },
        on_attach = function(bufnr)
            vim.keymap.set(
                "n",
                "<leader>hp",
                require("gitsigns").preview_hunk,
                { buffer = bufnr, desc = "Preview git hunk" }
            )
            vim.keymap.set(
                "n",
                "<leader>hR",
                require("gitsigns").reset_buffer,
                { buffer = bufnr, desc = "Reset buffer" }
            )
            vim.keymap.set(
                { "n", "v" },
                "<leader>hr",
                require("gitsigns").reset_hunk,
                { buffer = bufnr, desc = "Reset git hunk" }
            )
            vim.keymap.set("n", "<leader>hb", require("gitsigns").blame_line, { buffer = bufnr, desc = "Blame line" })
            vim.keymap.set("n", "<leader>hf", require("gitsigns").next_hunk, { buffer = bufnr, desc = "Next git hunk" })
            vim.keymap.set(
                "n",
                "<leader>hF",
                require("gitsigns").prev_hunk,
                { buffer = bufnr, desc = "Previous git hunk" }
            )
        end,
    },
}
