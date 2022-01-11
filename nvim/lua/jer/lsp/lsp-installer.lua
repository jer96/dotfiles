-- reference: https://github.com/LunarVim/Neovim-from-scratch/blob/master/lua/user/lsp/lsp-installer.lua
local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = require("jer.lsp.lsp-config").on_attach,
		capabilities = require("jer.lsp.lsp-config").capabilities,
	}

	if server.name == "clangd" then
		local clangd_opts = require("jer.lsp.settings.clangd")
		opts = vim.tbl_deep_extend("force", clangd_opts, opts)
		opts.on_attach = clangd_opts.on_attach
	end

	if server.name == "sumneko_lua" then
		local sumneko_opts = require("jer.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	server:setup(opts)
end)
