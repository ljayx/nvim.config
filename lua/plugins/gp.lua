local function keymapOptions(desc)
    return {
        noremap = true,
        silent = true,
        nowait = true,
        desc = "GPT prompt " .. desc,
    }
end

return {
    "robitx/gp.nvim",
    event = "VeryLazy",
    config = function()
        require("gp").setup {
            openai_api_key = os.getenv("OPENAI_API_KEY"),
            chat_topic_gen_model = "gpt-4o-2024-05-13",
            providers = {
                openai = {
                    endpoint = os.getenv("OPENAI_API_ENDPOINT"),
                }
            },
            hooks = {
                -- example of adding command which explains the selected code
                Explain = function(gp, params)
                    local template = "I have the following code from {{filename}}:\n\n"
                        .. "```{{filetype}}\n{{selection}}\n```\n\n"
                        .. "Please respond by explaining the code above."
                    local agent = gp.get_chat_agent()
                    gp.Prompt(params, gp.Target.popup, agent, template)
                end,

                -- example of adding command which opens new chat dedicated for translation
                Translator = function(gp, params)
                    local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
                    gp.cmd.ChatNew(params, chat_system_prompt)
                    -- -- you can also create a chat with a specific fixed agent like this:
                    -- local agent = gp.get_chat_agent("ChatGPT4o")
                    -- gp.cmd.ChatNew(params, chat_system_prompt, agent)
                end,

                -- example of usig enew as a function specifying type for the new buffer
                CodeReview = function(gp, params)
                    local template = "I have the following code from {{filename}}:\n\n"
                        .. "```{{filetype}}\n{{selection}}\n```\n\n"
                        .. "Please analyze for code smells and suggest improvements."
                    local agent = gp.get_chat_agent()
                    gp.Prompt(params, gp.Target.enew("markdown"), agent, template)
                end,

                -- example of making :%GpChatNew a dedicated command which
                -- opens new chat with the entire current buffer as a context
                BufferChatNew = function(gp, _)
                    -- call GpChatNew command in range mode on whole buffer
                    vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
                end,
            },

            	agents = {
		{
			name = "GPT4o_1",
			chat = true,
			command = false,
			-- string with model name or table with model name and parameters
			-- model = { model = "gpt-4-1106-preview", temperature = 1.1, top_p = 1 },
			model = { model = "gpt-4o-2024-05-13", temperature = 1.1, top_p = 1 },
			-- system prompt (use this to specify the persona/role of the AI)
			-- system_prompt = ""
			system_prompt = "You are a general AI assistant. 请用中文回答。\n\n",
			-- 	.. "The user provided the additional info about how they would like you to respond:\n\n"
			-- 	.. "- If you're unsure don't guess and say you don't know instead.\n"
			-- 	.. "- Ask question if you need clarification to provide better answer.\n"
			-- 	.. "- Think deeply and carefully from first principles step by step.\n"
			-- 	.. "- Zoom out first to see the big picture and then zoom in to details.\n"
			-- 	.. "- Use Socratic method to improve your thinking and coding skills.\n"
			-- 	.. "- Don't elide any code from your output if the answer requires coding.\n"
			-- 	.. "- Take a deep breath; You've got this!\n",
		},
		{
			name = "GPT4o_2",
			chat = true,
			command = false,
			-- string with model name or table with model name and parameters
			model = { model = "gpt-4o-2024-05-13", temperature = 1.1, top_p = 1 },
			-- system prompt (use this to specify the persona/role of the AI)
			-- system_prompt = ""
			system_prompt = "You are a general AI assistant. 请用中文回答。\n\n",
			-- 	.. "The user provided the additional info about how they would like you to respond:\n\n"
			-- 	.. "- If you're unsure don't guess and say you don't know instead.\n"
			-- 	.. "- Ask question if you need clarification to provide better answer.\n"
			-- 	.. "- Think deeply and carefully from first principles step by step.\n"
			-- 	.. "- Zoom out first to see the big picture and then zoom in to details.\n"
			-- 	.. "- Use Socratic method to improve your thinking and coding skills.\n"
			-- 	.. "- Don't elide any code from your output if the answer requires coding.\n"
			-- 	.. "- Take a deep breath; You've got this!\n",
		},
		{
			name = "CodeGPT4o_1",
			chat = false,
			command = true,
			-- string with model name or table with model name and parameters
			model = { model = "gpt-4o-2024-05-13", temperature = 0.8, top_p = 1 },
			-- model = { model = "gpt-4-1106-preview", temperature = 0.8, top_p = 1 },
			-- system prompt (use this to specify the persona/role of the AI)
			system_prompt = "You are an AI working as a code editor.\n\n"
				.. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
				.. "START AND END YOUR ANSWER WITH:\n\n```",
		},
		{
			name = "CodeGPT4o_2",
			chat = false,
			command = true,
			-- string with model name or table with model name and parameters
			model = { model = "gpt-4o-2024-05-13", temperature = 0.8, top_p = 1 },
			-- model = { model = "gpt-3.5-turbo-1106", temperature = 0.8, top_p = 1 },
			-- system prompt (use this to specify the persona/role of the AI)
			system_prompt = "You are an AI working as a code editor.\n\n"
				.. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
				.. "START AND END YOUR ANSWER WITH:\n\n```",
		},
	},

            vim.keymap.set({ "n", "i" }, "<localleader>gc", "<cmd>GpChatNew<cr>", keymapOptions "New Chat"),
            vim.keymap.set({ "n", "i" }, "<localleader>gt", "<cmd>GpChatToggle<cr>", keymapOptions "Toggle Chat"),
            vim.keymap.set({ "n", "i" }, "<localleader>gf", "<cmd>GpChatFinder<cr>", keymapOptions "Chat Finder"),
            vim.keymap.set("v", "<localleader>gc", ":<C-u>'<,'>GpChatNew<cr>", keymapOptions "Visual Chat New"),
            vim.keymap.set("v", "<localleader>gp", ":<C-u>'<,'>GpChatPaste<cr>", keymapOptions "Visual Chat Paste"),
            vim.keymap.set("v", "<localleader>gt", ":<C-u>'<,'>GpChatToggle<cr>", keymapOptions "Visual Toggle Chat"),

            -- vim.keymap.set({ "n", "i" }, "<C-g><C-x>", "<cmd>GpChatNew split<cr>", keymapOptions "New Chat split"),
            -- vim.keymap.set({ "n", "i" }, "<C-g><C-v>", "<cmd>GpChatNew vsplit<cr>", keymapOptions "New Chat vsplit"),
            -- vim.keymap.set({ "n", "i" }, "<C-g><C-t>", "<cmd>GpChatNew tabnew<cr>", keymapOptions "New Chat tabnew"),

            -- vim.keymap.set("v", "<C-g><C-x>", ":<C-u>'<,'>GpChatNew split<cr>", keymapOptions "Visual Chat New split"),
            -- vim.keymap.set("v", "<C-g><C-v>", ":<C-u>'<,'>GpChatNew vsplit<cr>", keymapOptions "Visual Chat New vsplit"),
            -- vim.keymap.set("v", "<C-g><C-t>", ":<C-u>'<,'>GpChatNew tabnew<cr>", keymapOptions "Visual Chat New tabnew"),

            -- Prompt commands
            vim.keymap.set({ "n", "i" }, "<localleader>gr", "<cmd>GpRewrite<cr>", keymapOptions "Inline Rewrite"),
            vim.keymap.set({ "n", "i" }, "<localleader>ga", "<cmd>GpAppend<cr>", keymapOptions "Append (after)"),
            vim.keymap.set({ "n", "i" }, "<localleader>gb", "<cmd>GpPrepend<cr>", keymapOptions "Prepend (before)"),

            vim.keymap.set("v", "<localleader>gr", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions "Visual Rewrite"),
            vim.keymap.set("v", "<localleader>ga", ":<C-u>'<,'>GpAppend<cr>", keymapOptions "Visual Append (after)"),
            vim.keymap.set("v", "<localleader>gb", ":<C-u>'<,'>GpPrepend<cr>", keymapOptions "Visual Prepend (before)"),
            vim.keymap.set("v", "<localleader>gi", ":<C-u>'<,'>GpImplement<cr>", keymapOptions "Implement selection"),

            vim.keymap.set({ "n", "i" }, "<localleader>ggp", "<cmd>GpPopup<cr>", keymapOptions "Popup"),
            vim.keymap.set({ "n", "i" }, "<localleader>gge", "<cmd>GpEnew<cr>", keymapOptions "GpEnew"),
            vim.keymap.set({ "n", "i" }, "<localleader>ggn", "<cmd>GpNew<cr>", keymapOptions "GpNew"),
            vim.keymap.set({ "n", "i" }, "<localleader>ggv", "<cmd>GpVnew<cr>", keymapOptions "GpVnew"),
            vim.keymap.set({ "n", "i" }, "<localleader>ggt", "<cmd>GpTabnew<cr>", keymapOptions "GpTabnew"),

            vim.keymap.set("v", "<localleader>ggp", ":<C-u>'<,'>GpPopup<cr>", keymapOptions "Visual Popup"),
            vim.keymap.set("v", "<localleader>gge", ":<C-u>'<,'>GpEnew<cr>", keymapOptions "Visual GpEnew"),
            vim.keymap.set("v", "<localleader>ggn", ":<C-u>'<,'>GpNew<cr>", keymapOptions "Visual GpNew"),
            vim.keymap.set("v", "<localleader>ggv", ":<C-u>'<,'>GpVnew<cr>", keymapOptions "Visual GpVnew"),
            vim.keymap.set("v", "<localleader>ggt", ":<C-u>'<,'>GpTabnew<cr>", keymapOptions "Visual GpTabnew"),

            vim.keymap.set({ "n", "i" }, "<localleader>gx", "<cmd>GpContext<cr>", keymapOptions "Toggle Context"),
            vim.keymap.set("v", "<localleader>gx", ":<C-u>'<,'>GpContext<cr>", keymapOptions "Visual Toggle Context"),

            vim.keymap.set({ "n", "i", "v", "x" }, "<localleader>gs", "<cmd>GpStop<cr>", keymapOptions "Stop"),
            vim.keymap.set(
                { "n", "i", "v", "x" },
                "<localleader>gn",
                "<cmd>GpNextAgent<cr>",
                keymapOptions "Next Agent"
            ),

            vim.keymap.set("v", "<localleader>gh", ":<C-u>'<,'>GpTranslator<cr>", keymapOptions "Translate"),
            vim.keymap.set("v", "<localleader>gd", ":<C-u>'<,'>GpCodeReview<cr>", keymapOptions "Code Review"),
            vim.keymap.set("v", "<localleader>ge", ":<C-u>'<,'>GpExplain<cr>", keymapOptions "Code Explain"),
            vim.keymap.set("n", "<localleader>ggx", "<cmd>GpChatDelete<cr>", keymapOptions "Delete current Chat"),
            vim.keymap.set("n", "<localleader>gk", "<cmd>GpBufferChatNew<cr>", keymapOptions "Buffer Chat New"),
        }

        -- or setup with your own config (see Install > Configuration in Readme)
        -- require("gp").setup(config)

        -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
    end,
}

