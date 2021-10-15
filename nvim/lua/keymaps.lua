-- remap space as leader key
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- window navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', opts)
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', opts)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', opts)
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', opts)

-- move current line with option-j/k
vim.api.nvim_set_keymap('n', '∆', '<Esc>:m .+1<CR>==', opts)
vim.api.nvim_set_keymap('n', '˚', '<Esc>:m .-2<CR>==', opts)

-- increase/decrease window size
vim.api.nvim_set_keymap('n', '–', ':vert res -3<CR>', opts)
vim.api.nvim_set_keymap('n', '≠', ':vert res +3<CR>', opts)
vim.api.nvim_set_keymap('n', '—', ':res -3<CR>', opts)
vim.api.nvim_set_keymap('n', '±', ':res +3<CR>', opts)
