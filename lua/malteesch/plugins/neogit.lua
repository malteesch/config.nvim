--- @type LazyPluginSpec
return {
  "NeogitOrg/neogit",
  dependencies = {
    "plenary",
    "telescope"
  },
  opts = {
    kind = "split",
    commit_editor = {
      kind = 'split'
    },
  },
  config = function (_, opts)
    local neogit = require('neogit')
    neogit.setup(opts)
    vim.keymap.set('n', '<leader>co', function () neogit.open({'commit'}) end)
  end,
}
