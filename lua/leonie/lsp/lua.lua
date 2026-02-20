vim.lsp.enable("lua_ls")
vim.lsp.config("lua_ls", {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { '.git' },
	settings = {
		Lua = {
			diagnositcs = {
				globals = { "vim" }
			}
		}
	}
})
