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

local colors = { "String", "Identifier", "Keyword", "Number" }
local pick_color = function ()
    return colors[math.random(#colors)]
end

local footer = function ()
    local datetime = os.date(" %m-%d-%Y   %I:%M")
    local version = vim.version()
    local nvim_version_info = " v" .. version.major .. "." .. version.minor .. "." .. version.patch
    return datetime .. "  " .. nvim_version_info
end

dashboard.section.header.opts.hl = pick_color()
dashboard.section.footer.val = footer()


-- Disable folding on alpha buffer
vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
]])

return {
    'goolord/alpha-nvim',
    opts = dashboard.opts
}
