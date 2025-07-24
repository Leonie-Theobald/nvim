print("Perform after/plugin/terminal.lua")

local function open_split_terminal_window(cmd)
	vim.cmd.split()
	vim.cmd.wincmd('w')
	vim.cmd("terminal " .. cmd .. "; exec $SHELL")
	vim.cmd("startinsert")

end

local function get_root()
	local bufname = vim.api.nvim_buf_get_name(0)
	local root = require("lspconfig.util").root_pattern("Cargo.toml")(bufname)
	return root
end

vim.keymap.set("n", "<leader>gs", function()
	open_split_terminal_window("git status")
end)
vim.keymap.set("n", "<leader>adog", function()
	open_split_terminal_window("git log --all --decorate --oneline --graph")
end)
vim.keymap.set("n", "<leader>br", function()
	open_split_terminal_window("cd " .. get_root() .. "; clear; cargo run")
end)
vim.keymap.set("n", "<leader>bb", function()
	open_split_terminal_window("cd " .. get_root() .. "; clear; cargo build")
end)
vim.keymap.set("n", "<leader>bt", function()
	open_split_terminal_window("cd " .. get_root() .. "; clear; cargo test --all-targets")
end)

vim.keymap.set("t", "<leader>gs", "git status<CR>")
vim.keymap.set("t", "<leader>adog", "git log --all --decorate --oneline --graph<CR>")
vim.keymap.set("t", "<leader>br", "clear; cargo run<CR>")
vim.keymap.set("t", "<leader>bb", "clear; cargo build<CR>")
vim.keymap.set("t", "<leader>bt", "clear; cargo test --all-targets<CR>")
