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
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	},	
	-- {
		--     'nvim-treesitter/nvim-treesitter',
		--     run = ':TSUpdate'
		--    	},	
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
		-- {
			--     "nvim-neo-tree/neo-tree.nvim",
			--     branch = "v3.x",
			--     requires = {
				--     	"nvim-lua/plenary.nvim",
				--     	"MunifTanjim/nui.nvim",
				--     },
				--     config = function()
					-- 	require("neo-tree").setup({})
					--     end,
					-- },	
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
					-- {
						--     'chomosuke/typst-preview.nvim',
						--     version = 'v1.*',
						--     config = function()
							--    	 require 'typst-preview'.setup {
								--    		 follow_cursor = true,
								--    	 } end,
								-- },
								-- {
									--         "leonie-theobald/regput",
									--         config = function()
										--        	 require("regput").setup({
											--        		 left_sidebar = "neo-tree",
											--        	 })
											--         end,
											-- }
										}
