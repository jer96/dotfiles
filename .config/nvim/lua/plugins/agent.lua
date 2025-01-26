return {
    {
        dir = "~/nvim-plugins/agent.nvim",
        dev = true,
        build = ":UpdateRemotePlugins",
        config = function()
            require("agent").setup({
                model_provider = "anthropic",
                storage = {
                    enabled = true,
                    path = "/Users/jeremiahbill/nvim-plugins/conversations",
                },
            })

            vim.keymap.set("n", "<leader>aa", ":AgentToggle<CR>", { silent = true })
            vim.keymap.set("n", "<leader>ac", ":AgentContext<CR>", { silent = true })
            vim.keymap.set("n", "<leader>ah", require("agent.ui.conversations").list_conversations)
        end,
    },
}
