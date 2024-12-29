return {

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
    {
        "GCBallesteros/jupytext.nvim",
        opts = {
            style = "markdown",
            output_extension = "md",
            force_ft = "markdown",
            custom_language_formatting = {
                python = {
                    extension = "qmd",
                    style = "quarto",
                    force_ft = "quarto",
                },
                r = {
                    extension = "qmd",
                    style = "quarto",
                    force_ft = "quarto",
                },
            },
        },
    },
    {
        "3rd/image.nvim",
        opts = {
            processor = "magick_cli",
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    floating_windows = false,
                },
            },
            -- max_width = 100,
            -- max_height = 100,
            max_height_window_percentage = math.huge,
            max_width_window_percentage = math.huge,
            window_overlap_clear_enabled = true,
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        },
    },
    {
        "Vigemus/iron.nvim",
        config = function()
            local iron = require("iron.core")
            local view = require("iron.view")

            iron.setup({
                config = {
                    -- Whether a repl should be discarded or not
                    scratch_repl = true,
                    -- Your repl definitions come here
                    repl_definition = {
                        sh = {
                            -- Can be a table or a function that
                            -- returns a table (see below)
                            command = { "zsh" },
                        },
                        python = {
                            command = { "ipython", "--no-autoindent" }, -- { "python3" }
                            format = require("iron.fts.common").bracketed_paste_python,
                        },
                    },
                    repl_open_cmd = view.split.vertical.botright(0.61903398875),
                },
                -- Iron doesn't set keymaps by default anymore.
                -- You can set them here or manually add keymaps to the functions in iron.core
                keymaps = {
                    send_motion = "<space>sc",
                    visual_send = "<space>sc",
                    send_file = "<space>sf",
                    send_line = "<space>sl",
                    send_paragraph = "<space>sp",
                    send_until_cursor = "<space>su",
                    send_mark = "<space>sm",
                    mark_motion = "<space>mc",
                    mark_visual = "<space>mc",
                    remove_mark = "<space>md",
                    cr = "<space>s<cr>",
                    interrupt = "<space>s<space>",
                    exit = "<space>sq",
                    clear = "<space>cl",
                },
                -- If the highlight is on, you can change how it looks
                -- For the available options, check nvim_set_hl
                highlight = {
                    italic = true,
                },
                ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
            })

            -- iron also has a list of commands, see :h iron-commands for all available commands
            vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")
            vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
            vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
            vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
        end,
    },

    {
        "quarto-dev/quarto-nvim",
        dependencies = {
            "jmbuhr/otter.nvim",
        },
        ft = { "quarto" },
        dev = false,
        config = function()
            local quarto = require("quarto")
            quarto.setup({
                lspFeatures = {
                    languages = { "python" },
                    chunks = "all",
                    diagnostics = {
                        enabled = true,
                        triggers = { "BufWritePost" },
                    },
                    completion = {
                        enabled = true,
                    },
                },
                keymap = {
                    hover = "H",
                    definition = "gd",
                    rename = "<leader>rn",
                    references = "gr",
                    format = "<leader>ff",
                },
                codeRunner = {
                    enabled = true,
                    -- default_method = "molten",
                    default_method = "iron",
                },
            })

            local runner = require("quarto.runner")
            vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
            vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
            vim.keymap.set("n", "<localleader>mr", runner.run_all, { desc = "run all cells", silent = true })
            vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
            vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
            vim.keymap.set("n", "<localleader>M", function()
                runner.run_all(true)
            end, { desc = "run all cells of all languages", silent = true })

            vim.keymap.set(
                { "n", "i" },
                "<leader>qi",
                "<esc>i```{python}<cr>```<esc>O",
                { desc = "[i]nsert code chunk" }
            )
            vim.keymap.set({ "n" }, "<leader>qt", ":vs  term://ipython<cr>", { desc = "[c]ode repl [i]python" })
            vim.keymap.set(
                { "n" },
                "<leader>qth",
                ":split  term://ipython<cr>",
                { desc = "[c]ode repl [i]python split" }
            )
            vim.keymap.set({ "n" }, "<leader>qp", ":QuartoPreview<cr>", { desc = "open [q]uarto [p]review" })
            vim.keymap.set({ "n" }, "<leader>qcp", ":QuartoClosePreview<cr>", { desc = "[c]lose [q]uarto [p]review" })
        end,
    },
}
