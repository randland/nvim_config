return {
  'rust-lang/rust.vim',
  'jgdavey/vim-blockle',
  'christoomey/vim-sort-motion',
  'christoomey/vim-tmux-runner',
  'tpope/vim-surround',
  'tpope/vim-repeat',
  {
    'kana/vim-textobj-entire',
    dependencies = {
      'kana/vim-textobj-user',
    }
  }
}
