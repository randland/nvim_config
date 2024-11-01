return {
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup({
      -- Add any configurations here
      mappings = {
        basic = true,  -- `gcc` to toggle line comment, `gbc` for block comment
        extra = true,  -- `gco` to comment out the line below, `gcO` for the line above
      },
    })
  end
}
