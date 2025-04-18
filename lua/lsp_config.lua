-- Servers list to configure
local servers = {
	"rust_analyzer",
	"clangd",
	"jdtls",
	"lua_ls",
	"marksman",
	"omnisharp",
	"pyright",
	"ruff",
	"zls",
}

require("mason").setup() -- Initialize mason
require("mason-lspconfig").setup({
	ensure_installed = servers,
})
-- Function to attach to every LSP server
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local opts = { noremap = true, silent = true, desc = "show definition" }

	-- Key mappings
	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	-- You can add other common key mappings here
end

local lspconfig = require("lspconfig")
local coq = require("coq")

local custom_settings = {
	clangd = {},
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup(coq.lsp_ensure_capabilities({
		on_attach = on_attach,
	}))
end

coq.Now()

require("lsp_signature").setup({
	transparency = 0,
})

vim.keymap.set({ "n" }, "<C-k>", function()
	require("lsp_signature").toggle_float_win()
end, { silent = true, noremap = true, desc = "toggle arguments help" })

-- linter
config = function()
	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		callback = function()
			require("lint").try_lint()
		end,
	})
end

-- default configuration
require('illuminate').configure({
    -- providers: provider used to get references in the buffer, ordered by priority
    providers = {
        'lsp',
        'treesitter',
        'regex',
    },
    -- delay: delay in milliseconds
    delay = 100,
    -- filetype_overrides: filetype specific overrides.
    -- The keys are strings to represent the filetype while the values are tables that
    -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
    filetype_overrides = {},
    -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
    filetypes_denylist = {
        'dirbuf',
        'dirvish',
        'fugitive',
    },
    -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
    -- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
    filetypes_allowlist = {},
    -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
    -- See `:help mode()` for possible values
    modes_denylist = {},
    -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
    -- See `:help mode()` for possible values
    modes_allowlist = {},
    -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_denylist = {},
    -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
    -- Only applies to the 'regex' provider
    -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
    providers_regex_syntax_allowlist = {},
    -- under_cursor: whether or not to illuminate under the cursor
    under_cursor = true,
    -- large_file_cutoff: number of lines at which to use large_file_config
    -- The `under_cursor` option is disabled when this cutoff is hit
    large_file_cutoff = 10000,
    -- large_file_config: config to use for large files (based on large_file_cutoff).
    -- Supports the same keys passed to .configure
    -- If nil, vim-illuminate will be disabled for large files.
    large_file_overrides = nil,
    -- min_count_to_highlight: minimum number of matches required to perform highlighting
    min_count_to_highlight = 1,
    -- should_enable: a callback that overrides all other settings to
    -- enable/disable illumination. This will be called a lot so don't do
    -- anything expensive in it.
    should_enable = function(bufnr) return true end,
    -- case_insensitive_regex: sets regex case sensitivity
    case_insensitive_regex = false,
    -- disable_keymaps: disable default keymaps
    disable_keymaps = false,
})
