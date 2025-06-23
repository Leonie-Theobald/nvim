print("Perform after/plugin/remap.lua")

vim.keymap.set("n", "<leader>ca", vim.cmd.Ex)

-- vim.keymap.set("n", vim.cmd("terminal"), vim.cmd("t"))

vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set("n", "-", [[<cmd>vertical resize -2<cr>]], { desc = "Decrease window width" })
vim.keymap.set("n", "+", [[<cmd>vertical resize +2<cr>]], { desc = "Increase window width" })
vim.keymap.set("n", "_", [[<cmd>horizontal resize -2<cr>]], { desc = "Decrease window height, by pressing <Shift>-" })
vim.keymap.set("n", "*", [[<cmd>horizontal resize +2<cr>]], { desc = "Increase window height, by pressing <Shift>+" })

vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h')
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j')
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k')
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l')
