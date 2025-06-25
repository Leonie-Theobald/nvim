print("Setup markdown-preview.lua")

vim.keymap.set("n", "<leader>mp", "<Cmd>MarkdownPreviewToggle<CR>")

-- allow reuse of preview window
vim.g.mkdp_auto_close = "0"
vim.g.mkdp_combine_preview = "1"
vim.g.mkdp_combine_preview_auto_refresh = "1"
