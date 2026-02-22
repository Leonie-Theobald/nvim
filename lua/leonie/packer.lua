print("Setup packer.lua")

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use "nvim-lua/plenary.nvim" -- don't forget to add this one if you don't have it yet!
	use {
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		requires = { {"nvim-lua/plenary.nvim"} }
	}

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.8',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use {
		'nvim-treesitter/nvim-treesitter',
		{run = ':TSUpdate'}
	}

	use "mbbill/undotree"

	use "tpope/vim-fugitive"

	use "williamboman/mason.nvim"

	use "doums/rg.nvim"

	use {
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup {}
		end
	}

	use({
		"kylechui/nvim-surround",
		tag = "*", -- Use for stability; omit to use `main` branch for the latest features
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	})


	use "ThePrimeagen/vim-be-good"

	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = {
			"nvim-lua/plenary.nvim",
			-- "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		}
	})

	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function() 
			vim.g.mkdp_filetypes = { "markdown" }
		end, ft = { "markdown" }, 
	})

	use "lewis6991/gitsigns.nvim"

	use "neovim/nvim-lspconfig"

	use "slint-ui/vim-slint"

	 -- Completion framework:
	 use 'hrsh7th/nvim-cmp' 

	 -- Useful completion sources:
	 use 'hrsh7th/cmp-nvim-lua'
	 use 'hrsh7th/cmp-nvim-lsp'
	 use 'hrsh7th/cmp-nvim-lsp-signature-help'
	 use 'hrsh7th/cmp-vsnip'                             
	 use 'hrsh7th/cmp-path'                              
	 use 'hrsh7th/cmp-buffer'                            
	 use 'hrsh7th/vim-vsnip'

	 use {
		 'nvim-lualine/lualine.nvim',
		 requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	 }

	 use {
		 'chomosuke/typst-preview.nvim',
		 tag = 'v1.*',
		 config = function()
			 require 'typst-preview'.setup {
				 follow_cursor = true,
			 } end,
	 }

	 use {
		 "leonie-theobald/regput",
		 config = function()
			 require("regput").setup({
				 left_sidebar = "neo-tree",
			 })
		 end,
	 }
end)
