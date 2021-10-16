local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    execute 'packadd packer.nvim'
end

vim.api.nvim_exec(
    [[
    augroup Packer
        autocmd!
        autocmd BufWritePost init.lua PackerCompile
    augroup end
    ]],
    false
)


local use = require('packer').use

return require('packer').startup(function ()
    use 'wbthomason/packer.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'kyazdani42/nvim-web-devicons' -- better file icons
    use 'kyazdani42/nvim-tree.lua' -- simple file tree
    use 'neovim/nvim-lspconfig' -- configs for built in LSPs
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/vim-vsnip",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "onsails/lspkind-nvim",
        "saadparwaiz1/cmp_luasnip",
      }
    }
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use {'npxbr/gruvbox.nvim', requires = {"rktjmp/lush.nvim"}}
    use 'nvim-telescope/telescope.nvim'
    use 'windwp/nvim-autopairs'
    use 'tpope/vim-commentary'
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'lewis6991/gitsigns.nvim'
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {'akinsho/bufferline.nvim'}
end)
