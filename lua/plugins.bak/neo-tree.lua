return { -- File tree explorer
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim",
  },
  config = function()
    vim.keymap.set('n', '<leader>nt', ':Neotree show left toggle=true<CR>')
    vim.keymap.set('n', '<leader>nf', ':Neotree focus left reveal_file=%:p toggle=false<CR>')
    vim.keymap.set('n', '<leader>gn', ':Neotree float reveal_file=%:p reveal_force_cwd<CR>')
  end
}
