return {
  {
    'glepnir/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({
        code_action_prompt = { enable = false },  -- Customize as needed
        -- Additional configuration options
      })
    end,
  },
  {
    "w0ng/vim-hybrid",
    name = "hybrid",
    priority = 1000,
    config = function()
      vim.cmd("colorscheme hybrid")

      -- Set brighter colors for line numbers
      vim.api.nvim_set_hl(0, 'LineNr', { fg = '#cccccc' })
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#ffffff' })

      -- Define highlight group for trailing whitespace
      vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = '#ff0000', fg = 'NONE' })

      -- Autocommand to ensure ExtraWhitespace always has a red background after colorscheme change
      vim.api.nvim_create_autocmd('ColorScheme', {
        callback = function()
          vim.api.nvim_set_hl(0, 'ExtraWhitespace', { bg = '#ff0000', fg = 'NONE' })
        end,
      })

      -- Autocommands to highlight trailing whitespace
      vim.api.nvim_create_autocmd({ 'BufWinEnter', 'InsertLeave' }, {
        pattern = '*',
        callback = function()
          vim.fn.matchadd('ExtraWhitespace', [[\s\+$]])
        end,
      })

      vim.api.nvim_create_autocmd('InsertEnter', {
        pattern = '*',
        callback = function()
          vim.fn.matchadd('ExtraWhitespace', [[\s\+\%#\@<!$]])
        end,
      })
    end,
  },
  {                   -- Startup Screen
  "goolord/alpha-nvim",
  event = "VimEnter", -- load plugin after all configuration is set
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    dashboard.section.header.val = {
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                     ]],
      [[       ████ ██████           █████      ██                     ]],
      [[      ███████████             █████                             ]],
      [[      █████████ ███████████████████ ███   ███████████   ]],
      [[     █████████  ███    █████████████ █████ ██████████████   ]],
      [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
      [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
      [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
      [[                                                                       ]],
      [[                                                                       ]],
      [[                                                                       ]],
    }

    _Gopts = {
      position = "center",
      hl = "Type",
      -- wrap = "overflow";
    }

    -- Set menu
    dashboard.section.buttons.val = {
      -- dashboard.button("SPC j", "󰈚   Restore Session", ":SessionRestore<cr>"),
      dashboard.button("e", "   New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "   Find file", ":Telescope find_files<CR>"),
      dashboard.button("g", "󰱼   Find word", ":Telescope live_grep<CR>"),
      dashboard.button("r", "󱋡   Recent", ":Telescope oldfiles<CR>"),
      dashboard.button("c", "   Config", ":e $MYVIMRC <CR>"),
      dashboard.button("m", "󱌣   Mason", ":Mason<CR>"),
      dashboard.button("u", "󰂖   Update plugins", "<cmd>lua require('lazy').sync()<CR>"),
      dashboard.button("q", "   Quit NVIM", ":qa<CR>"),
    }

    dashboard.opts.opts.noautocmd = true
    alpha.setup(dashboard.opts)

    require("alpha").setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        local stats = require("lazy").stats()
        local count = (math.floor(stats.startuptime * 100) / 100)
        dashboard.section.footer.val = {
          "󱐌 " .. stats.count .. " plugins loaded in " .. count .. " ms",
          " ",
          "      Nick Karpenske",
        }
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
},
{
  "stevearc/dressing.nvim",
  config = function()
    require("dressing").setup({
      input = {
        min_width = { 60, 0.9 },
      },
      select = {
        -- telescope = require('telescope.themes').get_ivy({...})
        telescope = require("telescope.themes").get_dropdown({
          layout_config = { height = 15, width = 90 },
        }),
      },
    })
  end,
},
}
