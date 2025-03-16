return {
    {
        "stevearc/conform.nvim",
        enabled = true,
        config = function()
            -- Customize the "injected" formatter
            local conform = require("conform")

            -- Store the original format function
            local original_format = conform.format

            -- Override the format function to preserve cursor position
            ---@diagnostic disable-next-line: duplicate-set-field
            conform.format = function(opts)
                -- Save cursor position
                local view = vim.fn.winsaveview()

                -- Call original format function
                local result = original_format(opts)

                -- Restore cursor position
                vim.fn.winrestview(view)

                return result
            end

            conform.setup({
                notify_on_error = false,
                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
                formatters_by_ft = {
                    lua = { "mystylua" },
                    python = { "myruff" },
                    quarto = { "injected" },
                    typescript = { "prettier" },
                    javascript = { "prettier" },
                },
                formatters = {
                    mystylua = {
                        command = "stylua",
                        args = { "--indent-type", "Spaces", "--indent-width", "2", "-" },
                    },
                    myruff = {
                        command = "ruff format",
                    },
                },
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "python",
                callback = function()
                    vim.keymap.set("n", "<leader>ci", function()
                        vim.lsp.buf.code_action({
                            filter = function(action)
                                return action.title == "Ruff: Fix all auto-fixable problems"
                            end,
                            apply = true,
                        })
                    end, { buffer = true, desc = "Auto-fix Ruff checks" })
                end,
            })
        end,
    },
}
