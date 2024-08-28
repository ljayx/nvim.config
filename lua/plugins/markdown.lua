return {
    {
        "ellisonleao/glow.nvim",
        cmd = "Glow",
        event = "VeryLazy",
        config = function()
            require("glow").setup {
                width = 120,
                -- height = 120,
                height_ratio = 0.9,
                style = "dark", -- light, dark
                border = "shadow",
            }
        end,
    },
    { "iamcco/markdown-preview.nvim", event = "VeryLazy", config = function() vim.fn["mkdp#util#install"]() end },
}
