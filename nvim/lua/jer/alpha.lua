local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
	"                                                     ",
	"  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
	"  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
	"  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
	"  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
	"  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
	"  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
	"                                                     ",
}

-- Set menu
dashboard.section.buttons.val = {
	dashboard.button("e", "  > new file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("f", "  > find file", ":Telescope find_files<CR>"),
	dashboard.button("r", "  > recent", ":Telescope oldfiles<CR>"),
	dashboard.button("p", "勒 > sync plugins", ":PackerSync<CR>"),
	dashboard.button("s", "  > config", ":e $HOME/.config/nvim/init.lua | :cd %:p:h | split . | wincmd k | pwd<CR>"),
	dashboard.button("q", "  > quit", ":qa<CR>"),
}

local pick_color = function()
	local colors = { "String", "Identifier", "Keyword", "Number" }
	return colors[math.random(#colors)]
end

local footer = function()
	local datetime = os.date(" %m-%d-%Y   %I:%M")
	local version = vim.version()
	local nvim_version_info = " v" .. version.major .. "." .. version.minor .. "." .. version.patch
	return datetime .. "  " .. nvim_version_info
end
local fortune = require("alpha.fortune")

dashboard.section.header.opts.hl = pick_color()
dashboard.section.footer.val = footer()

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])
