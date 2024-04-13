-- Servers list to configure
local servers = {
	"rust_analyzer",
	"clangd",
	"jdtls",
	"lua_ls",
	"marksman",
	"omnisharp",
	"pyright",
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
	local opts = { noremap = true, silent = true }

	-- Key mappings
	buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
	-- You can add other common key mappings here
end

local lspconfig = require("lspconfig")

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
	})
end
