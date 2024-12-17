return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local symbols = { error = " ", warn = " ", hint = "ﯦ ", info = "" }
        local options = {
            icons_enabled = true,
            theme = "kanagawa",
            component_separators = { left = "|", right = "" },
            disabled_filetypes = { "NvimTree", "alpha" },
            fmt = function(str)
                if vim.bo.filetype == "kotlin" or vim.bo.filetype == "java" then
                    return str
                else
                    return string.lower(str)
                end
            end,
            always_divide_middle = true,
            section_separators = "",
        }
        local default_opts = {
            options = options,
            sections = {
                lualine_a = { "mode" },
                lualine_b = { { "filename", file_status = false, path = 1 }, "filesize" },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {
                    { "diagnostics", symbols = symbols, sources = { "nvim_diagnostic" } },
                    "diff",
                    "location",
                },
                lualine_z = { "branch" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        }
        local firenvim_opts = {
            options = options,
            sections = {
                lualine_a = { { "mode" } },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        }
        local lualine = require("lualine")
        if vim.g.started_by_firenvim then
            lualine.setup(firenvim_opts)
        else
            lualine.setup(default_opts)
        end
    end,
}
