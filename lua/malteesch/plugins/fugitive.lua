return {
  'tpope/vim-fugitive',
  keys = {
    { '<leader>gp', '<cmd>Git pull<CR>', desc = '[g]it [p]ull'},
    { '<leader>gl', function ()
      local remoteUrl = vim.fn.execute('Git remote get-url origin'):gsub(':(?!%/%/)', '/'):gsub('git@', 'https://'):gsub('%.git', '')
      vim.fn.system({'xdg-open', remoteUrl})
    end, desc = 'Open in [G]it[L]ab' }
  }
}

