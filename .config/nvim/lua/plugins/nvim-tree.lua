return {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    config = function(_, opts)
        require("nvim-tree").setup(opts)
        -- Auto open when starting neovim without a file argument
        vim.api.nvim_create_autocmd({ "VimEnter" }, {
            callback = function()
                if vim.fn.argc() == 0 and not vim.fn.exists("s:std_in") then
                    require("nvim-tree.api").tree.open()
                end
            end,
        })
    end,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = function()
        local utils = require("config.utils")
        return {
            disable_netrw = true,
            git = {
                ignore = false,
                timeout = 800,
            },
            filters = {
                custom = utils.ignored_patterns,
            },
            renderer = {
                root_folder_label = ":t",
                icons = {
                    show = {
                        file = true,
                        folder = true,
                        folder_arrow = true,
                        git = true,
                    },
                },
            },
            view = {
                adaptive_size = true,
                width = 30,
            },
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },
            filesystem_watchers = {
                enable = true,
            },
        }
    end,
    keys = {
        { "<leader>t", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
        { "<leader>r", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file explorer" },
    },
}
