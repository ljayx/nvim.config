-- local get_icon = require("astronvim.utils").get_icon
return {
    -- {
    --     "lewis6991/gitsigns.nvim",
    --     enabled = vim.fn.executable "git" == 1,
    --     event = "User AstroGitFile",
    --     opts = {
    --         signs = {
    --             add = { text = get_icon "GitSign" },
    --             change = { text = get_icon "GitSign" },
    --             delete = { text = get_icon "GitSign" },
    --             topdelete = { text = get_icon "GitSign" },
    --             changedelete = { text = get_icon "GitSign" },
    --             untracked = { text = get_icon "GitSign" },
    --         },
    --         worktrees = vim.g.git_worktrees,
    --     },
    -- },
    {
        "tpope/vim-fugitive",
        cmd = { "G", "Git", "Gfetch", "Gpush", "Gclog", "Gdiffsplit" },
        keys = {
            { "<leader>ggd", "<cmd>Gdiffsplit<CR>", desc = "git diff" },
            { "<leader>ggb", "<cmd>Git blame<CR>", desc = "git blame" },
        },
    },
    {
        "TimUntersberger/neogit",
        dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
        cmd = "Neogit",
        keys = {
            { "<Leader>gn", "<cmd>Neogit<CR>", desc = "Neogit" },
        },
        -- See: https://github.com/TimUntersberger/neogit#configuration
        opts = {
            disable_signs = false,
            disable_context_highlighting = false,
            disable_commit_confirmation = false,
            signs = {
                section = { ">", "v" },
                item = { ">", "v" },
                hunk = { "", "" },
            },
            integrations = {
                diffview = true,
            },
        },
    },
    {
        -- :GV open commit browser
        -- :GV! only list commits that affected the current file
        -- :GV? fills the location list with the revisions of the current file
        -- :GV or :GV? can be used in visual mode to track the changes in the selected lines.
        -- o or <cr> on a commit to display the content of it
        -- o or <cr> on commits to display the diff in the range
        -- O opens a new tab instead
        -- gb for :GBrowse
        -- ]] and [[ to move between commits
        -- . to start command-line with :Git [CURSOR] SHA à la fugitive
        -- q or gq to close
        "junegunn/gv.vim",
        dependencies = { "tpope/vim-fugitive" },
        cmd = "GV",
        keys = {
            { "<leader>go", "<cmd>GV<CR>", desc = "git log" },
            { "<leader>ggo", "<cmd>GV!<CR>", desc = "git log line" },
        },
    },
}

