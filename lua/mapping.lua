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

vim.keymap.set("n", "ff", builtin.find_files, { desc = "fuzzy find files" })
vim.keymap.set("n", "fg", builtin.live_grep, { desc = "live grep" })
vim.keymap.set(
	"n",
	"fd",
	":Telescope projects<CR>",
	{ desc = "show projects" }
)
vim.keymap.set(
	"n",
	"<leader>gs",
	builtin.git_status,
	{ desc = "show git status" }
)
vim.keymap.set(
	"n",
	"<leader>gc",
	builtin.git_commits,
	{ desc = "show git commits" }
)
vim.keymap.set(
	"n",
	"<leader>gb",
	builtin.git_branches,
	{ desc = "show git branches" }
)
vim.keymap.set("n", "<leader>m", builtin.marks, { desc = "show marks" })
vim.keymap.set(
	"n",
	"<leader>r",
	builtin.registers,
	{ desc = "show registers | copy paste" }
)

-- Telescope file
vim.keymap.set(
	"n",
	"fb",
	":Telescope file_browser<CR>",
	{ desc = "toggle file browser telescope" }
)

-- New File
vim.keymap.set(
	"n",
	"<leader>n",
	":enew<CR>",
	{ noremap = true, silent = true, desc = "new file" }
)

-- Add a tab (indent) to the selected lines
vim.api.nvim_set_keymap(
	"v",
	"tt",
	">gv",
	{ noremap = true, silent = true, desc = "add indent | tab" }
)

-- Remove a tab (unindent) from the selected lines
vim.api.nvim_set_keymap(
	"v",
	"tr",
	"<gv",
	{ noremap = true, silent = true, desc = "remove indent | tab" }
)

-- harpoon settings
local harpoon = require("harpoon")
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
	local file_paths = {}
	for _, item in ipairs(harpoon_files.items) do
		table.insert(file_paths, item.value)
	end

	require("telescope.pickers")
		.new({}, {
			prompt_title = "Harpoon",
			finder = require("telescope.finders").new_table({
				results = file_paths,
			}),
			previewer = conf.file_previewer({}),
			sorter = conf.generic_sorter({}),
		})
		:find()
end

vim.keymap.set("n", "<leader>a", function()
	harpoon:list():add()
end)

vim.keymap.set("n", "<leader>e", function()
	harpoon.ui:toggle_quick_menu(harpoon:list())
end)
return { cmp_mapping = cmp_mapping }
