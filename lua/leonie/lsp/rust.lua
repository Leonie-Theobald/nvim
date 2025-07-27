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

vim.keymap.set({"i", "n"}, ";;", function()
	local line = vim.api.nvim_get_current_line()
	if not line:match(";%s*$") then
		vim.api.nvim_set_current_line(line .. ";")
	end
end, { desc = "Add semicolon at end of line" })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = false

vim.lsp.enable("rust_analyzer")
vim.lsp.config('rust_analyzer', {
	capabilities = capabilities,
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

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.rs",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})
