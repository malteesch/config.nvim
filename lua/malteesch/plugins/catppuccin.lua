return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function(_, opts)
    require("catppuccin").setup(opts)
    vim.cmd.colorscheme 'catppuccin'
  end,
  opts = {
    flavour = 'mocha',
    integrations = {
      neotree = true,
      gitsigns = true,
      telescope = {
        enabled = true
      },
      which_key = true,
      mason = true,
      leap = true,
      harpoon = true,
      noice = true,
      cmp = true,
      fidget = true,
      notify = true,
      treesitter = true,
      lsp_trouble = true
    }
  }
}

