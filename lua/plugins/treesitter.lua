return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',  -- Auto-update parsers
  config = function()
    require('nvim-treesitter.configs').setup({
      ensure_installed = "maintained",  -- Install maintained parsers
      highlight = {
        enable = true,  -- Enable syntax highlighting
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
      indent = {
        enable = false,
      },
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
        "typescript",
        "xml",
        "yaml",
        "vue",
        "vim",
        "vimdoc",
      },
    })
  end,

  -- nvim-ts-autotag for automatic tag closing (Vue)
  {
    'windwp/nvim-ts-autotag',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  },
}
