local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	execute("packadd packer.nvim")
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

local use = require("packer").use

return require("packer").startup(function()
	use("wbthomason/packer.nvim")
	use("goolord/alpha-nvim")
	use("nvim-lua/plenary.nvim")
	use("kyazdani42/nvim-web-devicons") -- better file icons
	use("kyazdani42/nvim-tree.lua") -- simple file tree
	use({ "gruvbox-community/gruvbox" })
	use("nvim-telescope/telescope.nvim")
	use("tpope/vim-commentary")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("lewis6991/gitsigns.nvim")
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "akinsho/bufferline.nvim" })
	use("famiu/bufdelete.nvim")
	use({ "nvim-lualine/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
	use("norcalli/nvim-colorizer.lua")
	use({
		"glacambre/firenvim",
		run = function()
			vim.fn["firenvim#install"](0)
		end,
	})
	use({ "tpope/vim-fugitive" })
	use("rebelot/kanagawa.nvim")
end)
