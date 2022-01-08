require("bufferline").setup {
    options = {
        max_name_length = 25,
        max_prefix_length = 20,
        diagnostic = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end,
        close_command = "Bdelete! %d",
        separator_style = "slant",
        offsets = {{filetype = "NvimTree", text = 'files', text_align = 'center'}}
    }
}
local opts = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<Tab>', ':BufferLineCycleNext<CR>', opts)
vim.api.nvim_set_keymap('n', '<S-Tab>', ':BufferLineCyclePrev<CR>', opts)
vim.api.nvim_set_keymap('n', '˙', ':BufferLineMovePrev<CR>', opts)
vim.api.nvim_set_keymap('n', '¬', ':BufferLineMoveNext<CR>', opts)
vim.api.nvim_set_keymap('n', '∑', ':Bdelete<CR>', opts)
