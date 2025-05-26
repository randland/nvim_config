return {
  -- LSP Configuration
  'neovim/nvim-lspconfig',

  -- Autocompletion Framework
  -- {
  --   'hrsh7th/nvim-cmp',
  --   dependencies = {
  --     'hrsh7th/cmp-nvim-lsp',       -- LSP source for nvim-cmp
  --     'hrsh7th/cmp-buffer',         -- Buffer completions
  --     'hrsh7th/cmp-path',           -- Path completions
  --     'hrsh7th/cmp-cmdline',        -- Command line completions
  --     'L3MON4D3/LuaSnip',           -- Snippet engine
  --     'saadparwaiz1/cmp_luasnip',   -- Snippet completions
  --   },
  --   config = function()
  --     local cmp = require('cmp')
  --     local luasnip = require('luasnip')
  --
  --     cmp.setup({
  --       snippet = {
  --         expand = function(args)
  --           luasnip.lsp_expand(args.body)
  --         end,
  --       },
  --       mapping = {
  --         -- Arrow keys for navigation
  --         ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
  --         ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
  --
  --         -- Tab to confirm selection or expand snippet
  --         ['<Tab>'] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.confirm({ select = true }) -- Confirm selection
  --           elseif luasnip.expand_or_jumpable() then
  --             luasnip.expand_or_jump() -- Expand snippet if available
  --           else
  --             fallback() -- Insert Tab normally
  --           end
  --         end, { 'i', 's' }),
  --
  --         -- Other mappings
  --         ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Confirm only explicitly selected item
  --         ['<C-Space>'] = cmp.mapping.complete(), -- Trigger completion manually
  --         ['<C-e>'] = cmp.mapping.abort(), -- Close the completion menu
  --       },
  --       sources = cmp.config.sources({
  --         { name = 'nvim_lsp' },
  --         { name = 'luasnip' },
  --       }, {
  --         { name = 'buffer' },
  --       }),
  --     })
  --   end,
  -- },

  {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup({
        check_ts = true, -- Enable Treesitter integration for better pairing
      })
    end,
  },

  {
    'tpope/vim-endwise',
    config = function()
      -- No additional setup required; vim-endwise auto-detects Ruby files
    end,
  },
}
