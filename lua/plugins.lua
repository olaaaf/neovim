vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'neovim/nvim-lspconfig'
    -- Mason plugin
    use {
        'williamboman/mason.nvim',
	config = function()
		require('mason').setup()	
	end
    }
    use {
	'williamboman/mason-lspconfig.nvim',
	config = function()
		require('mason-lspconfig').setup()
	end
    }
    use 'hrsh7th/nvim-cmp'  -- The completion plugin
    use 'hrsh7th/cmp-buffer'  -- Buffer completions
    use 'hrsh7th/cmp-path'  -- Path completions
    use 'hrsh7th/cmp-cmdline'  -- Cmdline completions
    use 'hrsh7th/cmp-nvim-lsp'  -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip'  -- Snippet completions
    use 'L3MON4D3/LuaSnip'  -- Snippet engine
    use 'windwp/windline.nvim' -- Status line with animation
    use 'yamatsum/nvim-cursorline' -- Cursor line
    use 'gennaro-tedesco/nvim-peekup' -- Better register peekup
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim' -- File search
    use {
        'kyazdani42/nvim-tree.lua',
        requires = {
            'kyazdani42/nvim-web-devicons',
        },
    }
end)
