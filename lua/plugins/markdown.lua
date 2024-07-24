return {
    {
        "ellisonleao/glow.nvim",
        cmd = "Glow",
        event = "VeryLazy",
        config = function()
            require("glow").setup {
                width = 120,
                style = "dark",-- light, dark
            }
        end,
    },
    { "iamcco/markdown-preview.nvim", event = "VeryLazy", config = function() vim.fn["mkdp#util#install"]() end },
}

