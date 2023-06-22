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

local opts = {}

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
  {
    "windwp/nvim-autopairs",
    config = function()
      require("configs.autopairs")
    end,
  },
  {
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  },
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
    config = function()
      require("configs.bufferline")
    end,
  },
  { "moll/vim-bbye" },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("configs.lualine")
    end,
  },
  {
    "akinsho/toggleterm.nvim",
    tag = "*",
    config = function()
      require("configs.toggleterm")
    end,
  },
  {
    "ahmedkhalf/project.nvim",
    config = function()
      require("configs.project")
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup({
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
      })
    end,
  },
  {
    "goolord/alpha-nvim",
    config = function()
      require("configs.alpha")
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    config = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "kkoomen/vim-doge",
    build = ":call doge#install()",
    config = function()
      vim.g.doge_mapping = "<leader>D"
    end,
  },
  -- Colorschemes
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "loctvl842/monokai-pro.nvim",
    lazy = false,
    priority = 1000,
    keys = { { "<leader>c", "<cmd>MonokaiProSelect<cr>", desc = "Select Moonokai pro filter" } },
    config = function()
      require("configs.monokai")
    end,
  },

  -- cmp plugins
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-buffer" },    -- buffer completions
      { "hrsh7th/cmp-path" },      -- path completions
      { "saadparwaiz1/cmp_luasnip" }, -- snippet completions
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-nvim-lua" },
    },
    config = function()
      require("configs.cmp")
    end,
  }, -- The completion plugin

  -- snippets
  { "L3MON4D3/LuaSnip" },            --snippet engine
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
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end,
  },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    config = function()
      require("fidget").setup()
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    config = function()
      require("configs.telescope")
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
      "nvim-treesitter/nvim-treesitter-context",
    },
    config = function()
      require("configs.treesitter")
    end,
  },

  -- Git
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("configs.gitsigns")
    end,
  },

  -- DAP
  {
    "mfussenegger/nvim-dap",
    event = "BufRead",
    dependencies = {
      { "rcarriga/nvim-dap-ui" },
      { "theHamsta/nvim-dap-virtual-text" },
      { "mxsdev/nvim-dap-vscode-js" },
      {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      },
    },
    config = function()
      require("configs.dap")
    end,
  },

  {
    "Shatur/neovim-session-manager",
    config = function()
      require("configs.session-manager")
    end,
  },
  {
    "christoomey/vim-tmux-navigator",
  },
  {
    "sindrets/diffview.nvim",
  },
  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("configs.rest")
    end,
  },
}

lazy.setup(plugins, opts)
