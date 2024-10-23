-- show relative and absolute line number
vim.opt.number = true
vim.opt.relativenumber = true

vim.o.tabstop = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.shiftwidth = 4

vim.g.python3_host_prog =
	"/Library/Frameworks/Python.framework/Versions/3.12/bin/python3.12"

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

-- set vim to use system clipboard
if vim.fn.has("unnamedplus") == 1 then
	vim.o.clipboard = "unnamedplus"
else
	vim.o.clipboard = "unnamed"
end

-- ignore DS_Store files
vim.opt.wildignore:append("*/.DS_Store")

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
