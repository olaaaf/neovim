local cmp = require("cmp")

-- set the leader to space
vim.g.mapleader = " "

local cmp_mapping = {
	-- control + d to scroll documentation
	["<C-d>"] = cmp.mapping.scroll_docs(-4),
	-- control + f to scroll documentation
	["<C-f>"] = cmp.mapping.scroll_docs(4),
	-- control + space to trigger completion
	["<C-Space>"] = cmp.mapping.complete(),
	-- control + e to close completion
	["<C-e>"] = cmp.mapping.close(),
	-- enter to confirm completion
	["<CR>"] = cmp.mapping.confirm({ select = true }),
	-- arrow keys to navigate completion menu
	["<Down>"] = cmp.mapping.select_next_item(),
	["<Up>"] = cmp.mapping.select_prev_item(),
}

-- Telescope config
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>gs", builtin.git_status, {})
vim.keymap.set("n", "<leader>gc", builtin.git_commits, {})
vim.keymap.set("n", "<leader>gb", builtin.git_branches, {})
vim.keymap.set("n", "<leader>fm", builtin.marks, {})
vim.keymap.set("n", "<leader>rr", builtin.registers, {})

-- New File
vim.keymap.set("n", "<leader>n", ":enew<CR>", { noremap = true, silent = true })

-- Add a tab (indent) to the selected lines
vim.api.nvim_set_keymap("v", "<leader>tt", ">gv", { noremap = true, silent = true })

-- Remove a tab (unindent) from the selected lines
vim.api.nvim_set_keymap("v", "<leader>tr", "<gv", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>e", ":Neotree toggle<CR>", { noremap = true, silent = true })

return { cmp_mapping = cmp_mapping }

