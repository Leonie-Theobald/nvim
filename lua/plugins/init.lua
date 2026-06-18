print("Init plugins")

return {
	"nvim-lua/plenary.nvim",
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { {"nvim-lua/plenary.nvim"} }
	},
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		requires = { {'nvim-lua/plenary.nvim'} }
	},	
	"mbbill/undotree",
	"tpope/vim-fugitive",
	"williamboman/mason.nvim",
	"doums/rg.nvim",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup {}
		end
	},	
	"kylechui/nvim-surround",
	"ThePrimeagen/vim-be-good",
	{
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function() 
			vim.g.mkdp_filetypes = { "markdown" }
		end, ft = { "markdown" }, 
	},	
	"neovim/nvim-lspconfig",
	"slint-ui/vim-slint",
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lua',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-nvim-lsp-signature-help',
	'hrsh7th/cmp-vsnip',          
	'hrsh7th/cmp-path',                            
	'hrsh7th/cmp-buffer',                           
	'hrsh7th/vim-vsnip',
	{
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	},	
}
