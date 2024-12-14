-- remap space as leader key
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- window navigation
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", opts)

-- move text up and down
-- normal mode
vim.api.nvim_set_keymap("n", "∆", "<Esc>:m .+1<CR>==", opts)
vim.api.nvim_set_keymap("n", "˚", "<Esc>:m .-2<CR>==", opts)
-- visual mode
vim.api.nvim_set_keymap("v", "∆", ":m .+1<CR>==", opts)
vim.api.nvim_set_keymap("v", "˚", ":m .-2<CR>==", opts)
-- visual block
vim.api.nvim_set_keymap("x", "∆", ":move '>+1<CR>gv-gv", opts)
vim.api.nvim_set_keymap("x", "˚", ":move '<-2<CR>gv-gv", opts)

-- increase/decrease window size
vim.api.nvim_set_keymap("n", "–", ":vert res -3<CR>", opts)
vim.api.nvim_set_keymap("n", "≠", ":vert res +3<CR>", opts)
vim.api.nvim_set_keymap("n", "—", ":res -3<CR>", opts)
vim.api.nvim_set_keymap("n", "±", ":res +3<CR>", opts)

-- buffers
vim.api.nvim_set_keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)
vim.api.nvim_set_keymap("n", "˙", ":BufferLineMovePrev<CR>", opts)
vim.api.nvim_set_keymap("n", "¬", ":BufferLineMoveNext<CR>", opts)
vim.api.nvim_set_keymap("n", "∑", ":Bdelete<CR>", opts)

-- nvimtree
vim.api.nvim_set_keymap("n", "<Leader>t", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Leader>r", ":NvimTreeRefresh<CR>", { noremap = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function ()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- telescope
vim.api.nvim_set_keymap(
    "n",
    "<leader><space>",
    [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]],
    opts
)
vim.api.nvim_set_keymap("n", "<leader>fo", [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)
vim.api.nvim_set_keymap(
    "n",
    "<leader>gg",
    [[<cmd>lua require('telescope.builtin').git_files({show_untracked = false})<CR>]],
    opts
)
vim.api.nvim_set_keymap("n", "<leader>fb", [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
vim.api.nvim_set_keymap("n", "<leader>fh", [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opts)
vim.api.nvim_set_keymap(
    "n",
    "<leader>bz",
    [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
    opts
)
vim.api.nvim_set_keymap("n", "<leader>st", [[<cmd>lua require('telescope.builtin').tags()<CR>]], opts)
vim.api.nvim_set_keymap(
    "n",
    "<leader>so",
    [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]],
    opts
)
-- brew install fd
vim.api.nvim_set_keymap("n", "<leader>fs", [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)
-- brew install ripgrep
vim.api.nvim_set_keymap("n", "<leader>fg", [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
