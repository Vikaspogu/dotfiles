local M = {}

function M.setup()
	-- Indicate first time installation
	local packer_bootstrap = false

	-- packer.nvim configuration
	local conf = {
		profile = {
			enable = true,
			threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
		},

		display = {
			open_fn = function()
				return require("packer.util").float { border = "rounded" }
			end,
		},
	}

	-- Check if packer.nvim is installed
	-- Run PackerCompile if there are changes in this file
	local function packer_init()
		local fn = vim.fn
		local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
		if fn.empty(fn.glob(install_path)) > 0 then
			packer_bootstrap = fn.system {
				"git",
				"clone",
				"--depth",
				"1",
				"https://github.com/wbthomason/packer.nvim",
				install_path,
			}
			vim.cmd [[packadd packer.nvim]]
		end

		vim.api.nvim_exec(
		[[
		augroup Packer
		autocmd!
		autocmd BufWritePost init.lua PackerCompile
		augroup end
		]],
		false
		)
	end

	-- Plugins
	local function plugins(use)
		use 'wbthomason/packer.nvim' -- Package manager

		-- Performance
		use { "lewis6991/impatient.nvim" }

		use 'tpope/vim-fugitive' -- Git commands in nvim

		use { "tpope/vim-commentary", keys = { "gc", "gcc", "gbc" }, disable = true }
		use { "tpope/vim-surround", event = "BufReadPre" }

		-- UI to select things (files, grep results, open buffers...)
		use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
		use { 'romgrk/barbar.nvim', requires = {'kyazdani42/nvim-web-devicons'} }

		-- Colorscheme
		use {
			"catppuccin/nvim",
			as = "catppuccin",
			config = function()
				vim.g.catppuccin_flavour = "macchiato" -- latte, frappe, macchiato, mocha
				require("catppuccin").setup()
				vim.cmd [[colorscheme catppuccin]]
			end,
			disable = true,
		}

		use {
			"folke/tokyonight.nvim",
			config = function()
				vim.cmd.colorscheme [[tokyonight]]
			end,
			disable = true,
		}
		use {
			"sainnhe/everforest",
			config = function()
				vim.g.everforest_better_performance = 1
				vim.cmd.colorscheme [[everforest]]
			end,
			disable = false,
		}
		use {
			"projekt0n/github-nvim-theme",
			disable = true,
		}
		use {
			"sainnhe/gruvbox-material",
			config = function()
				vim.cmd "colorscheme gruvbox-material"
			end,
			disable = true,
		}
		use {
			"arcticicestudio/nord-vim",
			config = function()
				vim.cmd "colorscheme nord"
			end,
			disable = true,
		}
		use 'joshdick/onedark.vim' -- Theme inspired by Atom

		use 'bluz71/vim-moonfly-colors'
		use 'tanvirtin/monokai.nvim'
		use 'itchyny/lightline.vim' -- Fancier statusline
		-- Add git related info in the signs columns and popups
		use {
			"lewis6991/gitsigns.nvim",
			event = "BufReadPre",
			wants = "plenary.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = function()
				require("config.gitsigns").setup()
			end,
		}

		use {
			"m-demare/attempt.nvim",
			opt = true,
			requires = "nvim-lua/plenary.nvim",
			module = { "attempt" },
			config = function()
				require("config.attempt").setup()
			end,
			disable = false,
		}

		-- Jumps
		use {
			"phaazon/hop.nvim",
			cmd = "HopWord",
			module = "hop",
			keys = { "f", "F", "t", "T" },
			config = function()
				require("config.hop").setup()
			end,
			disable = true,
		}

		-- Refactoring
		use {
			"ThePrimeagen/refactoring.nvim",
			module = { "refactoring", "telescope" },
			keys = { [[<leader>r]] },
			wants = { "telescope.nvim" },
			config = function()
				require("config.refactoring").setup()
			end,
		}

		-- Harpoon
		use {
		  "ThePrimeagen/harpoon",
		  keys = { [[<leader>j]] },
		  module = { "harpoon", "harpoon.cmd-ui", "harpoon.mark", "harpoon.ui", "harpoon.term" },
		  wants = { "telescope.nvim" },
		  config = function()
			require("config.harpoon").setup()
		  end,
		}

		use 'vim-autoformat/vim-autoformat'

		-- semantic Highlight
		use {
			"m-demare/hlargs.nvim",
			config = function()
				require("config.hlargs").setup()
			end,
		}


		-- Highlight, edit, and navigate code using a fast incremental parsing library
		use 'nvim-treesitter/nvim-treesitter'
		-- Additional textobjects for treesitter
		use 'nvim-treesitter/nvim-treesitter-textobjects'
		use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
		use {
			"hrsh7th/nvim-cmp",
			requires = {
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-nvim-lsp",
				"quangnguyen30192/cmp-nvim-ultisnips",
				"hrsh7th/cmp-nvim-lua",
				"octaltree/cmp-look",
				"hrsh7th/cmp-path",
				"hrsh7th/cmp-calc",
				"f3fora/cmp-spell",
				"hrsh7th/cmp-emoji",
				"ray-x/cmp-treesitter",
				"hrsh7th/cmp-cmdline",
				"hrsh7th/cmp-nvim-lsp-document-symbol",
				"onsails/lspkind-nvim",
			},
			config = function()
				require("config.cmp").setup()
			end,
			wants = { "LuaSnip", "lspkind-nvim" },
		}

		-- Code documentation
		use {
			"danymat/neogen",
			config = function()
				require("config.neogen").setup()
			end,
			cmd = { "Neogen" },
			module = "neogen",
			disable = false,
		}

		-- Auto pairs
		use {
			"windwp/nvim-autopairs",
			opt = true,
			event = "InsertEnter",
			wants = "nvim-treesitter",
			module = { "nvim-autopairs.completion.cmp", "nvim-autopairs" },
			config = function()
				require("config.autopairs").setup()
			end,
		}

		-- WhichKey
		use {
			"folke/which-key.nvim",
			event = "VimEnter",
			-- keys = { [[<leader>]] },
			config = function()
				require("config.whichkey").setup()
			end,
			disable = false,
		}

		-- Legendary
		use {
			"mrjones2014/legendary.nvim",
			opt = true,
			keys = { [[<C-p>]] },
			wants = { "dressing.nvim" },
			module = { "legendary" },
			cmd = { "Legendary" },
			config = function()
				require("config.legendary").setup()
			end,
			requires = { "stevearc/dressing.nvim" },
		}

		use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons', config = function() require'nvim-tree'.setup {} end }
		use 'hrsh7th/cmp-nvim-lsp'
		use 'saadparwaiz1/cmp_luasnip'
		use 'L3MON4D3/LuaSnip' -- Snippets plugin
		use 'scrooloose/nerdcommenter' -- commenting shortcuts
		use { "williamboman/mason.nvim" }
		use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
		-- IndentLine
		use {
			"lukas-reineke/indent-blankline.nvim",
			event = "BufReadPre",
			config = function()
				require("config.indentblankline").setup()
			end,
		}
		use 'voldikss/vim-floaterm'
		use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
		use 'kdheepak/lazygit.nvim'

		-- Startup screen
		use {
			"goolord/alpha-nvim",
			config = function()
				require("config.alpha").setup()
			end,
		}
		use { 'mhartington/formatter.nvim' }
		use { "nvim-telescope/telescope-file-browser.nvim" }
		use { "nvim-telescope/telescope-project.nvim" }
		use { 'cljoly/telescope-repo.nvim' }
		use {
			"ldelossa/gh.nvim",
			opt = true,
			wants = { "litee.nvim" },
			requires = { { "ldelossa/litee.nvim" } },
			event = "BufReadPre",
			cmd = { "GHOpenPR" },
			config = function()
				require("litee.lib").setup()
				require("litee.gh").setup()
			end,
			disable = true,
		}

		-- Bootstrap Neovim
		if packer_bootstrap then
			print "Neovim restart is required after installation!"
			require("packer").sync()
		end
	end

	-- Init and start packer
	packer_init()
	local packer = require "packer"

	-- Performance
	pcall(require, "impatient")
	-- pcall(require, "packer_compiled")

	packer.init(conf)
	packer.startup(plugins)
end

return M
