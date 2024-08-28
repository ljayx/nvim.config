-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
    lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo(
    { { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } },
    true, {})
    vim.fn.getchar()
    vim.cmd.quit()
end

require "lazy_setup"
require "polish"

local on_attach = function(client, bufnr)
    -- 常见的快捷键映射
    local opts = { noremap = true, silent = true, desc = "go to definition" }
    vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = { "utf-16" }
require("lspconfig").clangd.setup { capabilities = capabilities, on_attach = on_attach }

-- obsidian needs
vim.opt.conceallevel = 1
vim.o.wrap = true
-- vim.api.nvim_create_autocmd("FileType", {
--     pattern = "markdown",
--     callback = function() vim.opt_local.wrap = true end,
-- })
