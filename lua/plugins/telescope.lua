return {
	"nvim-telescope/telescope.nvim",
	config = function()
		require("telescope").setup({
			defaults = {
				preview = {
					-- deactivate treesitter highlighting because it crashed
					treesitter = false,
				},
			},
		})

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
}
