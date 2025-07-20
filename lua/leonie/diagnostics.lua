print("Setup diagnostics.lua")
-- vim.diagnostic.config({
-- 	virtual_text = {
-- 		prefix = '●',  -- Could be '●', '■', '▶', etc.
-- 		spacing = 4,
-- 	},
-- 	signs = true,
-- 	underline = true,
-- 	update_in_insert = false,
-- 	severity_sort = true,
-- })

-- Configure diagnostics globally
-- vim.diagnostic.config({
-- 	virtual_text = {
-- 		-- Only show errors as inline virtual text
-- 		severity = {
-- 			min = vim.diagnostic.severity.ERROR,
-- 			max = vim.diagnostic.severity.ERROR,
-- 		},
-- 		prefix = '●',  -- Customize this as you like
-- 	},
-- 	signs = true,
-- 	underline = true,
-- 	update_in_insert = false,
-- 	severity_sort = true,
-- 	float = {
-- 		border = "rounded",
-- 		source = "always", -- show source in the popup
-- 	},
-- })

-- only available if cursor directly on affected code
-- vim.keymap.set("n", "<leader>d", function()
-- 	local cursor_diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
-- 	if #cursor_diagnostics > 0 then
-- 		vim.diagnostic.open_float(nil, {
-- 			focusable = true,
-- 			border = "rounded",
-- 			source = "always",
-- 			scope = "cursor",
-- 		})
-- 	end
-- end, { desc = "Show floating window for diagnostics." })
-- 

vim.diagnostic.config({
	update_in_insert = true,
	float = {
		max_width = "100",
		header = "",
		focusable = false,
		border = "rounded",
		source = "always",
		-- Show all diagnostics for the line, not just under cursor
		scope = "line",
	}
})

vim.keymap.set("n", "<leader>dd", function()
	local current_line = vim.api.nvim_win_get_cursor(0)[1] - 1
	local diagnostics = vim.diagnostic.get(0, { lnum = current_line })

	if #diagnostics > 0 then
		vim.diagnostic.open_float() --nil, floating_window_config)
	end
end)

vim.keymap.set("n", "<leader>dn", function() vim.diagnostic.goto_next() end)
vim.keymap.set("n", "<leader>dp", function() vim.diagnostic.goto_prev() end)

vim.cmd [[
highlight DiagnosticHint  ctermfg=6
highlight DiagnosticInfo  ctermfg=6
highlight DiagnosticWarn  ctermfg=202
highlight DiagnosticError ctermfg=9 

highlight DiagnosticSignHint  ctermfg=6
highlight DiagnosticSignInfo  ctermfg=6
highlight DiagnosticSignWarn  ctermfg=202
highlight DiagnosticSignError ctermfg=9 

highlight DiagnosticFloating ctermfg=2
highlight NormalFloat ctermbg=0
highlight FloatBorder ctermfg=15 ctermbg=None
]]
