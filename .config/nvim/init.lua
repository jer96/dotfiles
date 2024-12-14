-- set <space> as the leader key
--  must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('config.settings')

require('lazy').setup({
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',     -- detect tabstop and shiftwidth automatically
  'tpope/vim-commentary', -- "gc" to comment visual regions/lines
  'nvim-tree/nvim-web-devicons',
  { 'nvim-tree/nvim-tree.lua', opts = {} },
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function ()
      vim.cmd.colorscheme 'onedark'
    end,
  },
  { import = 'ui.plugins' },
  { import = 'editor.plugins' },
}, {})

require('config.keymaps')

-- see :help modeline
-- vim: ts=2 sts=2 sw=2 et
