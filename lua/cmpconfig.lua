local cmp = require("cmp")
local mapper = require("mapping")
local lsp = require("lspconfig")

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    }, {
        { name = "buffer" },
    }),
    mapping = mapper.cmp_mapping,
})

-- Setup lspconfig with the new default_capabilities method.
local capabilities = require("cmp_nvim_lsp").default_capabilities()
