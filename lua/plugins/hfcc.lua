return {
    --"huggingface/hfcc.nvim",
    --event = "InsertEnter",
    --config = function()
    --    require("hfcc").setup {
    --        api_token = "your token", -- cf Install paragraph
    --        api_token = "", -- cf Install paragraph
    --        model = "bigcode/starcoder", -- can be a model ID or an http(s) endpoint
    --        -- parameters that are added to the request body
    --        query_params = {
    --            max_new_tokens = 60,
    --            temperature = 0.2,
    --            top_p = 0.95,
    --            stop_token = "<|endoftext|>",
    --        },
    --        -- set this if the model supports fill in the middle
    --        fim = {
    --            enabled = true,
    --            prefix = "<fim_prefix>",
    --            middle = "<fim_middle>",
    --            suffix = "<fim_suffix>",
    --        },
    --        debounce_ms = 80,
    --        accept_keymap = "<Tab>",
    --        dismiss_keymap = "<S-Tab>",
    --        max_context_after = 5000,
    --        max_context_before = 5000,
    --        tls_skip_verify_insecure = false,
    --    }
    --end,
}

