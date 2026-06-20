return {
	"doums/rg.nvim",
	config = function()
		require("rg").setup({
			vim.keymap.set('n', '<leader>rg', function()
				vim.cmd.Rg(vim.fn.input("Grep Regex > "));
			end, { desc = 'Search for Regex' }),

			qf_format = nil,
			excluded = {
				'.idea',
				'node_modules',
				'.git',
				'target',
				'package-lock.json',
				'Cargo.lock',
			},
		})
	end,
}
