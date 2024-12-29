local create_theme_colors = function()
    local dragon_colors = require("kanagawa.colors").setup({ theme = "dragon" })
    local palette = dragon_colors.palette
    local theme = dragon_colors.theme
    local custom_dragon = {
        normal = {
            a = { bg = palette.dragonGray, fg = theme.ui.bg, gui = "bold" },
            b = { bg = theme.ui.bg, fg = palette.dragonGray },
            c = { bg = theme.ui.bg, fg = palette.dragonGray },
        },
        insert = {
            a = { bg = palette.springGreen, fg = theme.ui.bg, gui = "bold" },
            b = { bg = theme.ui.bg, fg = palette.dragonGray },
            c = { bg = theme.ui.bg, fg = palette.dragonGray },
        },
        visual = {
            a = { bg = palette.surimiOrange, fg = theme.ui.bg, gui = "bold" },
            b = { bg = theme.ui.bg, fg = palette.dragonGray },
            c = { bg = theme.ui.bg, fg = palette.dragonGray },
        },
        command = {
            a = { bg = palette.crystalBlue, fg = theme.ui.bg, gui = "bold" },
            b = { bg = theme.ui.bg, fg = palette.dragonGray },
            c = { bg = theme.ui.bg, fg = palette.dragonGray },
        },
        inactive = {
            a = { bg = theme.ui.bg, fg = theme.ui.fg, gui = "bold" },
            b = { bg = theme.ui.bg, fg = palette.dragonGray },
            c = { bg = theme.ui.bg, fg = palette.dragonGray },
        },
    }
    local kanagawa_theme = require("lualine.themes.kanagawa")
    kanagawa_theme.normal = custom_dragon.normal
    kanagawa_theme.insert = custom_dragon.insert
    kanagawa_theme.visual = custom_dragon.visual
    kanagawa_theme.command = custom_dragon.command
    kanagawa_theme.inactive = custom_dragon.inactive
    return kanagawa_theme
end

return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local symbols = { error = " ", warn = " ", hint = "󰮥 ", info = "" }
        local options = {
            icons_enabled = true,
            theme = create_theme_colors,
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
                lualine_a = {
                    {
                        "mode",
                        fmt = function(str)
                            return string.lower(str:sub(1, 1))
                        end,
                    },
                },
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
