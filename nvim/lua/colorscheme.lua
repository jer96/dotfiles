vim.o.background = 'dark'
vim.cmd([[
  function! Highlights() abort
    highlight clear SignColumn
    highlight GruvboxGreenSign guibg=none
    highlight GruvboxAquaSign guifg=#fe8019 guibg=none
    highlight GruvboxRedSign guibg=none
    highlight GruvboxYellowSign guibg=none
    highlight LineNr guifg=#a89984
    highlight CursorColumn guibg=#83a598
    highlight CursorLine guibg=#3c3836
    highlight CursorLineNr guifg=#fe8019 guibg=none
    highlight TelescopeBorder guifg=#83a598
  endfunction

  augroup Colors
    autocmd!
    autocmd ColorScheme * call Highlights()
  augroup END

  set termguicolors
  colorscheme gruvbox
]])
require('colorizer').setup()
