local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- luasnip setup
local luasnip = require 'luasnip'

-- nice symbols for menu
local lspkind = require('lspkind')

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    completion = {completeopt = "menu,menuone,noinsert"},
    snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
    documentation = {border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}},
    formatting = {format = lspkind.cmp_format({with_text = true, maxwidth = 50})},
    mapping = {
        ['<CR>'] = cmp.mapping.confirm({select = true}),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            elseif has_words_before() then
                cmp.complete()
            else
                fallback()
            end
        end, {"i", "s"}),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {"i", "s"})
    },
    sources = {{name = 'nvim_lsp'}, {name = 'luasnip'}, {name = 'path'}}
}

local npairs = require('nvim-autopairs')
npairs.setup({disable_filetype = {"TelescopePrompt", "vim"}})
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({map_char = {tex = ''}}))

vim.cmd("autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }")
