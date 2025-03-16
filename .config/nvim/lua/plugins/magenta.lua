return {
    "dlants/magenta.nvim",
    dev = true,
    lazy = false,
    build = "npm install --frozen-lockfile",
    config = function()
        require("magenta").setup({
            picker = "telescope",
            sidebar_position = "right",
        })
    end,
}
