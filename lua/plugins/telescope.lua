return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',  -- Required dependency for async support
    'nvim-telescope/telescope-fzf-native.nvim',  -- Optional: for improved performance with FZF
    "nvim-lua/popup.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    "nvim-telescope/telescope-media-files.nvim",
    build = 'make',  -- For telescope-fzf-native
  },
  config = function()
    local builtin = require("telescope.builtin")
    local telescope = require('telescope')
    telescope.setup({
      defaults = {
        prompt_prefix = "> ",
        selection_caret = "> ",
        path_display = { "smart" },
        layout_config = {
          horizontal = { preview_width = 0.5 },
        },
        file_ignore_patterns = {
            ".*/vendor/*",
            ".*/node_modules/*",
            ".*/log/*",
            ".*%.gz",
            ".git/"
         },
      },
      pickers = {
        find_files = {
          -- theme = "dropdown",  -- Display files in a dropdown menu
        },
        buffers = {
          -- theme = "dropdown",
          sort_mru = true,  -- Sort buffers by most recently used
        },
        oldfiles = {
          cwd_only = true, -- Only show recent files in the current working directory
          path_display = { "truncate" }
        }
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown({}),
        },
        media_files = {
          find_cmd = "rg"
        },
        fzf = {
          fuzzy = true,  -- Fuzzy matching for best performance
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    -- Load the FZF extension for better fuzzy finding performance
    telescope.load_extension('fzf')

    -- Optional key mappings
    vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = 'Find Files' })
    vim.keymap.set("n", "<leader>a", builtin.live_grep, { desc = 'Live Grep'})
    vim.keymap.set("n", "<leader><S-a>", builtin.grep_string, { desc = 'Grep Current String' })
    vim.keymap.set("n", "<leader>fg", builtin.git_files, { desc = 'Git Files' })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = 'Buffers' })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = 'Help Tags' })
    vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = 'Recent Files' })
  end
}
