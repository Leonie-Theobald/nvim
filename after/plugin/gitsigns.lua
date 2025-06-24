print("Perform after/plugin/gitsigns.lua")

vim.keymap.set("n", "<leader>gh", function()
	vim.cmd("Gitsign toggle_linehl")
	require("gitsigns").refresh()
end)

-- vim.cmd("set statusline+=%{get(b:,'gitsigns_status','')}")

vim.api.nvim_set_hl(0, "GitSignsAddLn",    { ctermbg = 22 })  -- greenish background for added lines
vim.api.nvim_set_hl(0, "GitSignsChangeLn", { ctermbg = 17 })  -- blueish background for changed lines
vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { ctermbg = 0 })  -- reddish background for deleted lines
vim.api.nvim_set_hl(0, "GitSignsUntrackedLn", { })  -- no background

vim.api.nvim_set_hl(0, "GitSignsAdd",    { ctermfg = 28 })  -- greenish font color for added lines
vim.api.nvim_set_hl(0, "GitSignsChange", { ctermfg = 27 })  -- blueish font color for changed lines
vim.api.nvim_set_hl(0, "GitSignsDelete", { ctermfg = 1 })  -- reddish font color for deleted lines
vim.api.nvim_set_hl(0, "GitSignsUntracked", { ctermfg = 239 })  -- greyish font color for deleted lines

vim.api.nvim_set_hl(0, "GitSignsStagedAddLn",    { ctermbg = 22 })  -- greenish background for added lines
vim.api.nvim_set_hl(0, "GitSignsStagedChangeLn", { ctermbg = 17 })  -- blueish background for changed lines
vim.api.nvim_set_hl(0, "GitSignsStagedDeleteLn", { })  -- no background of deleted lines
vim.api.nvim_set_hl(0, "GitSignsStagedUntrackedLn", { })  -- no background of deleted lines 

vim.api.nvim_set_hl(0, "GitSignsStagedAdd",    { ctermfg = 28 })  -- greenish symbol for added lines
vim.api.nvim_set_hl(0, "GitSignsStagedChange", { ctermfg = 27 })  -- blueish symbol for changed lines
vim.api.nvim_set_hl(0, "GitSignsStagedDelete", { ctermfg = 1 })  -- reddish symbol for deleted lines
vim.api.nvim_set_hl(0, "GitSignsStagedUntracked", { ctermfg = 239 })  -- greyish symbol for deleted lines

require('gitsigns').setup {
	signs_staged = {
		-- add          = { text = "+", hl = "GitSignStagedAdd", numhl = "", linehl = "GitSignsStagedAddLn" },
	    	-- change       = { text = "~", hl = "GitSignStagedChange", numhl = "", linehl = "GitSignsStagedChangeLn" },
		-- untracked    = { text = "┆", hl = "GitSignStagedUntracked", numhl = "", linehl = "GitSignsStagedUntrackedLn" },
	     	-- delete       = { hl = "GitSignsStagedDelete", text = "_", numhl = "", linehl = "" },
	     	-- topdelete    = { hl = "GitSignsStagedDelete", text = "‾", numhl = "", linehl = "" },
	     	-- changedelete = { hl = "GitSignsStagedChange", text = "-", numhl = "", linehl = "" }
		add          = { text = "+" },
	    	change       = { text = "~" },
		untracked    = { text = "┆" },
	     	delete       = { text = "_" },
	     	topdelete    = { text = "‾" },
	     	changedelete = { text = "-" }
	},
	signs = {
		add          = { text = "+" },
	    	change       = { text = "~" },
		untracked    = { text = "┆" },
	     	delete       = { text = "_" },
	     	topdelete    = { text = "‾" },
	     	changedelete = { text = "-" }
	},
	diff_opts = {
		cached = true,
	},
	signs_staged_enable = true,
	signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
	numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl     = true, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
	watch_gitdir = {
		follow_files = true
	},
	auto_attach = true,
	attach_to_untracked = true,
	current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
		use_focus = true,
	},
	current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000, -- Disable if file is longer than this (in lines)
	preview_config = {
		-- Options passed to nvim_open_win
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1
	},
}
