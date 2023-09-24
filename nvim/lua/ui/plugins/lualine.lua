return {
    'nvim-lualine/lualine.nvim',
    opts = {
        options = {
            icons_enabled = true,
            theme = 'onedark',
            component_separators = { left = "|", right = "" },
            disabled_filetypes = { "NvimTree", "alpha" },
            fmt = string.lower,
            always_divide_middle = true,
            section_separators = '',
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { { "filename", file_status = false, path = 1 }, "filesize" },
            lualine_c = {},
            lualine_x = {},
            lualine_y = { { "diagnostics", sources = { "nvim_diagnostic" } }, "diff" },
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
    },
}
