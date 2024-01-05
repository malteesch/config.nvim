--- @type LazyPluginSpec
return {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
        open_mapping = [[<C-\>]],
        direction = 'horizontal',
        size = 30,
        autochdir = true,
        float_opts = {
            border = 'curved',
        },
    },
    -- stylua: ignore
    keys = {
        { [[<C-\>]] },
        -- { '<leader>lg',
        --     function()
        --         local Terminal = require('toggleterm.terminal').Terminal
        --         Terminal:new {
        --             cmd = 'lazygit',
        --             dir = vim.fn.getcwd(0),
        --             direction = 'float',
        --             hidden = true,
        --         }:toggle()
        --     end,
        --     desc = "[L]azy[g]it"
        -- },
        { '<leader>bt',
            function()
                local Terminal = require('toggleterm.terminal').Terminal
                Terminal:new {
                    cmd = 'btop',
                    direction = 'float',
                    hidden = true,
                }:toggle()
            end,
            desc = "[b][t]op"
        }
    },
}
