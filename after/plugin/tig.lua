print("Perform after/plugin/tig.lua")

local tig_win = nil
local tig_buf = nil

function ToggleTigAll()
	if tig_win and vim.api.nvim_win_is_valid(tig_win) then
		vim.api.nvim_win_close(tig_win, true)
		tig_win = nil
		tig_buf = nil
		return
	end

	tig_buf = vim.api.nvim_create_buf(false, true)

	local width = math.floor(vim.o.columns * 0.9)
	local height = math.floor(vim.o.lines * 0.9)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	tig_win = vim.api.nvim_open_win(tig_buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	vim.fn.termopen("tig --all", {
		on_exit = function()
			if vim.api.nvim_win_is_valid(tig_win) then
				vim.api.nvim_win_close(tig_win, true)
			end
			tig_win = nil
			tig_buf = nil
		end
	})

	vim.cmd("startinsert")
end

vim.keymap.set("n", "§§", ToggleTigAll, { noremap = true, silent = true })
