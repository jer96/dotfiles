return {
    {
        dir = "~/nvim-plugins/agent.nvim",
        dev = true,
        build = ":UpdateRemotePlugins",
        config = function()
            require("agent").setup({})
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap("n", "<leader>aa", ":AgentToggle<CR>", opts)
            vim.api.nvim_set_keymap("n", "<leader>ac", ":AgentContext<CR>", opts)
        end,
    },
}
