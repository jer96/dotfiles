local colors = {
	black = "#282828",
	white = "#ebdbb2",
	red = "#fb4934",
	green = "#b8bb26",
	blue = "#83a598",
	yellow = "#fe8019",
	gray = "#a89984",
	darkgray = "#3c3836",
	lightgray = "#504945",
	inactivegray = "#7c6f64",
	bg = "#282828",
}

local custom_gb = {
	normal = {
		a = { bg = colors.white, fg = colors.black, gui = "bold" },
		b = { bg = colors.darkgray, fg = colors.white },
		c = { bg = colors.darkgray, fg = colors.white },
	},
	insert = {
		a = { bg = colors.yellow, fg = colors.black, gui = "bold" },
		b = { bg = colors.darkgray, fg = colors.white },
		c = { bg = colors.darkgray, fg = colors.white },
	},
	visual = {
		a = { bg = colors.blue, fg = colors.black, gui = "bold" },
		b = { bg = colors.darkgray, fg = colors.white },
		c = { bg = colors.darkgray, fg = colors.white },
	},
	command = {
		a = { bg = colors.green, fg = colors.black, gui = "bold" },
		b = { bg = colors.darkgray, fg = colors.white },
		c = { bg = colors.darkgray, fg = colors.white },
	},
	inactive = {
		a = { bg = colors.bg, fg = colors.white, gui = "bold" },
		b = { bg = colors.bg, fg = colors.white },
		c = { bg = colors.bg, fg = colors.white },
	},
}

local custom_gruvbox = require("lualine.themes.gruvbox")
custom_gruvbox.normal = custom_gb.normal
custom_gruvbox.insert = custom_gb.insert
custom_gruvbox.visual = custom_gb.visual
custom_gruvbox.command = custom_gb.command
custom_gruvbox.inactive = custom_gb.inactive

require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = custom_gruvbox,
		section_separators = "",
		component_separators = { left = "|", right = "" },
		disabled_filetypes = { "NvimTree", "alpha" },
		fmt = string.lower,
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { { "filename", file_status = false, path = 1 }, "filesize" },
		lualine_c = {},
		lualine_x = {},
		lualine_y = { { "diagnostics", sources = { "nvim_diagnostic" } }, "diff" },
		lualine_z = { "branch" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
