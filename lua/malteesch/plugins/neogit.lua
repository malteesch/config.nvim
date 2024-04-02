--- @type LazyPluginSpec
return {
  "NeogitOrg/neogit",
  branch = 'nightly',
  dependencies = {
    "plenary",
    "telescope",
    "sindrets/diffview.nvim"
  },
  opts = {
    kind = "split",
    commit_editor = {
      kind = 'split'
    },
    mappings = {
      status = {
        ['<C-c>'] = 'Close'
      }
    }
  },
  config = function (_, opts)
    local neogit = require('neogit')
    neogit.setup(opts)
    vim.keymap.set('n', '<leader>co', function () neogit.open({'commit'}) end)
    vim.keymap.set('n', '<leader>gp', function () neogit.open({'pull'}) end)
    vim.keymap.set('n', '<leader>gP', function () neogit.open({'push'}) end)
  end,
}
