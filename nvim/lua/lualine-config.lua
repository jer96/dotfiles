require'lualine'.setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        section_separators = '',
        component_separators = {left = '|', right = ''},
        disabled_filetypes = {},
        fmt = string.lower,
        always_divide_middle = true
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {{'filename', file_status = false, path = 1}, 'filesize'},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {{'diagnostics', sources = {'nvim_lsp', 'nvim'}}},
        lualine_z = {'branch', 'diff'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
