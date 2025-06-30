print("Setup neotree.lua")
vim.keymap.set("n", "<leader>att", "<Cmd>Neotree toggle<CR>") -- toggles visibility of neotree
vim.keymap.set("n", "<leader>atf", "<Cmd>Neotree focus<CR>") -- jumps to neotree from current file 

vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { ctermfg=218 }) -- changes file name and letter for unstaged
vim.api.nvim_set_hl(0, "NeoTreeGitIgnored", { ctermfg=243 }) -- grey line for files in .gitignore
vim.api.nvim_set_hl(0, "NeoTreeGitUnstaged", { ctermfg=204 }) -- pink letter for Unstaged
vim.api.nvim_set_hl(0, "NeoTreeGitStaged", { ctermfg=46 }) -- green letter for Staged
vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { ctermfg=1 }) -- mark conflict files red

vim.api.nvim_set_hl(0, "NeoTreeDirectoryName", { }) -- make directory font default 
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

local function git_status_copy(config, node, state)
	local git_status_lookup = state.git_status_lookup
	if config.hide_when_expanded and node.type == "directory" and node:is_expanded() then
		return {}
	end
	if not git_status_lookup then
		return {}
	end
	local git_status = git_status_lookup[node.path]
	if not git_status then
		if node.filtered_by and node.filtered_by.gitignored then
			git_status = "!!"
		else
			return {}
		end
	end

	local symbols = config.symbols or {}
	local change_symbol
	local change_highlt = highlights.FILE_NAME
	---@type string?
	local status_symbol = symbols.staged
	local status_highlt = highlights.GIT_STAGED
	if node.type == "directory" and git_status:len() == 1 then
		status_symbol = nil
	end

	if git_status:sub(1, 1) == " " then
		status_symbol = symbols.unstaged
		status_highlt = highlights.GIT_UNSTAGED
	end

	if git_status:match("?$") then
		status_symbol = nil
		status_highlt = highlights.GIT_UNTRACKED
		change_symbol = symbols.untracked
		change_highlt = highlights.GIT_UNTRACKED
		-- all variations of merge conflicts
	elseif git_status == "DD" then
		status_symbol = symbols.conflict
		status_highlt = highlights.GIT_CONFLICT
		change_symbol = symbols.deleted
		change_highlt = highlights.GIT_CONFLICT
	elseif git_status == "UU" then
		status_symbol = symbols.conflict
		status_highlt = highlights.GIT_CONFLICT
		change_symbol = symbols.modified
		change_highlt = highlights.GIT_CONFLICT
	elseif git_status == "AA" then
		status_symbol = symbols.conflict
		status_highlt = highlights.GIT_CONFLICT
		change_symbol = symbols.added
		change_highlt = highlights.GIT_CONFLICT
	elseif git_status:match("U") then
		status_symbol = symbols.conflict
		status_highlt = highlights.GIT_CONFLICT
		if git_status:match("A") then
			change_symbol = symbols.added
		elseif git_status:match("D") then
			change_symbol = symbols.deleted
		end
		change_highlt = highlights.GIT_CONFLICT
		-- end merge conflict section
	elseif git_status:match("M") then
		change_symbol = symbols.modified
		change_highlt = highlights.GIT_MODIFIED
	elseif git_status:match("R") then
		change_symbol = symbols.renamed
		change_highlt = highlights.GIT_RENAMED
	elseif git_status:match("[ACT]") then
		change_symbol = symbols.added
		change_highlt = highlights.GIT_ADDED
	elseif git_status:match("!") then
		status_symbol = nil
		change_symbol = symbols.ignored
		change_highlt = highlights.GIT_IGNORED
	elseif git_status:match("D") then
		change_symbol = symbols.deleted
		change_highlt = highlights.GIT_DELETED
	end

	if change_symbol or status_symbol then
		local components = {}
		if type(change_symbol) == "string" and #change_symbol > 0 then
			table.insert(components, {
				text = make_two_char(change_symbol),
				highlight = change_highlt,
			})
		end
		if type(status_symbol) == "string" and #status_symbol > 0 then
			table.insert(components, {
				text = make_two_char(status_symbol),
				highlight = status_highlt,
			})
		end
		return components
	else
		return {
			text = "[" .. git_status .. "]",
			highlight = config.highlight or change_highlt,
		}
	end
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
	-- 	container = {
	-- 		enable_character_fade = true,
	-- 	},
		indent = {
			indent_size = 2,
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
			default = " ",
			hightlight = "",
		},
	-- 	name = {
	-- 		hightlight = "",
	-- 		use_git_status_colors = false,
	-- 	},
	-- 	modified = {
	-- 		symbol = "~",
	-- 		highlight = "",
	-- 	},
		popup_border_style = "",
		enable_git_status = true,
		enable_diagnostics = false,

		git_status = {
			symbols = {
				-- Change type
				added = "",
				modified = "",
				deleted = "",
				renamed = "",
				-- Status type
				untracked = " U",
				ignored = " I",
				unstaged = "US",
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
			abc_text = function(config, node, _)
				return {
					text = " abc ",
					highlight = "Comment",
				}
			end,
			harpoon_index = function(config, node, _)
				local harpoon_list = require("harpoon"):list()
				local path = node:get_id()
				local harpoon_key = vim.uv.cwd()

				for i, item in ipairs(harpoon_list.items) do
					local value = item.value
					if string.sub(item.value, 1, 1) ~= "/" then
						value = harpoon_key .. "/" .. item.value
					end

					if value == path then
						vim.print(path)
						return {
							text = string.format(" ⥤ %d", i), -- <-- Add your favorite harpoon like arrow here
							highlight = config.highlight or "NeoTreeDirectoryIcon",
						}
					else
						return {
							text = "   ",
							highlight = config.hightlight
						}
					end
				end
				return {}
			end,
			git_status_or_whitespace = function(config, node, state)
				local git_status_lookup = state.git_status_lookup
				local symbol = git_status_lookup[node.path]
				-- print("Curent path: " .. node.path)
				-- print(vim.inspect(git_status_lookup["/root/.config/nvim/lua/leonie/init.lua"]))
				-- print(vim.inspect(git_status_lookup))
				--  print(vim.inspect(state.git_status_lookup))
				if symbol == nil then 
					return {
						text = " ni ",
						highlight = "NeoTreeGitStatus"
					}
				else
					-- local config
					local my_config = vim.tbl_deep_extend("force", config or {}, {
						symbols = {
							added     = "🞧",
							modified  = "~",
							deleted   = "✘",
							renamed   = "➡",
							untracked = "?",
							ignored   = "◌",
							staged    = "+",
							unstaged  = "!",
							conflict  = "⚠",
						},
						highlight = "NeoTreeGitStatus",
					})

					return {
						-- git_status_copy(config, node, state)
						require("neo-tree.sources.common.components").git_status(my_config, node, state)
						-- text = "+" .. git_status .. "+",
					}
				end
			end,
		},
		renderers = {
			file = {
				{ "icon" },
				-- { "harpoon_index" }, --> This is what actually adds the component in where you want it
				-- { "git_status_or_whitespace", hightlight = "NeoTreeGitStatus" },
				{ "name", use_git_status_colors = true },
				{ "git_status" },
			},
		},
	},
	-- default_component_configs = {
	-- 	container = {
	-- 		enable_character_fade = true,
	-- 	},
	-- 	indent = {
	-- 		indent_size = 2,
	-- 		padding = 1, -- extra padding on left hand side
	-- 		-- indent guides
	-- 		with_markers = true,
	-- 		indent_marker = "│",
	-- 		last_indent_marker = "│",
	-- 		highlight = "NeoTreeIndentMarker",
	-- 		-- expander config, needed for nesting files
	-- 		with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
	-- 		expander_collapsed = "■",
	-- 		expander_expanded = "□",
	-- 		expander_highlight = "NeoTreeExpander",
	-- 	},
	-- 	icon = {
	-- 		folder_closed = "■",
	-- 		folder_open = "□",
	-- 		folder_empty = "⛶",
	-- 		default = " ",
	-- 		hightlight = "",
	-- 	},
	-- 	name = {
	-- 		hightlight = "",
	-- 		use_git_status_colors = false,
	-- 	},
	-- 	modified = {
	-- 		symbol = "~",
	-- 		highlight = "",
	-- 	},
	-- 	popup_border_style = "",
	-- 	enable_git_status = true,
	-- 	enable_diagnostics = false,

	-- 	git_status = {
	-- 		symbols = {
	-- 			-- Change type
	-- 			added = "",
	-- 			modified = "",
	-- 			deleted = "",
	-- 			renamed = "",
	-- 			-- Status type
	-- 			untracked = " U",
	-- 			ignored = " I",
	-- 			unstaged = "US",
	-- 			staged = " S",
	-- 			conflict = " C",
	-- 		},
	-- 		highlight = true,
	-- 	},
	-- },

	-- filesystem = {
	-- 	filtered_items = {
	-- 		visible = true,
	-- 		hide_dotfiles = false,
	-- 	},
	-- 	follow_current_file = {
	-- 		enabled = true,
	-- 		leave_dirs_open = false,
	-- 	},
	-- 	group_empty_dirs = true,
	-- 	components = {
	-- 		abc_text = function()
	-- 			return {
	-- 				text = " abc ",
	-- 				highlight = "Comment",
	-- 			}
	-- 		end,
	-- 		harpoon_index = function(config, node)
	-- 			return {
	-- 				text = " abc ",
	-- 			}
	-- 		end,
	-- 	},
	-- },
	-- renderers = {
	-- 	directory = {
	-- 		{ "icon" },
	-- 		-- { "git_status", hightlight = "NeoTreeGitStatus" },
	-- 		{ "name", hightligh = "Normal" },
	-- 	},
	-- 	file = {
	-- 		{ "icon" },
	-- 		{ "abc_text" },
	-- 		{ "git_status", hightlight = "NeoTreeGitStatus" },
	-- 		{ "name" },
	-- 	}
	-- }
})



-- require("nvim-web-devicons").set_icon {
	--   lua = {
		--     icon = "G",  -- Custom icon
		--     color = "#519aba",
		--     cterm_color = "74",
		--     name = "Lua"
		--   },
		--   md = {
			--     icon = "G",  -- Custom icon
			--     color = "#519aba",
			--     cterm_color = "74",
			--     name = "Md"
			--   },
			-- }
