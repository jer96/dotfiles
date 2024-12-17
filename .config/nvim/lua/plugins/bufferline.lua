return {
    "akinsho/bufferline.nvim",
    cond = not vim.g.started_by_firenvim,
    version = "*",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "famiu/bufdelete.nvim",
    },
    opts = {
        options = {
            max_name_length = 25,
            max_prefix_length = 20,
            close_command = "Bdelete! %d",
            close_icon = "󰅖",
            buffer_close_icon = "",
            separator_style = "slant",
            custom_filter = function(buf, _)
                return vim.fn.bufname(buf) ~= ""
            end,
            offsets = {
                {
                    filetype = "NvimTree",
                    highlight = "Directory",
                    separator = true,
                    text = "files",
                    text_align = "center",
                },
            },
        },
    },
}
