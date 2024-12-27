return {
    {
        "stevearc/conform.nvim",
        enabled = true,
        config = function ()
            require("conform").setup({
                notify_on_error = false,
                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
                formatters_by_ft = {
                    lua = { "mystylua" },
                    python = { "myruff" },
                    quarto = { "injected" },
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
            -- Customize the "injected" formatter
            require("conform").formatters.injected = {
                -- Set the options field
                options = {
                    -- Set to true to ignore errors
                    ignore_errors = false,
                    -- Map of treesitter language to file extension
                    -- A temporary file name with this extension will be generated during formatting
                    -- because some formatters care about the filename.
                    lang_to_ext = {
                        bash = "sh",
                        javascript = "js",
                        latex = "tex",
                        markdown = "md",
                        python = "py",
                        rust = "rs",
                        typescript = "ts",
                    },
                    -- Map of treesitter language to formatters to use
                    -- (defaults to the value from formatters_by_ft)
                    lang_to_formatters = {},
                },
            }
        end,
    },
}
