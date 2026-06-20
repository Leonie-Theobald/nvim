return {
	"nvim-telescope/telescope.nvim",
	init = function()
		local builtin = require('telescope.builtin')

		vim.keymap.set('n', '<leader>psf', builtin.find_files, { desc = 'Telescope find project files' })

		-- install ripgrep, e.g. sudo apt install ripgrep
		vim.keymap.set('n', '<leader>pss', function() 
			builtin.grep_string({ search = vim.fn.input("Grep > ") });
		end, { desc = 'Start search for files with string contained' })

		vim.keymap.set('n', '<leader>psl',
		builtin.live_grep, { desc = 'Start live search for files with string contained' })

		vim.keymap.set('n', '<leader>psto', function() 
			builtin.grep_string({ search = "- [ ]" });
		end, { desc = 'Find open TODOs' })
	end,
-- 	keys = {
-- 		{
-- 			"<leader>psf",
-- 			function()
-- 				require("telescope.builtin").find_files()
-- 			end,
-- 			desc = "Telescope find project files",
-- 		},
--
-- 		{
-- 			"<leader>pss",
-- 			function()
-- 				require("telescope.builtin").grep_string({
-- 					search = vim.fn.input("Grep > "),
-- 				})
-- 			end,
-- 			desc = "Search string in project",
-- 		},
--
-- 		{
-- 			"<leader>psl",
-- 			function()
-- 				require("telescope.builtin").live_grep()
-- 			end,
-- 			desc = "Live grep",
-- 		},
--
-- 		{
-- 			"<leader>psto",
-- 			function()
-- 				require("telescope.builtin").grep_string({
-- 					search = "- [ ]",
-- 				})
-- 			end,
-- 			desc = "Find open TODOs",
-- 		},
-- 	},
}
