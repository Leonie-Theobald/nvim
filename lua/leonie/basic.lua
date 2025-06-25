print("Setup basic.lua")

vim.opt.shortmess:append("sI")

vim.g.mapleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"

vim.cmd("set colorcolumn=81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,96,97,98,99,100")
vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg=235 })


vim.opt.spelllang="en"
vim.opt.spell = true
