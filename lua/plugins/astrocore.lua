-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
    {
        "AstroNvim/astrocore",
        ---@type AstroCoreOpts
        opts = {
            -- Configure core features of AstroNvim
            features = {
                large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
                autopairs = true, -- enable autopairs at start
                cmp = true, -- enable completion at start
                diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
                highlighturl = true, -- highlight URLs at start
                notifications = true, -- enable notifications at start
            },
            -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
            diagnostics = {
                virtual_text = true,
                underline = true,
            },
            -- vim options can be configured here
            options = {
                opt = { -- vim.opt.<key>
                    scrolloff = 8, -- number of lines to keep above and below the cursor
                    sidescrolloff = 8, -- number of columns to keep at the sides of the cursor
                    number = true, -- show numberline
                    numberwidth = 2, -- ljay: Minimum number of columns to use for the line number
                    list = true, -- ljay: Show hidden characters

                    helpheight = 0, -- ljay: Disable help window resizing
                    winwidth = 30, -- ljay: Minimum width for active window
                    winminwidth = 1, -- ljay: Minimum width for inactive windows
                    winheight = 1, -- ljay: Minimum height for active window
                    winminheight = 1, -- ljay: Minimum height for inactive window

                    showcmd = false, -- ljay: Don't show command in status line
                    cmdwinheight = 5, -- ljay: Command-line lines
                    equalalways = true, -- ljay: Resize windows on split or close
                    colorcolumn = "+0", -- ljay: Column highlight at textwidth's max character-limit

                    cursorlineopt = { "number", "screenline" },

                    pumwidth = 10, -- ljay: Minimum width for the popup menu
                    pumblend = 10, -- ljay: Popup blend

                    preserveindent = true, -- preserve indent structure as much as possible
                    textwidth = 120, -- ljay: Text width maximum chars before wrapping
                    smarttab = true, -- ljay: Tab insert blanks according to 'shiftwidth'
                    shiftround = true, -- ljay: Round indent to multiple of 'shiftwidth'
                    autoindent = true, -- ljay: Use same indenting on new lines
                    smartindent = true, -- ljay: Smart autoindenting on new lines
                    shiftwidth = 4, -- number of space inserted for indentation
                    tabstop = 4, -- number of space in a tab
                },
                g = { -- vim.g.<key>
                    -- configure global vim variables (vim.g)
                    -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
                    -- This can be found in the `lua/lazy_setup.lua` file
                },
            },
            -- Mappings can be configured through AstroCore as well.
            -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
            mappings = {
                -- first key is the mode
                n = {
                    -- second key is the lefthand side of the map

                    -- navigate buffer tabs
                    ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
                    ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },

                    -- move cursor
                    ["gh"] = { "g^", desc = "Cursor to line begin" },
                    ["gl"] = { "g$", desc = "Cursor to line end" },
                    ["|"] = false,

                    -- move line
                    ["<leader>k"] = { "<cmd>move-2<CR>==", silent = true, desc = "Move line up" },
                    ["<leader>j"] = { "<cmd>move+<CR>==", silent = true, desc = "Move line down" },

                    -- find
                    ["<leader>fg"] = {
                        function()
                            require("telescope.builtin").live_grep {
                                additional_args = function(args)
                                    return vim.list_extend(args, { "--hidden", "--no-ignore" })
                                end,
                            }
                        end,
                        desc = "Find words in all files",
                    },

                    -- split, resize window
                    ["<leader>v"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" },
                    ["<leader>s"] = { "<cmd>split<cr>", desc = "Horizontal Split" },
                    ["<C-=>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" },
                    ["<C-_>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" },
                    ["<C-9>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" },
                    ["<C-0>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" },

                    -- others
                    ["<leader>P"] = { ':echo expand("%:p")<CR>', silent = true, desc = "Show current file path" },
                    ["<localleader>fb"] = { ":%s/ //g<CR>", silent = true, desc = "remove spaces globally" },

                    -- git
                    ["<leader>ggp"] = {
                        ":G push origin HEAD:refs/for/dev<CR>",
                        silent = true,
                        desc = "git push origin to dev",
                    },
                    ["<leader>ggc"] = { ":G commit --amend<CR>", silent = true, desc = "git commit --amend" },

                    -- Neotree remapping
                    ["<localleader>e"] = { "<Cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },
                    ["<localleader>a"] = {
                        function()
                            if vim.bo.filetype == "neo-tree" then
                                vim.cmd.wincmd "p"
                            else
                                vim.cmd.Neotree "focus"
                            end
                        end,
                        desc = "Toggle Explorer Focus",
                    },

                    -- markdown
                    -- ["<leader>m"] = sections.m,
                    -- ["<leader>mp"] = { ":MarkdownPreview<CR>", silent = true, desc = "Markdown Preview" },
                    -- ["<leader>mc"] = { ":MarkdownPreviewStop<CR>", silent = true, desc = "Markdown Preview Stop" },

                    -- mappings seen under group name "Buffer"
                    ["<Leader>bd"] = {
                        function()
                            require("astroui.status.heirline").buffer_picker(
                                function(bufnr) require("astrocore.buffer").close(bufnr) end
                            )
                        end,
                        desc = "Close buffer from tabline",
                    },

                    ["<leader>mp"] = { ":MarkdownPreview<CR>", silent = true, desc = "Markdown Preview" },
                    ["<leader>mc"] = { ":MarkdownPreviewStop<CR>", silent = true, desc = "Markdown Preview Stop" },
                    ["<leader>mg"] = { ":Glow<CR>", silent = true, desc = "Markdown Preview with Glow" },

                    -- tables with just a `desc` key will be registered with which-key if it's installed
                    -- this is useful for naming menus
                    -- ["<Leader>b"] = { desc = "Buffers" },

                    -- setting a mapping to false will disable it
                    -- ["<C-S>"] = false,
                },
                x = {
                    ["<leader>k"] = { ":move'<-2<CR>gv=gv", silent = true, desc = "Move selection up" },
                    ["<leader>j"] = { ":move'>+<CR>gv=gv", silent = true, desc = "Move selection down" },
                },
            },
        },
    },

    -- {
    --   "windwp/nvim-autopairs",
    --   event = "InsertEnter",
    -- },
}
