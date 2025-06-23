print("Perform after/plugin/ftplugin/rust.lua")

local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set(
	"n", 
	"<leader>äg", 
	function()
		vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
		-- or vim.lsp.buf.codeAction() if you don't want grouping.
	end,
	{ silent = true, buffer = bufnr }
)

vim.keymap.set(
	"n", 
	"<leader>äh",  -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
	function()
		vim.cmd.RustLsp({'hover', 'actions'})
	end,
	{ silent = true, buffer = bufnr }
)

-- open doc.rs documentation for the symbol under the cursor
vim.keymap.set(
	"n", 
	"<leader>äd",
	function()
		vim.cmd.RustLsp({'openDocs'})
	end,
	{ silent = true, buffer = bufnr }
)
