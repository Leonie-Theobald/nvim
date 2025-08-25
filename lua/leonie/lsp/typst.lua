require("lspconfig")["tinymist"].setup {
	settings = {
		formatterMode = "typstyle",
		exportPdf = "onSave",
		semanticTokens = "disable",
		lint = {
			enabled = true,
		},
	}
}
