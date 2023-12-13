return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local catppuccin = require("lualine.themes.catppuccin-mocha")
    catppuccin.normal.c.bg = '#1E1E2E'

    require("lualine").setup {
        options = {
            theme = catppuccin,
            icons_enabled = true,
            component_separators = '|',
            section_separators = '',
        },
    }
  end
}
