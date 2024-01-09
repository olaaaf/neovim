local cmp = require('cmp')
local mapping = require('mapping')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) 
        end,
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
    {
        { name = 'buffer' },
    }),
    mapping = mapping.cmp_mapping,
})

-- Setup lspconfig with the new default_capabilities method.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
