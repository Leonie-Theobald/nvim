
-- print("Setup code_completion.lua")
--
-- vim.opt.completeopt = {'menuone', 'preview', 'preinsert'}
-- vim.opt.shortmess = vim.opt.shortmess + { c = true}
-- vim.api.nvim_set_option('updatetime', 300) 
--
-- -- Completion Plugin Setup
-- local cmp = require'cmp'
-- cmp.setup({
-- 	mapping = {
-- 		['<C-p>'] = cmp.mapping.select_prev_item(),
-- 		['<C-n>'] = cmp.mapping.select_next_item(),
-- 		-- Add tab support
-- 		['<Tab>'] = cmp.mapping.select_next_item(),
-- 		['<C-T>'] = cmp.mapping.scroll_docs(-4),
-- 		['<C-F>'] = cmp.mapping.scroll_docs(4),
-- 		['<ESC>'] = cmp.mapping.close(),
-- 		['<CR>'] = cmp.mapping.confirm({
-- 			behavior = cmp.ConfirmBehavior.Insert,
-- 			select = true,
-- 		})
-- 	},
-- 	-- Installed sources:
-- 	sources = {
-- 		{ name = 'path' },                              -- file paths
-- 		{ name = 'nvim_lsp'},
-- 		{ name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
-- 		{ name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
-- 		{ name = 'buffer', keyword_length = 2 },        -- source current buffer
-- 		{ name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
-- 		{ name = 'calc'},                               -- source for math calculation
-- 	},
-- 	window = {
-- 		completion = cmp.config.window.bordered(),
-- 		documentation = cmp.config.window.bordered(),
-- 	},
-- 	formatting = {
-- 		fields = {'menu', 'abbr', 'kind'},
-- 		format = function(entry, item)
-- 			local menu_icon ={
-- 				nvim_lsp = 'λ',
-- 				vsnip = '⋗',
-- 				buffer = 'Ω',
-- 				path = '🖫',
-- 			}
-- 			item.menu = menu_icon[entry.source.name]
-- 			return item
-- 		end,
-- 	},
-- })



-- return {
-- 	"hrsh7th/nvim-cmp",
-- 	version = false, -- last release is way too old
-- 	event = "InsertEnter",
-- 	dependencies = {
-- 		"hrsh7th/cmp-nvim-lsp",
-- 		"hrsh7th/cmp-buffer",
-- 		"hrsh7th/cmp-path",
-- 	},
-- 	opts = function()
-- 		vim.opt.completeopt = {'menuone', 'preview', 'preinsert'}
-- 		vim.opt.shortmess = vim.opt.shortmess + { c = true}
-- 		vim.api.nvim_set_option('updatetime', 300)
--
-- 		-- Register nvim-cmp lsp capabilities
-- 		vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })
--
-- 		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
-- 		local cmp = require("cmp")
-- 		local defaults = require("cmp.config.default")()
-- 		local auto_select = true
-- 		return {
-- 			auto_brackets = {}, -- configure any filetype to auto add brackets
-- 			completion = {
-- 				completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
-- 			},
-- 			preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
-- 			mapping = cmp.mapping.preset.insert({
-- 				['<C-p>'] = cmp.mapping.select_prev_item(),
-- 				['<C-n>'] = cmp.mapping.select_next_item(),
-- 				-- Add tab support
-- 				['<Tab>'] = cmp.mapping.select_next_item(),
-- 				['<C-T>'] = cmp.mapping.scroll_docs(-4),
-- 				['<C-F>'] = cmp.mapping.scroll_docs(4),
-- 				['<ESC>'] = cmp.mapping.close(),
-- 				['<CR>'] = cmp.mapping.confirm({
-- 					behavior = cmp.ConfirmBehavior.Insert,
-- 					select = true,
-- 				})
--
-- 			}),
-- 			sources = cmp.config.sources({
-- 				{ name = "lazydev" },
-- 				{ name = "nvim_lsp" },
-- 				{ name = "path" },
-- 				{ name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
-- 				{ name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
-- 				{ name = 'buffer', keyword_length = 2 },        -- source current buffer
-- 				{ name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
-- 			}, {
-- 				{ name = "buffer" },
-- 			}),
-- 			formatting = {
-- 				fields = {'menu', 'abbr', 'kind'},
-- 				format = function(entry, item)
-- 					local menu_icon ={
-- 						nvim_lsp = 'λ',
-- 						vsnip = '⋗',
-- 						buffer = 'Ω',
-- 						path = '🖫',
-- 					}
-- 					item.menu = menu_icon[entry.source.name]
-- 					return item
-- 				end,
-- 			},
-- 			window = {
-- 				completion = cmp.config.window.bordered(),
-- 				documentation = cmp.config.window.bordered(),
-- 			},
-- 			sorting = defaults.sorting,
-- 		}
-- 	end,
-- 	main = "lazyvim.util.cmp",
-- }



return {
	"hrsh7th/nvim-cmp",
	version = false,
	event = "InsertEnter",

	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/vim-vsnip",
		"hrsh7th/cmp-vsnip",
		"hrsh7th/cmp-nvim-lsp",
	},

	opts = function(_, opts)
		local cmp = require("cmp")
		local defaults = require("cmp.config.default")()
		local auto_select = true

		-- options (safe)
		vim.opt.completeopt = { "menuone", "noselect" }
		vim.opt.shortmess:append("c")
		vim.o.updatetime = 300

		vim.api.nvim_set_hl(0, "CmpGhostText", {
			link = "Comment",
			default = true,
		})

		-- extend LazyVim sources (DON'T replace)
		opts.sources = vim.tbl_extend("force", opts.sources or {}, {
			{ name = "path" },
			{ name = "buffer", keyword_length = 2 },
			{ name = "lazydev" },
			{ name = "nvim_lsp" },
			{ name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
			{ name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
			{ name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
		})

		opts.preselect = auto_select
		and cmp.PreselectMode.Item
		or cmp.PreselectMode.None

		opts.mapping = cmp.mapping.preset.insert({
			["<C-p>"] = cmp.mapping.select_prev_item(),
			["<C-n>"] = cmp.mapping.select_next_item(),
			["<Tab>"] = cmp.mapping.select_next_item(),
			["<C-T>"] = cmp.mapping.scroll_docs(-4),
			["<C-F>"] = cmp.mapping.scroll_docs(4),
			["<Esc>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = true,
			}),
		})

		opts.formatting = {
			fields = { "menu", "abbr", "kind" },
			format = function(entry, item)
				local menu_icon = {
					nvim_lsp = "λ",
					vsnip = "⋗",
					buffer = "Ω",
					path = "🖫",
				}

				item.menu = menu_icon[entry.source.name]
				return item
			end,
		}

		opts.window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		}

		opts.sorting = defaults.sorting

		return opts
	end,
}
