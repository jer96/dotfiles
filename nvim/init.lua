require("jer.plugins")
require("jer.keymaps")
require("jer.settings")
require("jer.telescope")
if vim.fn.exists("g:started_by_firenvim") == 0 then
	-- require("jer.lsp")
	require("jer.treesitter")
	-- require("jer.cmp")
	-- require("jer.autopairs")
	require("jer.nvimtree")
	require("jer.gitsigns")
	require("jer.bufferline")
	require("jer.lualine")
	require("jer.alpha")
else
  require("firenvim")
end
require("jer.colorscheme")
