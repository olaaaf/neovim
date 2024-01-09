local cmp = require('cmp')

local cmp_mapping = {
        -- control + d to scroll documentation
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        -- control + f to scroll documentation
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        -- control + space to trigger completion
        ['<C-Space>'] = cmp.mapping.complete(),
        -- control + e to close completion
        ['<C-e>'] = cmp.mapping.close(),
        -- enter to confirm completion
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        -- arrow keys to navigate completion menu
        ['<Down>'] = cmp.mapping.select_next_item(),
        ['<Up>'] = cmp.mapping.select_prev_item(),
}

return {cmp_mapping = cmp_mapping}
