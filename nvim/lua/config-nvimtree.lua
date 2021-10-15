vim.g.nvim_tree_quit_on_open = 0
vim.g.nvim_tree_width = '20%'
vim.api.nvim_set_keymap('n', '<Leader>t', ":NvimTreeToggle<CR>", {noremap = true, silent = true})

require('nvim-tree').setup();
-- local view = require('nvim-tree.view')
-- local _M = {}

-- _M.toggle_tree = function()
--     if view.win_open() then
--         require('nvim-tree').close()
--         require('bufferline.state').set_offset(0)
--     else
--         local stats = vim.api.nvim_list_uis()[1]
--         local width = stats.width * .2
--         require('bufferline.state').set_offset(width, 'files')
--         require('nvim-tree').find_file(true)
--     end
-- end

-- return _M
