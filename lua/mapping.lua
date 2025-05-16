vim.g.mapleader = " "

-- Telescope config
local builtin = require("telescope.builtin")
local telescope = require("telescope")

vim.keymap.set("n", "ff", builtin.find_files, { desc = "fuzzy find files" })
vim.keymap.set(
	"n",
	"fg",
	":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>",
	{ desc = "live grep" }
)
vim.keymap.set(
	"n",
	"<leader>fr",
	builtin.lsp_references,
	{ desc = "show lsp references" }
)
vim.keymap.set("n", "<leader>lh", function()
	vim.lsp.buf.hover()
end, { desc = "lsp hover" })
vim.keymap.set("n", "<leader>lr", function()
	vim.lsp.buf.rename()
end, { desc = "rename symbol variable lsp" })
vim.keymap.set(
	"n",
	"fd",
	":Telescope projects<CR>",
	{ desc = "show projects" }
)

vim.keymap.set(
	"n",
	"<leader>co",
	":Telescope conflicts<CR>",
	{ desc = "show telescope git conflicts" }
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
vim.keymap.set(
	"n",
	"<leader>go",
	":Telescope conflicts<CR>",
	{ desc = "git conflicts telescope" }
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

local cmp = require('cmp')
local luasnip = require('luasnip')

local select_opts = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end
  },
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp', keyword_length = 1},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  },
  window = {
    documentation = cmp.config.window.bordered()
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }

      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),

    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    ['<C-f>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<C-b>'] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {'i', 's'}),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },
})

return
