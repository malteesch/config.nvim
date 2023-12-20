return {
  'tpope/vim-fugitive',
  event = 'VeryLazy',
  keys = {
    { '<leader>gp', '<cmd>Git pull<CR>', desc = '[G]it [p]ull'},
    { '<leader>gP', '<cmd>Git push<CR>', desc = '[G]it [P]ush'},
  }
}

