--- @type LazyPluginSpec
return {
    'folke/zen-mode.nvim',
    --- @type ZenOptions
    opts = {
        window = {
            backdrop = 1,
            width = 160,
        },
        plugins = {
            tmux = { enabled = true },
        },
    },
    dependencies = {
        {
            'folke/twilight.nvim',
            --- @type TwilightOptions
            opts = {
                expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
                    'constructor_declaration',
                    'function',
                    'method',
                    'method_declaration',
                    'table',
                },
            },
        },
    },
    --- stylua: ignore
    keys = {
        { '<leader>td', function() require('zen-mode').toggle() end, desc = '[d]istraction free mode'  },
    },
}
