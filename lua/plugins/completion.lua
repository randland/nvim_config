return {
  -- LSP Configuration
  'neovim/nvim-lspconfig',

  -- Autocompletion Framework
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',       -- LSP source for nvim-cmp
  'hrsh7th/cmp-buffer',          -- Buffer completions
  'hrsh7th/cmp-path',            -- Path completions
  'hrsh7th/cmp-cmdline',         -- Command line completions
  'L3MON4D3/LuaSnip',            -- Snippet engine
  'saadparwaiz1/cmp_luasnip',    -- Snippet completions

  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true,  -- Enable Treesitter integration for better pairing
      })
    end,
  },

  {
    'tpope/vim-endwise',
    config = function()
      -- No additional setup required; vim-endwise auto-detects Ruby files
    end,
  }
}
