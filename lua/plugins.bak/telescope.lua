return { -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-media-files.nvim",
    },
    config = function()
      local builtin = require("telescope.builtin")
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          file_ignore_patterns = {
            ".*/vendor/*",
            ".*/node_modules/*",
            ".*/log/*",
            ".*%.gz",
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
          media_files = {
            find_cmd = "rg"
          },
        },
      })

      vim.keymap.set("n", "<leader><leader>", builtin.find_files, {})
      vim.keymap.set("n", "<leader>a", builtin.live_grep, {})
      vim.keymap.set("n", "<leader><S-a>", builtin.grep_string, {})
      vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

      telescope.load_extension("media_files")
      telescope.load_extension("ui-select")
    end,
  },
}
