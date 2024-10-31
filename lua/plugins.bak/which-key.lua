return {
  "folke/which-key.nvim",
  config = function()
    vim.keymap.set({ "n", "v" }, "<leader>k", ":WhichKey<cr>", { noremap = true })
    return {
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
      opts = {},
    }
  end,
}
