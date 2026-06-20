return {
	"iamcco/markdown-preview.nvim",
	cmd = {
		"MarkdownPreviewToggle",
		"MarkdownPreview",
		"MarkdownPreviewStop",
	},
	ft = { "markdown" },
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }


		vim.g.mkdp_filetypes = { "markdown" }

		-- allow reuse of preview window
		vim.g.mkdp_auto_close = 0
		vim.g.mkdp_combine_preview = 1
		vim.g.mkdp_combine_preview_auto_refresh = 1

		vim.keymap.set("n", "<leader>mp", "<Cmd>MarkdownPreviewToggle<CR>")
	end
}
