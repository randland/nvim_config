return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- optional, for file icons
    'MunifTanjim/nui.nvim',
  },
  config = function()
    -- Disable the legacy netrw, as recommended for neo-tree
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require('neo-tree').setup({
      close_if_last_window = true,  -- Close Neo-tree if it's the last window
      popup_border_style = 'rounded',  -- Use rounded borders for popups
      enable_git_status = true,
      enable_diagnostics = true,
      window = {
        position = 'left',
        width = 35,
        mappings = {
          ['o'] = 'open',  -- Map 'o' to open files/folders
          ['<CR>'] = 'open',
          ['<C-v>'] = 'open_vsplit',  -- Open file in vertical split
          ['<C-x>'] = 'open_split',  -- Open file in horizontal split
          ['<C-t>'] = 'open_tabnew',  -- Open file in new tab
          ['<bs>'] = 'navigate_up',  -- Navigate up one directory
          ['.'] = 'toggle_hidden',  -- Toggle visibility of hidden files
        },
      },
      filesystem = {
        follow_current_file = true,  -- Keeps Neo-tree in sync with the current file
        hijack_netrw_behavior = 'open_current',  -- Adjusted for v3 behavior
        use_libuv_file_watcher = true,  -- Automatically watches files for updates
        filtered_items = {
          visible = true,  -- Show hidden files by default
          hide_gitignored = true,  -- Hide .gitignored files
          hide_dotfiles = false,
        },
      },
      buffers = {
        show_unloaded = true,
      },
      git_status = {
        window = {
          position = 'float',
        },
      },
    })

    -- Optional key mappings to toggle and focus Neo-tree
    vim.keymap.set('n', '<leader>nt', ':Neotree toggle<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<leader>nf', ':Neotree focus<CR>', { silent = true, noremap = true })
    vim.keymap.set('n', '<leader>n<leader>', function()
      require('neo-tree.command').execute({
        source = 'filesystem',
        position = 'float',  -- Open in a floating window
        reveal = true,       -- Highlight the current file
      })
    end, { silent = true, noremap = true, desc = 'Open Neo-tree Float with Current File Highlighted' })
    vim.keymap.set('n', '<leader>ng', function()
      require('neo-tree.command').execute({
        source = 'git_status', -- Use the Git source to show only modified files
        position = 'float',    -- Optional: Open in a floating window
      })
    end, { silent = true, noremap = true, desc = 'Open Neo-tree Git Status' })
  end,
}
