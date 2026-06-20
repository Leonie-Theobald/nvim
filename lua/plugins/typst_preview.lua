return {
	"chomosuke/typst-preview.nvim",

	ft = { "typst" },

	build = function()
		require("typst-preview").update()
	end,

	config = function()
		print("Setup typst-preview.lua")

		require 'typst-preview'.setup {

			follow_cursor = true,

			vim.keymap.set("n", "<leader>tp", "<Cmd>TypstPreviewToggle<CR>"),
		}
	end,
}
