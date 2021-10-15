-- luasnip setup
local luasnip = require 'luasnip'

-- nice symbols for menu
local lspkind = require('lspkind')

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  completion = {
    completeopt = "menu,menuone,noinsert",
  },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  documentation = {
    border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
  },
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind]
      vim_item.menu = ({
        nvim_lsp = "(LSP)",
        path = "(Path)",
        luasnip = "(Snippet)",
      })[entry.source.name]
      vim_item.dup = ({
        path = 1,
        nvim_lsp = 0,
      })[entry.source.name] or 0
      return vim_item
    end
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item();
      else
        fallback();
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item();
      else
        fallback();
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
  },
}

local npairs = require('nvim-autopairs')
npairs.setup({
  disable_filetype = {"TelescopePrompt", "vim"}
})
-- you need setup cmp first put this after cmp.setup()
require("nvim-autopairs.completion.cmp").setup({
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
  auto_select = true -- automatically select the first item
})
