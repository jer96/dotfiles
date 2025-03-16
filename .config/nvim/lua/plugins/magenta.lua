return {
    "dlants/magenta.nvim",
    enabled = false,
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
