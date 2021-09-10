vim.wo.number=true -- always show line numbers
vim.wo.relativenumber=true -- relative line numbers
vim.o.hidden=true -- no save when switching buffers
vim.o.hlsearch=false -- set highlight on search
vim.o.mouse='a' -- enable mouse mode
vim.o.ignorecase=true -- case insensitive search unless /C
vim.o.wrap=false -- turn of word wrap
vim.o.completeopt='menuone,noselect' -- set for better completion experience

-- indentation
vim.o.tabstop=2
vim.o.softtabstop=2
vim.o.shiftwidth=2
vim.o.expandtab=true
vim.o.smarttab=true
vim.o.autoindent=true
vim.o.smartindent=true
vim.o.breakindent=true
vim.o.copyindent=true

-- turn on file type plugin
vim.api.nvim_command('filetype plugin indent on')
