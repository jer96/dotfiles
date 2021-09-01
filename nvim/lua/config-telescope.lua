require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>fo', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>bz', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], opts)
vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], opts)
-- brew install fd
vim.api.nvim_set_keymap('n', '<leader>fs', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], opts)
-- brew install ripgrep
vim.api.nvim_set_keymap('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], opts)
