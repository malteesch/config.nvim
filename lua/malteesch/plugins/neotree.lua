return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
        'plenary',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
    },
    opts = {
        close_if_last_window = true,
        window = {
            position = 'left',
        },
        popup_border_style = 'rounded',
        enable_diagnostics = true,
        filesystem = {
            hijack_netrw_behavior = 'open_default',
            follow_current_file = {
                enabled = true,
            },
        },
        nesting_rules = {
            ['mod'] = { 'sum' },
            ['package.json'] = {
                pattern = '^package%.json$',
                files = { 'package-lock.json' },
            },
        },
    },
    keys = {
        { '<leader>fo', '<cmd>Neotree focus position=float<CR>', 'n', desc = '[o]pen' },
        { '<leader>fc', '<cmd>Neotree focus position=float reveal_file=%<CR>', 'n', desc = 'open [c]urrent file' },
        { '<leader>ff', '<cmd>Neotree toggle position=left<CR>', desc = '[f]ollow current file' },
    },
}
