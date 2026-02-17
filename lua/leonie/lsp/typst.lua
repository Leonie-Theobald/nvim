vim.lsp.enable("tinymist")
vim.lsp.config("tinymist", {
	settings = {
		formatterMode = "typstyle",
		exportPdf = "onSave",
		semanticTokens = "disable",
		lint = {
			enabled = true,
		},
	}
  	filetypes = { 'slint' },
})
