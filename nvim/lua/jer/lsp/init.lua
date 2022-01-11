local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end
require("jer.lsp.lsp-installer")
require("jer.lsp.lsp-config").setup()
require("jer.lsp.null-ls")
