return {
   {
    'MunifTanjim/eslint.nvim',
    config = function()
      require('eslint').setup {
        bin = 'eslint_d',
        diagnostics_format = '[eslint] #{m}\n(#{c})',
      }
    end,
  },
}
