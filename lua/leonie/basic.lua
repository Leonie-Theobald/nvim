print("Setup basic.lua")

-- suppress start screen
vim.opt.shortmess:append("sI")

vim.g.mapleader = " "

-- set options for line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

-- mark the 80 and 100 column
vim.cmd("set colorcolumn=81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100")
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg=235 })

-- wrap text at 100
vim.opt.textwidth = 100
vim.opt.formatoptions:append("t")

-- set language options
vim.opt.spelllang="en"
vim.opt.spell = true
