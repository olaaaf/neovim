return {
	{ "nvim-lua/plenary.nvim" },
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	{ "ray-x/lsp_signature.nvim" },
	{
		"ms-jpq/coq_nvim",
		dependencies = {
			{ "ms-jpq/coq.artifacts", branch = "artifacts" },
			{ "ms-jpq/coq.thirdparty", branch = "3p" },
		},
	},
	{ "L3MON4D3/LuaSnip" }, -- Snippet engine
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"Snikimonkd/telescope-git-conflicts.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
	},
	-- file browser for telescope
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},
	},
	{ "Snikimonkd/telescope-git-conflicts.nvim" },
	{ "stevearc/conform.nvim" },
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{ "numToStr/Comment.nvim" },
	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				show_hidden = false,
				patterns = {
					".git",
					".nvim",
					"_darcs",
					".hg",
					".bzr",
					".svn",
					"Makefile",
					"package.json",
				},
				detection_methods = { "patterns" },
				manual_mode = true, -- Prevents automatic root directory changes
			})
		end,
	},
	{ "lervag/vimtex" },
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{ "windwp/windline.nvim" }, -- Status line with animation
	{ "yamatsum/nvim-cursorline" }, -- Cursor line
	{ "gennaro-tedesco/nvim-peekup" }, -- Better register peekup
	-- change to dark mode once system color changes :)
	{ "f-person/auto-dark-mode.nvim" },
	{ "mfussenegger/nvim-lint" },
	{ "akinsho/git-conflict.nvim", version = "*", config = true },
	-- colorscheme
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},
	{
		"RRethy/vim-illuminate",
	},
}
