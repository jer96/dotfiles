-- reference: https://github.com/jmbuhr/kickstart.nvim-quarto-example
return {
    {
        "benlubas/molten-nvim",
        version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
        dependencies = { "3rd/image.nvim" },
        build = ":UpdateRemotePlugins",
        init = function()
            vim.g.molten_output_win_max_height = 200
            vim.g.molten_image_provider = "image.nvim"
            local palette = require("kanagawa.colors").setup({ theme = "wave" }).palette
            vim.api.nvim_set_hl(0, "MoltenCell", { bg = palette.sumiInk3 })
        end,
    },

    { -- directly open ipynb files as quarto docuements
        -- and convert back behind the scenes
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
        "quarto-dev/quarto-nvim",
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
                    default_method = "molten",
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
        end,
        dependencies = {
            "jmbuhr/otter.nvim",
        },
    },

    { -- send code from python/r/qmd documets to a terminal or REPL
        -- like ipython, R, bash
        "jpalardy/vim-slime",
        dev = false,
        init = function()
            vim.b["quarto_is_python_chunk"] = false
            Quarto_is_in_python_chunk = function()
                require("otter.tools.functions").is_otter_language_context("python")
            end

            vim.cmd([[
            let g:slime_dispatch_ipython_pause = 100
            function SlimeOverride_EscapeText_quarto(text)
                call v:lua.Quarto_is_in_python_chunk()
                if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk && !(exists('b:quarto_is_r_mode') && b:quarto_is_r_mode)
                    return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
                else
                    if exists('b:quarto_is_r_mode') && b:quarto_is_r_mode && b:quarto_is_python_chunk
                        return [a:text, "\n"]
                    else
                        return [a:text]
                    end
                end
                endfunction
                ]])
            vim.g.slime_target = "neovim"
            vim.g.slime_no_mappings = true
            vim.g.slime_python_ipython = 1
        end,
        config = function()
            vim.g.slime_input_pid = false
            vim.g.slime_suggest_default = true
            vim.g.slime_menu_config = false
            vim.g.slime_neovim_ignore_unlisted = true
            local function mark_terminal()
                local job_id = vim.b.terminal_job_id
                vim.print("job_id: " .. job_id)
            end

            local function set_terminal()
                vim.fn.call("slime#config", {})
            end
            vim.keymap.set("n", "<leader>cm", mark_terminal, { desc = "[m]ark terminal" })
            vim.keymap.set("n", "<leader>cs", set_terminal, { desc = "[s]et terminal" })
            vim.keymap.set({ "n", "i" }, "<leader>qj", ":QuartoSend<cr>", { desc = "send code cell to terminal" })
            vim.keymap.set(
                { "n", "i" },
                "<leader>qja",
                ":QuartoSendAll<cr>",
                { desc = "send all code cells to terminal" }
            )
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
                { desc = "[c]ode repl [i]python v split" }
            )
            vim.keymap.set({ "n" }, "<leader>qp", ":QuartoPreview<cr>", { desc = "open [q]uarto [p]review" })
            vim.keymap.set({ "n" }, "<leader>qcp", ":QuartoClosePreview<cr>", { desc = "[c]lose [q]uarto [p]review" })
        end,
    },
}
