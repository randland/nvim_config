return {
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      vim.keymap.set("n", "<leader>gg", ":LazyGit<cr>")
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()

      vim.keymap.set("n", "<leader>gp", ":Gitsigns preview_hunk<cr>", { noremap = true })
      vim.keymap.set("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<cr>", { noremap = true })
    end,
  },
  {
    "tpope/vim-fugitive",
  },

  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup({
        current_line_blame = true,        -- Enable inline blame for the current line
        current_line_blame_opts = {
          delay = 10,                   -- Delay before blame appears (in milliseconds)
          virt_text_pos = 'eol',          -- Position blame text at the end of the line
        },
        current_line_blame_formatter = '    <author>, <author_time:%Y-%m-%d> - <summary>',
      })
      vim.keymap.set('n', '<leader>gb', function()
        require('gitsigns').toggle_current_line_blame()
      end, { desc = "Toggle Git Blame for Current Line" })
    end,
    on_attach = function()
      -- Set the blame color to a mid-tone gray between the hybrid.vim background and foreground
      vim.api.nvim_set_hl(0, 'GitSignsCurrentLineBlame', { fg = '#6b6d6f', italic = true })
    end,
  },
}
