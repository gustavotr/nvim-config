local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local lazy = require("lazy")

local plugins = {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {},
		config = function()
			require("configs.whichkey")
		end,
	},
	{ "nvim-lua/plenary.nvim" },
	{ "windwp/nvim-autopairs" },
	{ "numToStr/Comment.nvim" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("configs.nvim-tree")
		end,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"akinsho/bufferline.nvim",
	},
	{ "moll/vim-bbye" },
	{ "nvim-lualine/lualine.nvim" },
	{
		"akinsho/toggleterm.nvim",
		config = function()
			require("configs.toggleterm")
		end,
	},
	{ "ahmedkhalf/project.nvim" },
	{ "lewis6991/impatient.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },
	{
		"goolord/alpha-nvim",
		config = function()
			require("configs.alpha")
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		setup = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"kkoomen/vim-doge",
		run = ":call doge#install()",
	},
	-- Colorschemes
	--{ "folke/tokyonight.nvim" },
	{
		"tanvirtin/monokai.nvim",
		config = function()
			require("monokai").setup({ palette = require("monokai").pro })
		end,
	},

	-- cmp plugins
	-- { "hrsh7th/nvim-cmp" },         -- The completion plugin
	-- { "hrsh7th/cmp-buffer" },       -- buffer completions
	-- { "hrsh7th/cmp-path" },         -- path completions
	-- { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
	-- { "hrsh7th/cmp-nvim-lsp" },
	-- { "hrsh7th/cmp-nvim-lua" },

	-- snippets
	{ "L3MON4D3/LuaSnip" }, --snippet engine
	{ "rafamadriz/friendly-snippets" }, -- a bunch of snippets to use

	-- LSP
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			{ "williamboman/mason.nvim" }, -- simple to use language server installer
			{ "neovim/nvim-lspconfig" }, -- enable LSP
		},
		config = function()
			require("configs.lsp")
		end,
	}, -- simple to use language server installer
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("configs.null-ls")
		end,
	}, -- for formatters and linters
	{
		"RRethy/vim-illuminate",
		config = function()
			require("configs.illuminate")
		end,
	},
	-- { "folke/trouble.nvim" },
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = function()
			require("fidget").setup()
		end,
	},

	-- Telescope
	{ "nvim-telescope/telescope.nvim" },

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
	},
	{ "nvim-treesitter/nvim-treesitter-context" },

	-- Git
	{ "lewis6991/gitsigns.nvim" },

	-- DAP
	{ "mfussenegger/nvim-dap" },
	{ "rcarriga/nvim-dap-ui" },
	{ "theHamsta/nvim-dap-virtual-text" },
	{ "mxsdev/nvim-dap-vscode-js" },
	{
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npm run compile",
	},
}

lazy.setup(plugins, opts)
