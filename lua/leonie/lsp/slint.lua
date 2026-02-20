vim.lsp.enable("slint-lsp")
vim.lsp.config("slint-lsp", {
	cmd = { 'slint-lsp' },
	filetypes = { 'slint' },
	root_markers = { '.git', 'Cargo.toml' },
})
