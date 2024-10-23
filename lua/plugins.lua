vim.cmd([[packadd packer.nvim]])

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	use("neovim/nvim-lspconfig")
	-- Mason plugin
	use({
		"williamboman/mason.nvim",
	})
	use({
		"williamboman/mason-lspconfig.nvim",
	})
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- Buffer completions
	use("hrsh7th/cmp-path") -- Path completions
	use("hrsh7th/cmp-cmdline") -- Cmdline completions
	use("hrsh7th/cmp-nvim-lsp") -- LSP source for nvim-cmp
	use({
		"ray-x/lsp_signature.nvim",
	})
	use("saadparwaiz1/cmp_luasnip") -- Snippet completions
	use("L3MON4D3/LuaSnip") -- Snippet engine
	use("windwp/windline.nvim") -- Status line with animation
	use("yamatsum/nvim-cursorline") -- Cursor line
	use("gennaro-tedesco/nvim-peekup") -- Better register peekup
	use("nvim-lua/plenary.nvim")
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		requires = { { "nvim-lua/plenary.nvim" } },
	})
	use({ "lervag/vimtex" })
	use({
		"nvim-telescope/telescope-file-browser.nvim",
		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	})
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				show_hidden = false,
			})
		end,
	})
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})
	use({ "mhartington/formatter.nvim" })
	-- change to dark mode once system color changes :)
	use({ "f-person/auto-dark-mode.nvim" })
	-- color scheme
	use({ "austinliuigi/smoke.nvim" })
end)
