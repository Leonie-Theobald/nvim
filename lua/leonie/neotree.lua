print("Setup neotree.lua")

vim.keymap.set("n", "<leader>acf", "<Cmd>Neotree close<CR><Cmd>Neotree show<CR>")
vim.keymap.set("n", "<leader>aff", "<Cmd>Neotree focus<CR>")
vim.keymap.set("n", "<leader>acc", "<Cmd>Neotree close<CR>")

require("neo-tree").setup({
	default_component_configs = {
		container = {
			enable_character_fade = true,
		},
		indent = {
			indent_size = 5,
			padding = 1, -- extra padding on left hand side
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "└",
			highlight = "NeoTreeIndentMarker",
			-- expander config, needed for nesting files
			with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
			expander_collapsed = "■",
			expander_expanded = "□",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "■",
			folder_open = "□",
			folder_empty = "⛶",
		},
		modified = {
			symbol = "[+]",
			highlight = "NeoTreeModified",
		},
	},
	--[[ git_status = {
		symbols = {
			-- Change type
			added = "n", -- or "✚", but this is redundant info if you use git_status_colors on the name
			modified = "m", -- or "", but this is redundant info if you use git_status_colors on the name
			deleted = "x", -- this can only be used in the git_status source
			renamed = "r", -- this can only be used in the git_status source
			-- Status type
			untracked = "UNT",
			ignored = "IGN",
			unstaged = "NST",
			staged = "ST",
			conflict = "CON",
		},
	}, ]]

	filesystem = {
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
		},
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},
		group_empty_dirs = true,
	}
})

