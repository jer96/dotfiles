require('jer.plugins')
require('jer.keymaps')
require('jer.settings')
require('jer.format')
require('jer.colorscheme')
if vim.fn.exists('g:started_by_firenvim') == 0 then
    require('jer.lsp')
    require('jer.treesitter')
    require('jer.telescope')
    require('jer.cmp')
    require('jer.nvimtree')
    require('jer.gitsigns')
    require('jer.bufferline')
    require('jer.lualine')
else
  require('firenvim')
end

