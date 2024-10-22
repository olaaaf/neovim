-- show relative and absolute line number
vim.opt.number = true
vim.opt.relativenumber = true

vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.shiftwidth = 4

vim.g.python3_host_prog = "/Library/Frameworks/Python.framework/Versions/3.12/bin/python3.12"

vim.wo.fillchars = "eob: "
vim.g.vimtex_view_method = "skim"

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
require("telescope").setup({
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	defaults = {
		file_ignore_patterns = { ".git/" },
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
	},
})

require("neo-tree").setup({
	filesystem = {
		filtered_items = {
			visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
			hide_dotfiles = false,
			hide_gitignored = true,
		},
	},
})

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

-- Ensure a newline at the end of each file before saving
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*", -- Applies to all files
	callback = function()
		-- If the last line is not empty, add a new empty line
		if vim.fn.getline("$") ~= "" then
			vim.fn.append("$", "")
		end
	end,
})

-- set language
vim.o.langmenu = "en_US"

vim.cmd([[
highlight Normal ctermbg=NONE guifg=NONE guibg=NONE
highlight NonText ctermbg=NONE guifg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guifg=NONE guibg=NONE
highlight Folded ctermbg=NONE guifg=NONE guibg=NONE
highlight EndOfBuffer ctermbg=NONE guifg=NONE guibg=NONE
]])

vim.opt.ignorecase = true

