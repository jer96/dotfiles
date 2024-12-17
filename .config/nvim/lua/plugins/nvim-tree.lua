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
    opts = {
        disable_netrw = true,
        git = {
            ignore = false,
        },
        filters = {
            custom = {
                "^.git$",
                ".CFUserTextEncoding",
                ".Trash",
                ".DS_Store",
                ".cache",
                ".local",
                ".lesshst",
                ".npm",
                "Applications",
                "Desktop",
                "Downloads",
                "Documents",
                "Library",
                "Music",
                "Movies",
                "Public",
                "Pictures",
            },
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
    },
    keys = {
        { "<leader>t", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file explorer" },
        { "<leader>r", "<cmd>NvimTreeRefresh<CR>", desc = "Refresh file explorer" },
    },
}
