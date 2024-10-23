local util = require("formatter.util")

require("formatter").setup({
	logging = true,
	log_level = vim.log.levels.WARN,
	filetype = {
		json = {
			function()
				return {
					exe = "prettier",
					args = {
						"--stdin-filepath",
						vim.api.nvim_buf_get_name(0),
						"--print-width",
						"79",
					},
					stdin = true,
				}
			end,
		},
		markdown = {
			function()
				return {
					exe = "prettier",
					args = {
						"--stdin-filepath",
						vim.api.nvim_buf_get_name(0),
						"--print-width",
						"79",
					},
					stdin = true,
				}
			end,
		},

		-- CMake with cmakelang's cmake-format and line width
		cmake = {
			function()
				return {
					exe = "cmake-format",
					args = {
						vim.api.nvim_buf_get_name(0),
						"--line-width",
						"79", -- Setting line width
					},
					stdin = false,
				}
			end,
		},

		-- Bazel files with buildifier and line length (if applicable)
		bzl = {
			function()
				return {
					exe = "buildifier",
					args = { "--type=bzl", vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end,
		},

		-- Clang-format for C/C++/Objective-C with fallback style and column limit
		cpp = {
			function()
				return {
					exe = "clang-format",
					args = {
						"--assume-filename",
						vim.api.nvim_buf_get_name(0),
						"--fallback-style=WebKit",
					},
					stdin = true,
					cwd = vim.fn.expand("%:p:h"), -- Run formatter in current file's directory
				}
			end,
		},

		-- GDScript with gdformat
		gd = {
			function()
				return {
					exe = "gdformat",
					args = { vim.api.nvim_buf_get_name(0) },
					stdin = false,
				}
			end,
		},

		-- Python with isort and line length
		python = {
			function()
				return {
					exe = "isort",
					args = { "--line-length", "79", "-" },
					stdin = true,
				}
			end,
		},

		-- Lua with stylua and column width
		lua = {
			function()
				return {
					exe = "stylua",
					args = {
						"--column-width",
						"79", -- Line width limit
						"--search-parent-directories",
						"--stdin-filepath",
						vim.api.nvim_buf_get_name(0),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},
	},

	["*"] = {
		-- "formatter.filetypes.any" defines default configurations for any
		-- filetype
		require("formatter.filetypes.any").remove_trailing_whitespace,
		-- Remove trailing whitespace without 'sed'
		-- require("formatter.filetypes.any").substitute_trailing_whitespace,
	},
})

-- Keybinding for formatting
vim.api.nvim_set_keymap(
	"n",
	"<leader>ft",
	"<cmd>Format<CR>",
	{ noremap = true, silent = true }
)

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})
