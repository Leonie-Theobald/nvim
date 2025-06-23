print("Perform after/plugin/ripgrep.lua")

-- vim.keymap.set("n", "<leader>rg", vim.cmd.Rg);
vim.keymap.set('n', '<leader>rg', function() 
	vim.cmd.Rg(vim.fn.input("Grep Regex > "));
end, { desc = 'Search for Regex' })

require('rg').setup({
	-- Optional function to be used to format the items in the
	-- quickfix window (:h 'quickfixtextfunc')
	qf_format = nil,
	-- Glob list of excluded files and directories when the special
	-- `e` flag is set (it uses the `--glob !*` flag of rg)
	excluded = {
		'.idea',
		'node_modules',
		'.git',
		'target',
		'package-lock.json',
		'Cargo.lock',
	},
})
