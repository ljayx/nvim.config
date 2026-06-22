return {
    {
        "ray-x/go.nvim",
        enabled = false,
        dependencies = { -- optional packages
            "ray-x/guihua.lua",
            "neovim/nvim-lspconfig",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            -- below is for formatting on save
            --local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
            --vim.api.nvim_create_autocmd("BufWritePre", {
            --    pattern = "*.go",
            --    callback = function()
            --        require('go.format').goimport()
            --    end,
            --    group = format_sync_grp,
            --})

            local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
            require('go').setup({
                -- other setups ....
                lsp_codelens = false,
                gopls_remote_auto = false,
                gopls_cmd = { vim.fn.expand("~/.local/share/nvim/mason/bin/gopls") },
                lsp_inlay_hints = { enable = false },
                dap_debug = false,
                dap_debug_keymap = false,
                dap_debug_vt = { enabled = false },
                textobjects = false,
                lsp_cfg = false,
            })

            --require("go").setup()
        end,
        ft = { "go", "gomod", "gowork", "gotmpl" },
        build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    }
}

