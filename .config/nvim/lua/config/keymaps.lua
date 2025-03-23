-- remap space as leader key
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- alpha
vim.api.nvim_set_keymap("n", "<Leader>al", ":Alpha<CR>", opts)

-- quit and save
vim.api.nvim_set_keymap("n", "<Leader>qq", ":qall<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>qqq", ":qall!<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>wq", ":wqall<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>w", ":wall<CR>", opts)

-- restart neovim
vim.api.nvim_set_keymap("n", "<Leader>rr", ":wall | :cq<CR>", opts)

-- increase/decrease window size
vim.api.nvim_set_keymap("n", "–", ":vert res -3<CR>", opts)
vim.api.nvim_set_keymap("n", "≠", ":vert res +3<CR>", opts)
vim.api.nvim_set_keymap("n", "—", ":res -3<CR>", opts)
vim.api.nvim_set_keymap("n", "±", ":res +3<CR>", opts)

-- buffers
vim.api.nvim_set_keymap("n", "<Tab>", ":BufferLineCycleNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", opts)

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- terminal
vim.api.nvim_create_autocmd("TermOpen", {
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true }) -- Exit terminal mode
vim.keymap.set("n", "<Leader>st", function()
    vim.cmd.vnew()
    vim.cmd.term()
    vim.cmd.wincmd("J")
    vim.api.nvim_win_set_height(0, 25)
    vim.bo.modifiable = true
end)

-- clipboard mappings using z register
vim.api.nvim_set_keymap("x", "y", "zy", opts)
vim.api.nvim_set_keymap("n", "p", "zp", opts)
vim.api.nvim_set_keymap("n", "P", "zP", opts)
