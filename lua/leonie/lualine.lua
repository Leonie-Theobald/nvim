print("Setup lualine.lua")

-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
	transparent_bg = "",
	bg       = 15,
	fg       = 0,
	diff_added = 28,
	diff_deleted = 1,
	diff_changed = 27,
	diag_error = 9,
	diag_warn = 202,
	diag_hint = 6,
	diag_info = 6,
}

local conditions = {
	buffer_not_empty = function()
		return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
	end,
	hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end,
	-- check_git_workspace = function()
	-- 	local filepath = vim.fn.expand('%:p:h')
	-- 	local gitdir = vim.fn.finddir('.git', filepath .. ';')
	-- 	return gitdir and #gitdir > 0 and #gitdir < #filepath
	-- end,
}

-- Config
local config = {
	options = {
		-- Disable sections and component separators
		component_separators = '',
		section_separators = '',
		theme = {
			-- We are going to use lualine_c an lualine_x as left and
			-- right section. Both are highlighted by c theme .  So we
			-- are just setting default looks o statusline
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
	},
	sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		-- These will be filled later
		lualine_c = {},
		lualine_x = {},
	},
	inactive_sections = {
		-- these are to remove the defaults
		lualine_a = {},
		lualine_b = {},
		lualine_y = {},
		lualine_z = {},
		lualine_c = {},
		lualine_x = {},
	},
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
	table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
	table.insert(config.sections.lualine_x, component)
end

ins_left {
	-- mode component
	function()
		return vim.fn.mode()
	end,
	color = { colors.fg, gui = "underline" },
	padding = { right = 0 },
}

ins_left {
	'filename',
	path = 3,
	cond = conditions.buffer_not_empty,
	color = { gui = 'underline' } 
}

ins_left { 'location', color = { gui = "underline" } }

ins_left { 'progress', color = { gui = "underline" } }


ins_right {
	'branch',
	icon = '',
	color = { gui = "underline" }
}

ins_right {
	'diagnostics',
	sources = { 'nvim_diagnostic' },
	symbols = { error = 'E', warn = 'W', info = 'I', hint = "H" },
	diagnostics_color = {
		error = {fg = colors.diag_error, bg = colors.transparent_bg },
		warn = { fg = colors.diag_warn, bg = colors.transparent_bg },
		info = { fg = colors.diag_info, bg = colors.transparent_bg },
		hint = { fg = colors.diag_hint, bg = colors.transparent_bg },
	},
}

-- Add components to right sections
ins_right {
	'diff',
	-- Is it me or the symbol for modified us really weird
	symbols = { added = '+', modified = '~', removed = '-' },
	diff_color = {
		added = { fg = colors.diff_added, bg = colors.transparent_bg },
		modified = { fg = colors.diff_changed, bg = colors.transparent_bg },
		removed = { fg = colors.diff_deleted, bg = colors.transparent_bg },
	},
	-- cond = conditions.hide_in_width,
}

-- Now don't forget to initialize lualine
lualine.setup(config)
