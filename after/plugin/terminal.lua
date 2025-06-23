print("Perform after/plugin/terminal.lua")

-- Noch aufsplitten, dass man in normal mode erst noch das fenster öffnet
-- das könnte eigene Funktion sein 

vim.keymap.set("n", "<leader>gs", "<C-w>s<C-w>j:terminal<CR>i git status<CR>")
vim.keymap.set("t", "<leader>adog", "git log --all --decorate --oneline --graph<CR>")

