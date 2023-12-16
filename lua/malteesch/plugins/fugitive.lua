return {
  'tpope/vim-fugitive',
  event = 'VeryLazy',
  keys = {
    { '<leader>gp', '<cmd>Git pull<CR>', desc = '[G]it [p]ull'},
    { '<leader>gP', '<cmd>Git push<CR>', desc = '[G]it [P]ush'},
    { '<leader>gl', function ()
      local cmdOutput = vim.fn.execute('Git remote get-url origin')
      if cmdOutput:match('fatal:') then
        vim.notify(cmdOutput:gsub("fatal: (.+)\n(.*)", "%1"), vim.log.levels.ERROR)
        return
      end
      if cmdOutput:match('error:') then
        vim.notify(cmdOutput:gsub("error: (.+)\n(.*)", "%1"), vim.log.levels.ERROR)
        return
      end
      local remoteUrl = cmdOutput:gsub(':', '/'):gsub('git@', 'https://'):gsub('%.git', ''):gsub('https///', 'https://')
      vim.fn.system({'xdg-open', remoteUrl})
    end, desc = 'Open in [G]it[L]ab (works with Github too)' }
  }
}

