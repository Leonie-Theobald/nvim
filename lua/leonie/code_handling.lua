print("Setup code_handling.lua")

vim.keymap.set("n", "<leader>gD", vim.lsp.buf.definition, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>gR", vim.lsp.buf.references, { noremap = true, silent = true })
vim.keymap.set("n", "<leader>gT", vim.lsp.buf.rename, { noremap = true, silent = true })
