return {
    "mhartington/formatter.nvim",
    cond = not vim.g.started_by_firenvim,
    config = function()
        require("formatter").setup({
            logging = true,
            log_level = vim.log.levels.WARN,
            filetype = {
                lua = {
                    require("formatter.filetypes.lua").stylua,
                },
                json = {
                    require("formatter.filetypes.json").prettier,
                },
                typescript = {
                    require("formatter.filetypes.typescript").prettier,
                },
                html = {
                    require("formatter.filetypes.html").prettier,
                },
                kotlin = {
                    require("formatter.filetypes.kotlin").ktlint,
                },
                go = {
                    require("formatter.filetypes.go").gofumpt,
                },
                python = {
                    require("formatter.filetypes.python").black(),
                    require("formatter.filetypes.python").autoflake(),
                    require("formatter.filetypes.python").isort(),
                },
                ["*"] = {
                    require("formatter.filetypes.any").remove_trailing_whitespace(),
                },
            },
        })
        local augroup = vim.api.nvim_create_augroup
        local autocmd = vim.api.nvim_create_autocmd
        augroup("__formatter__", { clear = true })
        autocmd("BufWritePost", {
            group = "__formatter__",
            pattern = "*",
            callback = function()
                if vim.bo.filetype ~= "kotlin" then
                    vim.cmd(":FormatWrite")
                end
            end,
        })
    end,
}
