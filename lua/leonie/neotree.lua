print("Setup neotree.lua")

vim.keymap.set("n", "<leader>at", "<Cmd>Neotree toggle<CR>") -- close<CR><Cmd>Neotree show<CR>")
-- vim.keymap.set("n", "<leader>af", "<Cmd>Neotree focus<CR>")

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
			last_indent_marker = "│",
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
		popup_border_style = "",
		enable_git_status = false,
		enable_diagnostics = false,

	},
	git_status = {
		symbols = {
			-- Change type
			added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
			modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
			deleted = "", -- this can only be used in the git_status source
			renamed = "", -- this can only be used in the git_status source
			-- Status type
			untracked = "",
			ignored = "",
			unstaged = "",
			staged = "",
			conflict = "",
		},
	},

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

