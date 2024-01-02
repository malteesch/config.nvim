return {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
        'MunifTanjim/nui.nvim',
    },
    lazy = false,
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
    },
    keys = {
        { '<leader>fo', '<cmd>Neotree focus position=float<CR>', 'n', desc = '[o]pen' },
        { '<leader>fc', '<cmd>Neotree focus position=float reveal_file=%<CR>', 'n', desc = 'open [c]urrent file' },
        { '<leader>ff', '<cmd>Neotree toggle position=left<CR>', desc = '[f]ollow current file' },
    },
}
