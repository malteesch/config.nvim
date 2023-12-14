-- vim.keymap.set('n', '<leader>fo', ':Neotree focus position=float<CR>')

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    require('neo-tree').setup {
      close_if_last_window = true,
      window = {
        position = 'float'
      },
      popup_border_style = 'rounded'
    }
  end,
  keys = {
    {'<leader>fo', '<cmd>Neotree focus position=float<CR>', 'n', desc = '[F]iletree [o]pen'},
    {'<leader>fc', '<cmd>Neotree focus position=float reveal_file=%<CR>', 'n', desc = '[F]iletree open [c]urrent file'}
  }
}
