-- these match git porcelain status
local git_symbols = {
	added     = "A",
	modified  = "M",
	deleted   = "D",
	renamed   = "R",
	untracked = "XX",
	ignored   = "I",
	unstaged  = "U",
	staged    = "S",
	conflict  = "C",
}

return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		print("Setup neotree.lua")

		require("neo-tree").setup({
			sort_function = function (a, b)
				return a.path < b.path
			end,

			vim.keymap.set("n", "<leader>att", "<Cmd>Neotree toggle<CR>"), -- toggles visibility of neotree
			vim.keymap.set("n", "<leader>atf", "<Cmd>Neotree focus<CR>"), -- jumps to neotree from current file 

			vim.api.nvim_set_hl(0, "NeoTreeDarkFont", { ctermfg = 236 }),
			vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { ctermfg = 218 }), -- changes file name and letter for unstaged
			vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { ctermfg = 240 }), -- grey line for files in .gitignore
			vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { ctermfg = 214 }), -- orange letter for Untracked
			vim.api.nvim_set_hl(0, "NeoTreeGitUnstaged", { ctermfg = 204 }), -- pink letter for Unstaged
			vim.api.nvim_set_hl(0, "NeoTreeGitStaged", { ctermfg = 46 }), -- green letter for Staged
			vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { ctermfg = 1 }), -- mark conflict files red

			vim.api.nvim_set_hl(0, "DiagnosticsHint", { ctermfg = 6 }), -- mark conflict files red
			vim.api.nvim_set_hl(0, "DiagnosticsInfo", { ctermfg = 6 }), -- mark conflict files red
			vim.api.nvim_set_hl(0, "DiagnosticsWarning", { ctermfg = 202 }), -- mark conflict files red
			vim.api.nvim_set_hl(0, "DiagnosticsError", { ctermfg = 9 }), -- mark conflict files red

			vim.api.nvim_set_hl(0, "NeoTreeFileName", { ctermfg = 15 }), -- make directory font default 
			vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { ctermfg = 15 }), -- make directory font default 
			vim.api.nvim_set_hl(0, "NeoTreeDirectoryIcon", { ctermfg = 242 }),

			vim.api.nvim_set_hl(0, "NeoTreeModified", { ctermfg=197 }), -- make directory font default 

			sources = { "filesystem", "git_status", "buffers" },

			git_status = {
				show_untracked = true,
			},

			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false,
				},
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				group_empty_dirs = true,
				components = {
					git_status_or_default = function(config, node, state)
						-- This is copied from neo-tree.nvim/lua/neo-tree/sources/common/components.lua
						-- The following didn't work anymore as it didn't distinguish untracked files
						-- local git_status = require("neo-tree.sources.common.components")
						-- .git_status(config, node, state).text
						local node_is_dir = node.type == "directory"
						if node.type == "message" then
							return {}
						end

						if node_is_dir and config.hide_when_expanded and node:is_expanded() then
							return {}
						end

						local path = node.path
						local git_status, status_from_diff = require("neo-tree.git").find_existing_status_code(path, state.git_base_by_worktree)

						-- File is tracked but not changed in any way
						if not git_status then
							return { text = "-", highlight = "NeoTreeDarkFont" }
						end

						if type(git_status) == "table" then
							git_status = git_status[1]
						end

						-- own definition for git symbols
						if git_status == nil then
							-- not part of git status
							return { text = "nil", highlight = "NeoTreeDarkFont" }
						elseif git_status == "?" or git_status == "??" then
							-- untracked
							return { text = "U", highlight = "NeoTreeGitUntracked" }	
						elseif git_status == "!" or git_status == "!!" then
							-- ignored
							return { text = "I", highlight = "NeoTreeGitIgnored" }	
						elseif git_status == " M" or git_status == "M" or git_status == ".M" then
							-- unstaged or modified
							return { text = "Z", highlight = "NeoTreeGitUnstaged" }	
						elseif git_status == "R100" or git_status == "R." then
							-- renamed
							return { text = "R", highlight = "NeoTreeGitStaged" }	
						elseif git_status == "D" then
							-- deleted
							return { text = "D", highlight = "NeoTreeGitUnstaged" }	
						elseif git_status == "A" or git_status == "A." or git_status == "M." then
							-- staged
							return { text = "S", highlight = "NeoTreeGitStaged" }	
						elseif git_status == "MM" or git_status == "AM" then
							-- happens if a file is staged and then modified again
							return { text = "5", highlight = "NeoTreeGitUnstaged" }	
						elseif git_status == "C" then
							-- conflict
							return { text = "C", highlight = "NeoTreeGitConflict" }	
						elseif git_status == "U" or git_status == "UU" then
							-- unmerged
							return { text = "C", highlight = "NeoTreeGitConflict" }	
						else
							-- missing git status symbol
							return { text = git_status, highlight = "DiagnosticsError" }
						end
					end,
					diagnostics_or_default = function(config, node, state)
						local diagnostics = require("neo-tree.sources.common.components")
						.diagnostics(config, node, state).text

						-- not part of diagnostics
						-- Hints don't need to show up next to file
						-- They accompany an error or warning anyways
						if diagnostics == nil or diagnostics == "H" or diagnostics == "" then
							return { text = "-", highlight = "NeoTreeDarkFont" }
						elseif diagnostics == "I" then
							-- info
							return { text = "I", highlight = "DiagnosticsInfo" }
						elseif diagnostics == "W" then
							-- warning
							return { text = "W", highlight = "DiagnosticsWarning" }
						elseif diagnostics == "E" then
							-- error
							return { text = "E", highlight = "DiagnosticsError" }
						else
							-- missing diagnostics symbol
							return { text = diagnostics, highlight = "DiagnosticsError" }
						end
					end
				},
				renderers = {
					directory = {
						{ "icon" },
						{ "git_status_or_default" },
						{ "diagnostics_or_default" },
						{ "name" },
						{ "modified" },
					},
					file = {
						{ "icon" },
						{ "git_status_or_default" },
						{ "diagnostics_or_default" },
						{ "name" },
						{ "modified" },
					},
				},
			},

			default_component_configs = {
				name = {
					use_git_status_colors = false,
				},
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
				modified = {
					symbol = "⭓",
					highlight = "NeoTreeModified",
				},
				diagnostics = {
					symbols = {
						hint = "H",
						info = "I",
						warn = "W",
						error = "E",
					},
				},
			},
		})
	end
}
