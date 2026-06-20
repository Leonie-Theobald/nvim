print("Setup diagnostics.lua")

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
