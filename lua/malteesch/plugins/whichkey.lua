return {
    'folke/which-key.nvim',
    opts = {},
    config = function(_, opts)
        require('which-key').register({
            ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
            ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
            ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
            ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
            ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
            ['<leader>f'] = { name = '[F]ind/[F]iles', _ = 'which_key_ignore' },
            ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
        }, opts)
    end,
}
