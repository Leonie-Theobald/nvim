print("Perform after/plugin/undotree.lua")

vim.keymap.set("n", "<C-u>", vim.cmd.UndotreeToggle)
