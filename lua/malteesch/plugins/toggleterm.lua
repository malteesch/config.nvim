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
    config = function(_, opts)
        local tt = require 'toggleterm'
        local Terminal = require('toggleterm.terminal').Terminal
        tt.setup(opts)

        local lazygit = Terminal:new {
            cmd = 'lazygit',
            direction = 'float',
            hidden = true,
        }

        local btop = Terminal:new {
            cmd = 'btop',
            direction = 'float',
            hidden = true,
        }

        vim.keymap.set('n', '<leader>lg', function()
            lazygit:toggle()
        end, { desc = 'Terminal: [l]azy[g]it' })
        vim.keymap.set('n', '<leader>bt', function()
            btop:toggle()
        end, { desc = 'Terminal: [b][t]op' })
    end,
}
