return {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    event = {
        -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
        "BufReadPre /Users/ljay/notes/obsidian/wzgo/**.md",
        "BufNewFile /Users/ljay/notes/obsidian/wzgo/**.md",
        "BufReadPre /Users/ljay/Library/Mobile Documents/iCloud~md~obsidian/Documents/**.md",
        "BufNewFile /Users/ljay/Library/Mobile Documents/iCloud~md~obsidian/Documents/**.md",
    },
    dependencies = {
        -- Required.
        "nvim-lua/plenary.nvim",
        -- "preservim/vim-markdown",

        -- see below for full list of optional dependencies 👇
    },
    opts = {
        workspaces = {
            {
                name = "wzgo",
                path = "/Users/ljay/notes/obsidian/wzgo",
            },
            -- {
            --     name = "work",
            --     path = "~/vaults/work",
            -- },
        },

        -- -- Optional, alternatively you can customize the frontmatter data.
        -- note_frontmatter_func = function(note)
        --     -- This is equivalent to the default frontmatter function.
        --     local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        --     -- local out = { id = note.id, aliases = "", tags = note.tags }
        --     -- `note.metadata` contains any manually added fields in the frontmatter.
        --     -- So here we just make sure those fields are kept in the frontmatter.
        --     if note.metadata ~= nil and require("obsidian").util.table_length(note.metadata) > 0 then
        --         for k, v in pairs(note.metadata) do
        --             out[k] = v
        --         end
        --     end
        --     return out
        -- end,

        -- -- Optional, alternatively you can customize the frontmatter data.
        -- note_frontmatter_func = function(note)
        --     -- This is equivalent to the default frontmatter function.
        --     local out = { id = note.id, aliases = note.aliases, tags = note.tags }
        --     -- `note.metadata` contains any manually added fields in the frontmatter.
        --     -- So here we just make sure those fields are kept in the frontmatter.
        --     if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        --         for k, v in pairs(note.metadata) do
        --             out[k] = v
        --         end
        --     end
        --     return out
        -- end,

        -- Optional, alternatively you can customize the frontmatter data.
        ---@return table
        note_frontmatter_func = function(note)
            -- Add the title of the note as an alias.
            if note.title then note:add_alias(note.title) end

            local out = { id = note.id, aliases = note.aliases, tags = note.tags }

            -- `note.metadata` contains any manually added fields in the frontmatter.
            -- So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
                for k, v in pairs(note.metadata) do
                    out[k] = v
                end
            end

            return out
        end,

        -- Optional, sort search results by "path", "modified", "accessed", or "created".
        -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
        -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
        -- sort_by = "modified",
        -- sort_reversed = true,

        -- -- Specify how to handle attachments.
        -- attachments = {
        --     -- The default folder to place images in via `:ObsidianPasteImg`.
        --     -- If this is a relative path it will be interpreted as relative to the vault root.
        --     -- You can always override this per image by passing a full path to the command instead of just a filename.
        --     img_folder = "assets/imgs", -- This is the default
        --     -- A function that determines the text to insert in the note when pasting an image.
        --     -- It takes two arguments, the `obsidian.Client` and a plenary `Path` to the image file.
        --     -- This is the default implementation.
        --     ---@param client obsidian.Client
        --     ---@param path Path the absolute path to the image file
        --     ---@return string
        --     img_text_func = function(client, path)
        --         local link_path
        --         local vault_relative_path = client:vault_relative_path(path)
        --         if vault_relative_path ~= nil then
        --             -- Use relative path if the image is saved in the vault dir.
        --             link_path = vault_relative_path
        --         else
        --             -- Otherwise use the absolute path.
        --             link_path = tostring(path)
        --         end
        --         local display_name = vim.fs.basename(link_path)
        --         return string.format("![%s](%s)", display_name, link_path)
        --     end,
        -- },

        -- Specify how to handle attachments.
        attachments = {
            -- The default folder to place images in via `:ObsidianPasteImg`.
            -- If this is a relative path it will be interpreted as relative to the vault root.
            -- You can always override this per image by passing a full path to the command instead of just a filename.
            img_folder = "assets/imgs", -- This is the default

            -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
            ---@return string
            img_name_func = function()
                -- Prefix image names with timestamp.
                return string.format("%s-", os.time())
            end,

            -- A function that determines the text to insert in the note when pasting an image.
            -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
            -- This is the default implementation.
            ---@param client obsidian.Client
            ---@param path obsidian.Path the absolute path to the image file
            ---@return string
            img_text_func = function(client, path)
                path = client:vault_relative_path(path) or path
                return string.format("![%s](%s)", path.name, path)
            end,
        },

        -- Optional, key mappings.
        mappings = {
            -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
            ["gf"] = {
                action = function() return require("obsidian").util.gf_passthrough() end,
                opts = { noremap = false, expr = true, buffer = true },
            },
        },

        -- Optional, configure additional syntax highlighting.
        syntax = {
            enable = true, -- set to false to disable
            chars = {
                todo = "󰄱", -- change to "☐" if you don't have a patched font
                done = "", -- change to "✔" if you don't have a patched font
            },
        },
    },
}
