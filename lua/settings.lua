-- show relative and absolute line number
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4 -- Set the width of a tab character
vim.opt.shiftwidth = 4
vim.opt.expandtab = true -- Convert tabs to spaces

vim.g.python3_host_prog = "/Library/Frameworks/Python.framework/Versions/3.12/bin/python3.12"

vim.wo.fillchars = "eob: "

local windline = require("wlsample.wind")

require("nvim-cursorline").setup({
	cursorline = {
		enable = false,
		timeout = 500,
		number = false,
	},
	cursorword = {
		enable = true,
		min_length = 3,
		hl = { underline = true },
	},
})

require("telescope").setup()

require("nvim-tree").setup()

-- set vim to use system clipboard
if vim.fn.has("unnamedplus") == 1 then
	vim.o.clipboard = "unnamedplus"
else
	vim.o.clipboard = "unnamed"
end

-- ignore DS_Store files
vim.opt.wildignore:append("*/.DS_Store")

-- formatter
require("formatter").setup({
	filetype = {
		rust = {
			function()
				return {
					exe = "rustfmt",
					args = { "--emit=stdout" },
					stdin = true,
				}
			end,
		},
		cpp = {
			function()
				return {
					exe = "clang-format",
					args = { "--assume-filename", vim.api.nvim_buf_get_name(0) },
					stdin = true,
					cwd = vim.fn.expand("%:p:h"), -- Run formatter in current file's directory
				}
			end,
		},
		python = {
			function()
				return {
					exe = "black",
					args = { "-" },
					stdin = true,
				}
			end,
		},
		yaml = {
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--parser", "yaml" },
					stdin = true,
				}
			end,
		},
		lua = {
			function()
				return {
					exe = "stylua",
					args = {
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
})

-- Keybinding for formatting
vim.api.nvim_set_keymap("n", "<leader>ft", "<cmd>Format<CR>", { noremap = true, silent = true })

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
augroup("__formatter__", { clear = true })
autocmd("BufWritePost", {
	group = "__formatter__",
	command = ":FormatWrite",
})

