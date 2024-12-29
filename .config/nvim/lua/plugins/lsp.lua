local configure_cmp = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    -- [[ Configure nvim-cmp ]]
    -- See `:help cmp`
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    cmp.setup({
        snippet = {
            expand = function(args)
                luasnip.lsp_expand(args.body)
            end,
        },
        window = {
            completion = cmp.config.window.bordered(),
            documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-p>"] = cmp.mapping.complete({}),
            ["<CR>"] = cmp.mapping.confirm({
                select = true,
            }),
            ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_next_item()
                elseif luasnip.expand_or_locally_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item()
                elseif luasnip.locally_jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "path" },
            { name = "buffer" },
        }),
    })
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

    -- Set configuration for specific filetype.
    cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
            { name = "git" },
            { name = "buffer" },
        }),
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = "buffer" },
        },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = "path" },
            { name = "cmdline" },
        }),
    })
end

return {
    -- LSP Configuration & Plugins
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    cond = not vim.g.started_by_firenvim,
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "folke/neodev.nvim",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp", -- adds LSP completion capabilities
        "hrsh7th/cmp-path", -- file path source for completion
        "hrsh7th/cmp-buffer", -- buffer source for completion
        "petertriho/cmp-git", -- git source for completion
        "hrsh7th/cmp-cmdline", -- cmd line source for completion
        "saadparwaiz1/cmp_luasnip",
        {
            "L3MON4D3/LuaSnip",
            version = "v2.*",
            build = "make install_jsregexp",
        },
        {
            "windwp/nvim-autopairs",
            opts = {
                event = "InsertEnter",
                check_ts = true,
            },
        },
    },
    config = function()
        -- Setup neovim lua configuration
        require("neodev").setup()
        local lsp_config = require("lspconfig")

        -- [[ Configure LSP ]]
        local lsp_zero = require("lsp-zero")
        local default_on_attach = function(_, bufnr)
            lsp_zero.default_keymaps({ buffer = bufnr })
            local opts = { buffer = bufnr }
            local bind = vim.keymap.set
            bind("n", "<leader>ca", "<cmd>:lua vim.lsp.buf.code_action()<cr>", opts)
            bind("n", "<leader>rn", "<cmd>:lua vim.lsp.buf.rename()<cr>", opts)
            bind("n", "<leader>gr", "<cmd>:lua vim.lsp.buf.references()<cr>", opts)
            bind("n", "<leader>e", "<cmd>:lua vim.diagnostic.open_float()<cr>", opts)
            -- vim.api.nvim_create_autocmd("BufWritePre", {
            --     buffer = bufnr,
            --     callback = function()
            --         vim.lsp.buf.format({
            --             async = false,
            --             timeout_ms = 2000,
            --             -- filter = function(c)
            --             --     return c.name == "ruff"
            --             -- end,
            --         })
            --     end,
            -- })
        end

        lsp_zero.on_attach(function(client, bufnr)
            default_on_attach(client, bufnr)
        end)

        require("mason").setup({})
        ---@diagnostic disable-next-line: missing-fields
        require("mason-lspconfig").setup({
            ensure_installed = {
                "pylsp",
                "ts_ls",
                "lua_ls",
            },
            handlers = {
                lsp_zero.default_setup,
            },
        })
        lsp_config.ruff.setup({
            trace = "messages",
            init_options = {
                settings = {
                    logLevel = "debug",
                },
            },
        })
        lsp_config.pyright.setup({
            settings = {
                pyright = {
                    -- Using Ruff's import organizer
                    disableOrganizeImports = true,
                },
                python = {
                    analysis = {
                        -- Ignore all files for analysis to exclusively use Ruff for linting
                        ignore = { "*" },
                    },
                },
            },
        })
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp_attach_disable_ruff_hover", { clear = true }),
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if client == nil then
                    return
                end
                if client.name == "ruff" then
                    -- Disable hover in favor of Pyright
                    client.server_capabilities.hoverProvider = false
                end
            end,
            desc = "LSP: Disable hover capability from Ruff",
        })

        vim.diagnostic.config({
            virtual_text = true,
            update_in_insert = true,
            underline = true,
            severity_sort = true,
            float = {
                focusable = false,
                source = true,
                style = "minimal",
                border = "rounded",
                header = "",
                prefix = "",
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = " ",
                    [vim.diagnostic.severity.WARN] = " ",
                    [vim.diagnostic.severity.HINT] = "󰮥 ",
                    [vim.diagnostic.severity.INFO] = " ",
                },
            },
        })
        configure_cmp()
    end,
}
