-- Make sure this is after 'nvim-lspconfig' is loaded
-- local lspconfig = require('lspconfig')

-- lspconfig.rust_analyzer.setup({
--   on_attach = function(client, bufnr)
--     -- Optional: add LSP keymaps
--     vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
--     vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
--   end,
--   settings = {
--     ["rust-analyzer"] = {
--       cargo = { allFeatures = true },
--       checkOnSave = { command = "clippy" },
--       completion = {
--         autoimport = { enable = true },
--       },
--     },
--   },
-- })
--

vim.keymap.set("n", "K", function()
	vim.lsp.buf.hover({
		border = "rounded"
	})
end)

vim.lsp.enable("rust_analyzer")
vim.lsp.config('rust_analyzer', {
	on_attach = on_attach,
	settings = {
		['rust-analyzer'] = {
			diagnostics = {
				enable = false,
				styleLints = { enable = true },
			},
			completion = {
				autoimport = { enable = true },
				autoself = { enable = true },
				fullFunctionSignature = { enable = true },
				postfix = { enable = true },
			},
			check = { command = "clippy" },
			cargo = { allFeatures = true },
		}
	}
})
