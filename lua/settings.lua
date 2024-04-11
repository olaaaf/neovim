-- show relative and absolute line number
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4       -- Set the width of a tab character
vim.opt.shiftwidth = 4
vim.opt.expandtab = true  -- Convert tabs to spaces

vim.g.python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.12/bin/python3.12'

vim.wo.fillchars='eob: '

local windline = require('wlsample.wind')

require('nvim-cursorline').setup {
    cursorline = {
        enable = false,
        timeout = 500,
        number = false,
    },
    cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
    }
}

require('telescope').setup()

require('nvim-tree').setup()

-- set vim to use system clipboard
if vim.fn.has("unnamedplus") == 1 then
    vim.o.clipboard = "unnamedplus"
else
    vim.o.clipboard = "unnamed"
end

-- ignore DS_Store files
vim.opt.wildignore:append '*/.DS_Store'
