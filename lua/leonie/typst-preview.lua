print("Setup typst-preview.lua")

vim.keymap.set("n", "<leader>tp", "<Cmd>TypstPreviewToggle<CR>")

-- allow reuse of preview window
vim.g.mkdp_auto_close = "0"
vim.g.mkdp_combine_preview = "1"
vim.g.mkdp_combine_preview_auto_refresh = "1"
