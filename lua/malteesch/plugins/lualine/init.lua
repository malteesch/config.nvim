return {
    'nvim-lualine/lualine.nvim',
    config = function()
        local catppuccin = require 'lualine.themes.catppuccin-mocha'
        catppuccin.normal.c.bg = 'none'

        require('lualine').setup {
            options = {
                theme = catppuccin,
                icons_enabled = true,
                component_separators = '|',
                section_separators = '',
            },
            sections = {
                lualine_c = {
                    require("malteesch.plugins.lualine.filepath")
                },
            },
        }
    end,
}
