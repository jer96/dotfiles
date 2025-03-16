return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cond = not vim.g.started_by_firenvim,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local utils = require("config.utils")
        require("telescope").setup({
            defaults = {
                file_ignore_patterns = utils.ignored_patterns,
                prompt_prefix = "  ",
                selection_caret = "  ",
                entry_prefix = "  ",
                mappings = {
                    i = {
                        ["<C-u>"] = false,
                        ["<C-d>"] = false,
                    },
                },
            },
        })

        -- Enable telescope fzf native, if installed
        pcall(require("telescope").load_extension, "fzf")
        pcall(require("telescope").load_extension, "ascii")

        local builtin = require("telescope.builtin")
        local themes = require("telescope.themes")
        -- See `:help telescope.builtin`
        vim.keymap.set("n", "<leader><space>", function()
            builtin.find_files({
                no_ignore = true,
                hidden = true,
            })
        end, { desc = "find files" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "find buffers" })
        vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "find git files" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "search help tags" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "grep" })
        vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "resume grep search" })
        vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "show diagnostics" })
        vim.keymap.set("n", "<leader>fs", builtin.grep_string, { desc = "search word" })
        vim.keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "find old files" })
        vim.keymap.set("n", "<leader>ch", builtin.command_history, { desc = "command history" })
        vim.keymap.set("n", "<leader>sh", builtin.search_history, { desc = "search history" })
        vim.keymap.set("n", "<leader>/", function()
            builtin.current_buffer_fuzzy_find(themes.get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, { desc = "fuzzy search buffer" })
    end,
}
