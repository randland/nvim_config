return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', opt = true },  -- Optional: for icons
  config = function()
    require('lualine').setup({
      options = {
        icons_enabled = true,
        theme = 'auto',  -- Automatically sets theme based on current colorscheme
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'NvimTree', 'neo-tree' },  -- Keep the status line clean in file explorers
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { 'mode' },  -- Shows current mode (e.g., INSERT, NORMAL)
        lualine_b = { 'branch', 'diff', 'diagnostics' },  -- Shows Git branch, diff, and diagnostics
        lualine_c = { { 'filename', path = 1 } },  -- Displays file path in full relative form
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { 'filename', path = 1 } },  -- Show filename even in inactive windows
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = { 'quickfix', 'fugitive', 'lazy' }  -- Additional integrations
    })
  end,
}
