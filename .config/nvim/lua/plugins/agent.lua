return {
    {
        dir = "~/nvim-plugins/agent.nvim",
        enabled = true,
        dev = true,
        build = ":UpdateRemotePlugins",
        dependencies = {
            "famiu/bufdelete.nvim",
            "nvim-telescope/telescope.nvim",
        },
        config = function()
            require("agent").setup({
                model_provider = "anthropic",
                storage = {
                    enabled = false,
                    path = "/Users/jeremiahbill/nvim-plugins/conversations",
                },
            })
            vim.keymap.set("n", "<leader>aa", ":AgentToggle<CR>", { silent = true })
            vim.keymap.set("n", "<leader>ac", require("agent.ui.context").file_picker_with_context)
            vim.keymap.set("n", "<leader>ah", require("agent.ui.conversations").list_conversations)
            vim.api.nvim_create_autocmd("User", {
                pattern = "BDeletePost*",
                callback = function(event)
                    local buf_num = event.file and event.file:match("BDeletePost%s+(%d+)")
                    buf_num = tonumber(buf_num)
                    if buf_num then
                        vim.fn.AgentHandleBufDelete(buf_num)
                    end
                end,
            })
        end,
    },
}
