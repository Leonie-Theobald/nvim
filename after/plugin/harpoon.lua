print("Perform after/plugin/harpoon.lua")

local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<C-i>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<C-o>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<C-p>", function() harpoon:list():select(3) end)
