print("Setup neotree.lua")

vim.keymap.set("n", "<leader>att", "<Cmd>Neotree toggle<CR>") -- toggles visibility of neotree
vim.keymap.set("n", "<leader>atf", "<Cmd>Neotree focus<CR>") -- jumps to neotree from current file 

vim.api.nvim_set_hl(0, "NeoTreeDarkFont", { ctermfg = 236 })

vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { ctermfg=218 }) -- changes file name and letter for unstaged
vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { ctermfg=240 }) -- grey line for files in .gitignore
vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { ctermfg=214 }) -- orange letter for Untracked
vim.api.nvim_set_hl(0, "NeoTreeGitUnstaged", { ctermfg=204 }) -- pink letter for Unstaged
vim.api.nvim_set_hl(0, "NeoTreeGitStaged", { ctermfg=46 }) -- green letter for Staged
vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { ctermfg=1 }) -- mark conflict files red

vim.api.nvim_set_hl(0, "DiagnosticsHint", { ctermfg=6 }) -- mark conflict files red
vim.api.nvim_set_hl(0, "DiagnosticsInfo", { ctermfg=6 }) -- mark conflict files red
vim.api.nvim_set_hl(0, "DiagnosticsWarning", { ctermfg=202 }) -- mark conflict files red
vim.api.nvim_set_hl(0, "DiagnosticsError", { ctermfg=9 }) -- mark conflict files red

vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { ctermfg=15 }) -- make directory font default 
vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { }) -- make directory icon default 

require("neo-tree").setup({
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
			highlight = "NeoTreeDarkFont",
			-- expander config, needed for nesting files
			-- if nil and file nesting is enabled, will enable expanders
			with_expanders = nil, 
			expander_collapsed = "■",
			expander_expanded = "□",
			expander_highlight = "NeoTreeDarkFont",
		},
		icon = {
			folder_closed = "■",
			folder_open = "□",
			folder_empty = "⛶",
			default = " ",
			hightlight = "NeoTreeDarkFont",
		},
		-- modified = {
		-- 	symbol = "~",
		-- 	highlight = "",
		-- },
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
			git_status_or_default = function(config, node, state)
				local git_status = require("neo-tree.sources.common.components")
					.git_status(config, node, state).text

				-- not part of git status
				if git_status == nil then
					return {
						text = "-",
						highlight = "NeoTreeDarkFont"
					}
				-- untracked
				elseif git_status == "[?]" then
					return {
						text = "U",
						highlight = "NeoTreeGitUntracked"
					}	
				-- ignored
				elseif git_status == "[!!]" then
					return {
						text = "I",
						highlight = "NeoTreeGitIgnored"
					}	
				-- unstaged or modified
				elseif git_status == "[ M]" or git_status == "[M]" then
					return {
						text = "Z",
						highlight = "NeoTreeGitUnstaged"
					}	
				-- deleted
				elseif git_status == "[D]" then
					return {
						text = "D",
						highlight = "NeoTreeGitUnstaged"
					}	
				-- staged
				elseif git_status == "[A]" then
					return {
						text = "S",
						highlight = "NeoTreeGitStaged"
					}	
				-- partially staged and modified/unstaged
				-- happens if a file is staged and then modified again
				elseif git_status == "[MM]" then
					return {
						text = "5",
						highlight = "NeoTreeGitUnstaged"
					}	
				-- conflict
				elseif git_status == "[C]" then
					return {
						text = "C",
						highlight = "NeoTreeGitConflict"
					}	
				-- missing git status symbol
				else
					return {
						text = git_status,
						highlight = "DiagnosticsError"
					}
				end
			end,
			diagnostics_or_default = function(config, node, state)
				local diagnostics = require("neo-tree.sources.common.components")
					.diagnostics(config, node, state).text

				-- not part of diagnostics
				-- Hints don't need to show up next to file
				-- They accompany an error or warning anyways
				if diagnostics == nil or diagnostics == "H" then
					return {
						text = "-",
						highlight = "NeoTreeDarkFont"
					}
				-- info
				elseif diagnostics == "I" then
					return {
						text = "I",
						highlight = "DiagnosticsInfo"
					}
				-- warning
				elseif diagnostics == "W" then
					return {
						text = "W",
						highlight = "DiagnosticsWarning"
					}
				-- error
				elseif diagnostics == "E" then
					return {
						text = "E",
						highlight = "DiagnosticsError"
					}
				-- missing diagnostics symbol
				else
					return {
						text = diagnostics,
						highlight = "DiagnosticsError"
					}
				end
			end
		},
		renderers = {
			directory = {
				{ "icon" },
				{ "git_status_or_default" },
				{ "diagnostics_or_default" },
				{ "name" },
				-- { "git_status" },
				-- { "diagnostics" },
			},
			file = {
				{ "icon" },
				{ "git_status_or_default" },
				{ "diagnostics_or_default" },
				{ "name" },
				-- { "git_status" },
				-- { "diagnostics" },
			},
		},
	},
})
