return {
    "neovim/nvim-lspconfig",
    lazy = false,
    cond = not vim.g.started_by_firenvim,
    dependencies = { "saghen/blink.cmp" },
    config = function()
        local lsp_config = require("lspconfig")
        local capabilities = require("blink.cmp").get_lsp_capabilities()
        local default_on_attach = function(_, bufnr)
            local opts = { buffer = bufnr }
            local bind = vim.keymap.set
            bind("n", "<leader>ca", "<cmd>:lua vim.lsp.buf.code_action()<cr>", opts)
            bind("n", "<leader>rn", "<cmd>:lua vim.lsp.buf.rename()<cr>", opts)
            bind("n", "<leader>gr", "<cmd>:lua vim.lsp.buf.references()<cr>", opts)
            bind("n", "<leader>e", "<cmd>:lua vim.diagnostic.open_float()<cr>", opts)
            bind("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
            bind("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
            bind("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
            bind("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
            bind("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
        end

        -- List of default servers to configure
        local default_servers = {
            "lua_ls",
            "ts_ls",
        }

        -- Configure all default servers with the same configuration
        for _, server in ipairs(default_servers) do
            if server == "lua_ls" then
                lsp_config[server].setup({
                    on_attach = default_on_attach,
                    capabilities = capabilities,
                })
            else
                lsp_config[server].setup({
                    on_attach = default_on_attach,
                    capabilities = capabilities,
                })
            end
        end

        lsp_config.ruff.setup({
            trace = "messages",
            capabilities = capabilities,
            init_options = {
                settings = {
                    logLevel = "debug",
                },
            },
        })
        lsp_config.pylsp.setup({
            settings = {
                pylsp = {
                    plugins = {
                        pycodestyle = {
                            enabled = false,
                        },
                        pyflakes = {
                            enabled = false,
                        },
                        black = {
                            enabled = false,
                        },
                        autopep8 = {
                            enabled = false,
                        },
                        yapf = {
                            enabled = false,
                        },
                    },
                },
            },
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                -- Disable formatting for pylsp
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
                default_on_attach(client, bufnr)
            end,
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
            capabilities = capabilities,
            on_attach = default_on_attach,
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
    end,
}
