require("bufferline").setup({
	options = {
		max_name_length = 25,
		max_prefix_length = 20,
		close_command = "Bdelete! %d",
		offsets = { { filetype = "NvimTree", padding = 1, text = "files", text_align = "center" } },
		custom_filter = function(buf)
			return vim.fn.bufname(buf) ~= ""
		end,
	},
})
