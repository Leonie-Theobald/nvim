return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate'
}
-- return {
-- 	"nvim-treesitter/nvim-treesitter",
-- 	build = ":TSUpdate",
-- 	config = function()
-- 		print("Perform after/plugin/treesitter.lua")
-- 		require'nvim-treesitter.configs'.setup {
-- 			build = ":TSUpdate",
-- 			-- A list of parser names, or "all" (the listed parsers MUST always be installed)
-- 				ensure_installed = { "go", "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "rust", "toml", "typst", "slint", "java" },
--
-- 			-- Install parsers synchronously (only applied to `ensure_installed`)
-- 				sync_install = false,
--
-- 			-- Automatically install missing parsers when entering buffer
-- 				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
-- 				auto_install = true,
--
-- 			ident = { enable = true },
-- 			highlight = {
-- 				enable = true,
--
-- 				-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
-- 					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
-- 					-- Using this option may slow down your editor, and you may see some duplicate highlights.
-- 					-- Instead of true it can also be a list of languages
-- 					additional_vim_regex_highlighting = false,
-- 			},
-- 		},
--
-- 		-- Treesitter folding
-- 			vim.wo.foldmethod = 'expr'
-- 			vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
-- 			vim.o.foldlevel = 99
-- 			vim.o.foldlevelstart = 99
-- 			vim.g.rustaceanvim = {
-- 				tools = {
-- 					autoSetHints = true,
-- 				}
-- 			}
-- 	end,
-- }
--
