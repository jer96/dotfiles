vim.wo.number=true -- always show line numbers
vim.wo.relativenumber=true -- relative line numbers
vim.o.hidden=true -- no save when switching buffers
vim.o.hlsearch=false -- set highlight on search
vim.o.mouse='a' -- enable mouse mode
vim.o.ignorecase=true -- case insensitive search unless /C
vim.o.wrap=false -- turn of word wrap

-- indentation
vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4
vim.o.expandtab=true
vim.o.smarttab=true
vim.o.autoindent=true
vim.o.smartindent=true
vim.o.breakindent=true
vim.o.copyindent=true

-- turn on file type plugin
vim.api.nvim_command('filetype plugin indent on')
