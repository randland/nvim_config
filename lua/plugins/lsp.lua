return {
  -- LSP configuration for Vue (Volar) and Ruby (Solargraph)
  {
    'neovim/nvim-lspconfig',
    config = function()
      local lspconfig = require('lspconfig')
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- Setup Volar for Vue
      lspconfig.volar.setup {
        filetypes = { 'javascript', 'javascriptreact', 'vue', 'json' },  -- Limit to JavaScript-related files only
        on_new_config = function(new_config, new_root_dir)
          new_config.init_options = {
            typescript = { tsdk = '' },  -- Override TypeScript SDK path to prevent loading TypeScript
          }
          new_config.settings = {
            volar = {
              languageFeatures = {
                diagnostics = { typescript = false },  -- Disable TypeScript diagnostics
              },
              disableTsPlugin = true,  -- Disable TypeScript features
            },
          }
        end,
      }

      -- Setup Solargraph for Ruby
      lspconfig.solargraph.setup {
        -- capabilities = capabilities,
        settings = {
          solargraph = {
            diagnostics = true,
            completion = true,
          },
        },
      }

      lspconfig.ts_ls.setup {
        filetypes = { 'javascript', 'javascriptreact', 'json' },  -- Only JavaScript and JSON
      }

      -- Setup for Lua Language Server
      lspconfig.lua_ls.setup {
        -- capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' },  -- Recognize 'vim' as a global variable
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),  -- Make the server aware of Neovim runtime files
            },
            telemetry = { enable = false },
          },
        },
      }

      -- Configure other LSP servers if needed
      lspconfig.pyright.setup {}         -- Python
    end,
  },

  -- Install mason.nvim if not already done
  {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup()
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = { 'neovim/nvim-lspconfig' },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls" },  -- Automatically install lua_ls
      }
    end,
  },

  -- Autocompletion setup
  -- {
  --   'hrsh7th/nvim-cmp',
  --   dependencies = {
  --     'hrsh7th/cmp-nvim-lsp',      -- LSP source for nvim-cmp
  --     'hrsh7th/cmp-buffer',        -- Buffer completions
  --     'hrsh7th/cmp-path',          -- Path completions
  --     'hrsh7th/cmp-cmdline',       -- Command line completions
  --     'L3MON4D3/LuaSnip',          -- Snippet engine
  --     'saadparwaiz1/cmp_luasnip',  -- Snippet completions
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
  --       mapping = cmp.mapping.preset.insert({
  --         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  --         ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --         ['<C-Space>'] = cmp.mapping.complete(),
  --         ['<CR>'] = cmp.mapping.confirm({ select = true }),
  --         ['<Tab>'] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_next_item()
  --           elseif luasnip.expand_or_jumpable() then
  --             luasnip.expand_or_jump()
  --           else
  --             fallback()
  --           end
  --         end, { 'i', 's' }),
  --         ['<S-Tab>'] = cmp.mapping(function(fallback)
  --           if cmp.visible() then
  --             cmp.select_prev_item()
  --           elseif luasnip.jumpable(-1) then
  --             luasnip.jump(-1)
  --           else
  --             fallback()
  --           end
  --         end, { 'i', 's' }),
  --       }),
  --       sources = cmp.config.sources({
  --         { name = 'nvim_lsp' },
  --         { name = 'luasnip' },
  --       }, {
  --         { name = 'buffer' },
  --       })
  --     })
  --   end,
  -- },

  -- eslint.nvim for linting (JavaScript and Vue)
  {
    'MunifTanjim/eslint.nvim',
    config = function()
      require('eslint').setup {
        bin = 'eslint_d',
        diagnostics_format = '[eslint] #{m}\n(#{c})',
      }
    end,
  },

  -- prettier.nvim for code formatting (JavaScript, Vue, and CSS)
  {
    'MunifTanjim/prettier.nvim',
    config = function()
      require('prettier').setup {
        bin = 'prettier',
        filetypes = { 'javascript', 'typescript', 'css', 'json', 'html', 'vue' },
      }
    end,
  },

  -- rails.vim for Rails-specific navigation and utilities
  {
    'tpope/vim-rails',
    config = function()
      -- No additional setup required; vim-rails automatically detects Rails projects
    end,
  },

  -- vim-endwise for auto-inserting `end` in Ruby
  {
    'tpope/vim-endwise',
    config = function()
      -- Automatically inserts `end` in Ruby and other languages
    end,
  },

  -- faster Ruby linting with RuboCop
  {
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        ruby = { 'rubocop' },
      }
    end,
  },
}
