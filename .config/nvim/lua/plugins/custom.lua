return {
    {
        dir = "~/nvim-plugins/agent.nvim",
        dev = true,
        build = ":UpdateRemotePlugins",
        config = function()
            require("agent").setup({})
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<leader>aa", ":lua vim.fn.AgentToggle()<CR>", opts)
        end,
    },
}
