return {
    {
        dir = "~/nvim-plugins/agent.nvim",
        enabled = true,
        dev = true,
        build = ":UpdateRemotePlugins",
        dependencies = {
            "famiu/bufdelete.nvim",
            {
                "nvim-telescope/telescope.nvim",
                branch = "0.1.x",
                cond = not vim.g.started_by_firenvim,
                dependencies = {
                    "nvim-lua/plenary.nvim",
                },
                opts = {},
            },
        },
        config = function()
            require("agent").setup({
                model_provider = "anthropic",
                storage = {
                    enabled = false,
                    path = "/Users/jeremiahbill/nvim-plugins/conversations",
                },
            })
            -- keymaps
            vim.keymap.set("n", "<leader>aa", ":AgentToggle<CR>", { silent = true })
            vim.keymap.set("n", "<leader>ac", require("agent.ui.context").file_picker_with_context)
            vim.keymap.set("n", "<leader>ah", require("agent.ui.conversations").list_conversations)
            -- autocmd to delete open buffer from agent context
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
