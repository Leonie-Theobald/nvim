print("Setup neotree.lua")

vim.keymap.set("n", "<leader>att", "<Cmd>Neotree toggle<CR>") -- toggles visibility of neotree
vim.keymap.set("n", "<leader>atf", "<Cmd>Neotree focus<CR>") -- jumps to neotree from current file 

vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { ctermfg=218 }) -- changes file name and letter for unstaged
vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { ctermfg=243 }) -- grey line for files in .gitignore
vim.api.nvim_set_hl(0, "NeoTreeGitUnstaged", { ctermfg=204 }) -- pink letter for Unstaged
vim.api.nvim_set_hl(0, "NeoTreeGitStaged", { ctermfg=46 }) -- green letter for Staged
vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { ctermfg=1 }) -- mark conflict files red

vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { ctermfg=15 }) -- make directory font default 
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { }) -- make directory icon default 

local function git_status_placeholder(_, node, _)
	-- Always show two spaces if no git status
end

function abc_text()
	return {
		text = " abc ",
		highlight = "Comment",
	}
end

require("neo-tree").setup({
	source_selector = {
		sources = { 
			{
				source = "filesystem",
				display_name = "TREE",
			},
			{
				source = "git_status",
				display_name = "STATUS"
			}
		}
	},
	enable_git_status = true,
	sort_function = function (a, b)
		return a.path < b.path
	end,
	default_component_configs = {
		indent = {
			indent_size = 2,
			padding = 1, -- extra padding on left hand side
			-- indent guides
			with_markers = true,
			indent_marker = "│",
			last_indent_marker = "│",
			highlight = "NeoTreeIndentMarker",
			-- expander config, needed for nesting files
			-- if nil and file nesting is enabled, will enable expanders
			with_expanders = nil, 
			expander_collapsed = "■",
			expander_expanded = "□",
			expander_highlight = "NeoTreeExpander",
		},
		icon = {
			folder_closed = "■",
			folder_open = "□",
			folder_empty = "⛶",
			default = " ",
			hightlight = "",
		},
		-- modified = {
		-- 	symbol = "~",
		-- 	highlight = "",
		-- },
		enable_git_status = true,
		enable_diagnostics = false,

		diagnostic = {
			enabled = true,
			symbols = {
				hint = "H",
				info = "I",
				warn = "W",
				error = "E",
			}
		},
		git_status = {
			enabled = true,
			symbols = {
				-- Change type
				added = "",
				modified = "",
				deleted = "",
				renamed = "",
				-- Status type
				untracked = " U",
				ignored = " I",
				unstaged = "Z",
				staged = " S",
				conflict = " C",
			},
			highlight = true,
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
		components = {
			git_status_or_empty = function(config, node, state)
				local result = require("neo-tree.sources.common.components")
					.git_status(config, node, state)

				if result.text == nil then
					return {
						text = "GG",
						highlight = "Normal"
					}
				else
					return result
				end
			end,
			diagnostics_or_empty = function(config, node, state)
				local result = require("neo-tree.sources.common.components")
					.diagnostics(config, node, state)

				if result.text == nil then
					return {
						text = "-",
						highlight = "Normal"
					}
				else
					return result
				end
			end
		},
		renderers = {
			directory = {
				{ "icon" },
				-- { "git_status_or_empty" },
				{ "diagnostics_or_empty" },
				{ "name" },
				{ "git_status" },
				-- { "diagnostics" },
			},
			file = {
				{ "icon" },
				-- { "git_status_or_empty" },
				{ "diagnostics_or_empty" },
				{ "name" },
				{ "git_status" },
				-- { "diagnostics" },
			},
		},
	},
})
