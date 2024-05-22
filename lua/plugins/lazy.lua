local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

require("lazy").setup({
	{
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			require("nvim-tree").setup{}
		end
	},
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter").setup{}
		end
	},
	{
		"akinsho/bufferline.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons"
		},
		config = function()
			vim.opt.termguicolors = true -- Also declared in plugins.options cuz this technically is suppossed to go there.
			require("bufferline").setup{}
		end
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		version = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" }
    },
	{
		"terrortylor/nvim-comment",
		config = function()
			require("nvim_comment").setup{ create_mappings = false }
		end
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup{}
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup{
				ensure_installed = { "lua_ls", "tailwindcss", "tsserver", "gopls", "rust_analyzer", "pyright", "html" }
			}
		end
	},
	{
		"neovim/nvim-lspconfig"
	},
	{
    	"hrsh7th/nvim-cmp",
    	event = "InsertEnter",
    	dependencies = {
			{
        		"L3MON4D3/LuaSnip",
        		dependencies = "rafamadriz/friendly-snippets",
        		opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        		config = function(_, opts)
          			require("luasnip").config.set_config{opts}
          			-- require "configs.luasnip"
        		end,
			}
		}
    },
    {
		"windwp/nvim-autopairs",
		opts = {
			fast_wrap = {},
			disable_filetype = { "TelescopePrompt", "vim" },
		},
		config = function(_, opts)
			require("nvim-autopairs").setup{opts}
		end
    },
    {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
    },
	{
		"EdenEast/nightfox.nvim",
		name = "carbonfox"
	}
})
