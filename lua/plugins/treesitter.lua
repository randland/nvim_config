return { -- Syntax highlighting
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter.configs")
    treesitter.setup({
      ensure_installed = {
        "bash",
        "css",
        "javascript",
        "html",
        "json",
        "lua",
        "markdown",
        "python",
        "ruby",
        "scss",
        "sql",
        "xml",
        "yaml",
        "vue",
        "vim",
        "vimdoc",
      },
      highlight = { enable = true },
      indent = { enable = true },
    })
  end
}
