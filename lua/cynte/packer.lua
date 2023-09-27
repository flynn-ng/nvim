-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    -- Telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    -- Material Colorscheme
    use({
        'marko-cerovac/material.nvim',
        as = 'material',
        config = function()
            vim.cmd('colorscheme material')
            vim.g.material_style = "deep ocean"
        end
    })
    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    -- Treesitter Playground
    use('nvim-treesitter/playground')
    -- Undo Tree
    use 'mbbill/undotree'
    -- Vim Fugitive
    use 'tpope/vim-fugitive'
    -- LSP-Zero
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            {
                'williamboman/mason.nvim',
                run = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'L3MON4D3/LuaSnip' },
        }
    }
    -- Flutter Tools
    use {
        'akinsho/flutter-tools.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'stevearc/dressing.nvim', -- optional for vim.ui.select
        },
    }
    -- liveserver
    -- use 'manzeloth/live-server'
    use { 'j-hui/fidget.nvim',
        tag = "legacy",
    }
    use 'windwp/nvim-autopairs'
    -- Harpoon
    use 'ThePrimeagen/harpoon'
    -- LuaLine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }
    -- Trouble
    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {}
        end
    })
    -- Nvim Tree
    -- use 'nvim-tree/nvim-tree.lua'
end)
