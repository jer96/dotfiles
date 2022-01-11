return {
	on_attach = function(client, bufnr)
		client.resolved_capabilities.document_formatting = false
		client.resolved_capabilities.document_range_formatting = false
		require("jer.lsp.lsp-config").on_attach(client, bufnr)
	end,
	cmd = { "clangd", "--background-index", "--clang-tidy" },
	root_dir = function()
		return vim.loop.cwd()
	end,
}
