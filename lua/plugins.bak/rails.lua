return {
  'weizheheng/ror.nvim',
  config = function()
    vim.keymap.set("n", "<Leader>rc", ":lua require('ror.commands').list_commands()<CR>", { silent = true, noremap = true })
  end
}
