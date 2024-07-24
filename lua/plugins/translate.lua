return {
    "voldikss/vim-translator",
    event = "VeryLazy",
    config = function()
        vim.keymap.set("n", "<LocalLeader>t", "<Plug>Translate", { desc = "Tr: Echo translation in cmdline" })
        vim.keymap.set(
            "v",
            "<LocalLeader>t",
            "<Plug>TranslateV",
            { desc = "Tr: Echo translation in cmdline for visual selection" }
        )
        vim.keymap.set("n", "<LocalLeader>w", "<Plug>TranslateW", { desc = "Tr: Display translation in window" })
        vim.keymap.set(
            "v",
            "<LocalLeader>w",
            "<Plug>TranslateWV",
            { desc = "Tr: Display translation in window for visual selection" }
        )
        vim.keymap.set("n", "<LocalLeader>r", "<Plug>TranslateR", { desc = "Tr: Replace text with translation" })
        vim.keymap.set(
            "v",
            "<LocalLeader>r",
            "<Plug>TranslateRV",
            { desc = "Tr: Replace text with translation for visual selection" }
        )
        vim.keymap.set("n", "<LocalLeader>x", "<Plug>TranslateX", { desc = "Tr: Translate text in clipboard" })
    end,
}

