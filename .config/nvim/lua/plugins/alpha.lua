local headers = {
    "isometric",
    "slant_relief",
    "dos_rebel",
    "ogre",
    "elite",
    "the_edge",
    "ansi_shadow",
    "default1",
    "colossal",
}

local hl_groups = {
    "AlphaWhite",
    "AlphaYellow",
    "AlphaBlue",
    "AlphaViolet",
    "AlphaRed",
    "AlphaCyan",
    "AlphaOrange",
    "AlphaGreen",
}

local footer = function()
    local date = os.date(" %m-%d-%Y")
    local version = vim.version()
    local nvim_version_info = " v" .. version.major .. "." .. version.minor .. "." .. version.patch
    return date .. "  " .. nvim_version_info
end

local pick_random = function(tbl)
    return tbl[math.random(#tbl)]
end

local set_colors = function()
    local palette = require("kanagawa.colors").setup({ theme = "wave" }).palette
    vim.api.nvim_set_hl(0, "AlphaWhite", { fg = palette.waveBlue2 })
    vim.api.nvim_set_hl(0, "AlphaBlue", { fg = palette.crystalBlue })
    vim.api.nvim_set_hl(0, "AlphaViolet", { fg = palette.dragonViolet })
    vim.api.nvim_set_hl(0, "AlphaRed", { fg = palette.samuraiRed })
    vim.api.nvim_set_hl(0, "AlphaCyan", { fg = palette.lightBlue })
    vim.api.nvim_set_hl(0, "AlphaOrange", { fg = palette.carpYellow })
    vim.api.nvim_set_hl(0, "AlphaGreen", { fg = palette.springGreen })
end

return {
    "goolord/alpha-nvim",
    cond = not vim.g.started_by_firenvim,
    lazy = false,
    dependencies = {
        "MunifTanjim/nui.nvim",
        "MaximilianLloyd/ascii.nvim",
    },
    config = function()
        set_colors()
        local dashboard = require("alpha.themes.dashboard")
        dashboard.section.header.opts.hl = pick_random(hl_groups)
        dashboard.section.footer.val = footer()
        dashboard.section.footer.opts.hl = pick_random(hl_groups)
        dashboard.section.header.val = require("ascii").art.text.neovim[pick_random(headers)]
        dashboard.section.buttons.val = {
            dashboard.button("e", "  > new file", ":ene <BAR> startinsert <CR>"),
            dashboard.button(
                "p",
                "  > nvim plugins",
                ":e ~/.config/nvim/lua/plugins | :cd %:p:h | :NvimTreeToggle <CR>"
            ),
            dashboard.button("p", "  > nvim config", ":e ~/.config/nvim/ | :cd %:p:h | :NvimTreeToggle <CR>"),
            dashboard.button(
                "v",
                "  > nvim keymap",
                ":e ~/.config/nvim/lua/config/keymaps.lua | :cd %:p:h | :NvimTreeToggle <CR>"
            ),
            dashboard.button("P", "󰋣  > lazy sync", ":Lazy sync<CR>"),
            dashboard.button("c", "  > .config", ":e ~/.config/ | :cd %:p:h | :NvimTreeToggle <CR>"),
            dashboard.button("z", "  > .zshrc", ":e ~/.zshrc | :cd %:p:h | :NvimTreeToggle <CR>"),
            dashboard.button("q", "󱠡  > quit", ":qa<CR>"),
        }
        -- disable folding on alpha buffer
        vim.cmd([[ autocmd FileType alpha setlocal nofoldenable ]])
        require("alpha").setup(dashboard.opts)
    end,
}
