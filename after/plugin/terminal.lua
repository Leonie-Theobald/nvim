print("Perform after/plugin/terminal.lua")

local function open_split_terminal_window(cmd)
	vim.cmd.split()
	vim.cmd.wincmd('w')
	vim.cmd("terminal " .. cmd .. "; exec $SHELL")
	vim.cmd("startinsert")

end

vim.keymap.set("n", "<leader>gs", function()
	open_split_terminal_window("git status")
end)
vim.keymap.set("n", "<leader>adog", function()
	open_split_terminal_window("git log --all --decorate --oneline --graph")
end)


vim.keymap.set("t", "<leader>gs", "git status<CR>")
vim.keymap.set("t", "<leader>adog", "git log --all --decorate --oneline --graph<CR>")
